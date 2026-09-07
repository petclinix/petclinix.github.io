---
title: Implementations - **PetcliniX**
permalink: /implementations/
---

# 🏗️ Implementations

This page lists the available **PetcliniX** showcases as they're built.
Each one implements the same [domain model](petclinix_domainmodel.md) and functionality requirements, but with a different paradigm, language, or architecture.
Explore the repositories to compare trade-offs directly.

Building only a frontend or only a backend? You don't need to build the other half from scratch —
see the shared **[API reference](/api/)** for the contract you can build against (or implement).

---

## At a Glance

| Implementation | Paradigm | Stack | Summary |
|---|---|---|---|
| [java-springboot-react-mtier](https://github.com/petclinix/java-springboot-react-mtier) | Classic layered monolith | Java 21 · Spring Boot 3.5 · React 19 · MariaDB | Spring Boot REST backend + React SPA frontend behind Nginx, with JWT auth and a Docker Compose setup. |
| [php-twig-mtier](https://github.com/petclinix/php-twig-mtier) | Server-rendered MVC | PHP · Twig · MariaDB (PDO) | Classic server-rendered PHP MVC with hand-rolled PDO instead of an ORM, in a thin Controller → Service → Repository → Domain architecture. |
| [rust-axum-vslice](https://github.com/petclinix/rust-axum-vslice) | Vertical slices, no database | Rust · axum · JSON files on disk | Files-instead-of-a-database JSON API: each feature module owns its handlers and file I/O end to end, with `flock` (not a DB transaction) preventing double-booking. |

---

## [java-springboot-react-mtier](https://github.com/petclinix/java-springboot-react-mtier)

*A veterinary clinic management system implemented as a classic layered monolith: Spring Boot REST backend and React SPA frontend.*

- **Paradigm:** Classic layered monolith
- **Backend:** Java 21, Spring Boot 3.5, Spring Security, JPA/Hibernate
- **Frontend:** React 19, TypeScript, Vite, TailwindCSS
- **Database:** MariaDB 11.1 (H2 for tests)
- **Auth:** JWT (HS256, 1-hour expiry)
- **Infra:** Docker Compose with Nginx ingress
- **Run it:** `docker compose up --build` → [http://localhost:8080](http://localhost:8080)

---

## [php-twig-mtier](https://github.com/petclinix/php-twig-mtier)

*A veterinary clinic management system implemented as classic server-rendered PHP MVC, with hand-rolled PDO instead of an ORM.*

- **Paradigm:** Server-rendered MVC, layered architecture (Controller → Service → Repository → Domain)
- **Backend:** PHP, Twig templating, direct SQL via PDO (no ORM)
- **Database:** MariaDB
- **Testing:** PHPUnit (unit), Playwright (E2E)
- **Code quality:** php-cs-fixer, PHPStan (level 8), Deptrac
- **Infra:** Docker Compose
- **Run it:** `docker compose up --build` → [http://localhost:8080](http://localhost:8080) (self-register or use seeded `admin@petclinix.local` / `admin12345`)

---

## [rust-axum-vslice](https://github.com/petclinix/rust-axum-vslice)

*A veterinary clinic management system implemented as a files-instead-of-a-database JSON API, the deliberate opposite of the other DB-backed layered implementations.*

- **Paradigm:** Vertical slices — each feature module owns its HTTP handlers, on-disk record shapes, and file I/O end to end, no cross-entity Repository abstraction
- **Backend:** Rust, axum, JSON files on disk (no database)
- **Concurrency:** No double-booking enforced via an OS-level advisory file lock per vet (`flock`), not a database transaction
- **Auth:** JWT (HS256, 1-hour expiry), argon2 password hashing
- **API:** JSON REST only, no bundled frontend (can be pointed at `java-springboot-react-mtier`'s React frontend)
- **Testing:** `cargo test` — unit, in-process HTTP per slice, and black-box HTTP tests via `reqwest`
- **Code quality:** `cargo fmt`, `cargo clippy -D warnings`, SonarQube
- **Infra:** Docker Compose
- **Run it:** `docker compose up --build` → [http://localhost:8080/health](http://localhost:8080/health) (self-register or use seeded `admin@petclinix.local` / `admin12345`)

---

Want to add your own paradigm to this list?
See the [rules for a showcase](index.md) and the [project goals](about.md).
