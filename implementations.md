---
title: Implementations - **PetcliniX**
permalink: /implementations/
---

# 🏗️ Implementations

This page lists the available **PetcliniX** showcases as they're built. Each one implements the same
[domain model](petclinix_domainmodel.md) and functionality requirements, but with a different paradigm, language, or
architecture. Explore the repositories to compare trade-offs directly.

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

Want to add your own paradigm to this list? See the [rules for a showcase](index.md) and the [project goals](about.md).
