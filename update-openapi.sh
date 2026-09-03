#!/usr/bin/env bash
# Regenerates openapi.json from the latest published backend image
# (ghcr.io/petclinix/springboot-backend:latest) and copies it into the
# sibling petclinix.github.io repo. Run manually after a change to the
# API surface has been published.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="$SCRIPT_DIR/openapi.json"

IMAGE="ghcr.io/petclinix/springboot-backend:latest"
NETWORK="petclinix-openapi-tmp"
DB_CONTAINER="petclinix-openapi-db"
BACKEND_CONTAINER="petclinix-openapi-backend"

for cmd in docker jq; do
  command -v "$cmd" >/dev/null || { echo "error: $cmd is required" >&2; exit 1; }
done

if [ ! -d "$(dirname "$OUTPUT_FILE")" ]; then
  echo "error: $(dirname "$OUTPUT_FILE") not found (expected the petclinix.github.io repo checked out next to this one)" >&2
  exit 1
fi

cleanup() {
  docker rm -f "$BACKEND_CONTAINER" "$DB_CONTAINER" >/dev/null 2>&1 || true
  docker network rm "$NETWORK" >/dev/null 2>&1 || true
}
trap cleanup EXIT

cleanup # remove any leftovers from a previous failed run

echo "Pulling $IMAGE ..."
docker pull "$IMAGE"

docker network create "$NETWORK" >/dev/null

echo "Starting temporary database ..."
docker run -d --name "$DB_CONTAINER" --network "$NETWORK" \
  -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=1 \
  -e MARIADB_DATABASE=petclinix_db \
  -e MARIADB_USER=petclinix \
  -e MARIADB_PASSWORD=secr3t! \
  mariadb:11.1 >/dev/null

echo -n "Waiting for database to be ready"
for _ in $(seq 1 30); do
  if docker exec "$DB_CONTAINER" mariadb-admin ping -h 127.0.0.1 --silent >/dev/null 2>&1; then
    echo " ready"
    break
  fi
  echo -n "."
  sleep 2
done

echo "Starting backend ($IMAGE) ..."
docker run -d --name "$BACKEND_CONTAINER" --network "$NETWORK" \
  -e DATABASE_HOST="$DB_CONTAINER" \
  -e DATABASE_PORT=3306 \
  -e DATABASE_NAME=petclinix_db \
  -e DATABASE_USER=petclinix \
  -e DATABASE_PASSWORD=secr3t! \
  -e SPRING_JPA_HIBERNATE_DDL_AUTO=update \
  -e JWT_SECRET=TemporaryKeyForOpenApiGenerationWhichIsLongEnough \
  -e JWT_EXPIRATIONMS=3600000 \
  -e ADMIN_USERNAME=admin \
  -e ADMIN_PASSWORD=temporary-password \
  "$IMAGE" >/dev/null

echo -n "Waiting for backend to serve the OpenAPI spec"
READY=""
for _ in $(seq 1 30); do
  CODE="$(docker run --rm --network "$NETWORK" curlimages/curl:latest \
    -s -o /dev/null -w '%{http_code}' "http://$BACKEND_CONTAINER:8080/api/v3/api-docs" || true)"
  if [ "$CODE" = "200" ]; then
    READY=1
    echo " ready"
    break
  fi
  echo -n "."
  sleep 2
done

if [ -z "$READY" ]; then
  echo "error: backend did not become ready in time" >&2
  docker logs "$BACKEND_CONTAINER" >&2 || true
  exit 1
fi

docker run --rm --network "$NETWORK" curlimages/curl:latest \
  -s "http://$BACKEND_CONTAINER:8080/api/v3/api-docs" | jq . > "$OUTPUT_FILE"

echo "Wrote $OUTPUT_FILE"
