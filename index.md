# 🐾 **PetcliniX** – Proof your paradigm

Welcome to **PetcliniX**, your launchpad for architectural creativity and technical excellence.
Inspired by the legendary Spring Petclinic, this project invites developers to build, break, and boldly explore software paradigms in a familiar yet flexible environment.
Whether you're into building the next ⭐ framework, crafting microservices, designing event-driven systems, applying clean architecture, exploring bleeding-edge tech stacks — or proving that plain C is still king — **PetcliniX** is your canvas.

**Proof your paradigm.**


---

## 🏗️ See PetcliniX in Action

Don't just read about it — explore a real, running implementation.
👉 **[Browse the available implementations](implementations.md)** to see how different teams tackled the same domain with different paradigms and tech stacks.

---

## 🚀 What is **PetcliniX**?

**PetcliniX** is more than a demo — it's a developer-driven showcase.
It offers a realistic domain to:

* Prototype your favorite architecture or design pattern
* Validate ideas in a runnable, extensible environment
* Share your best practices with the community
* Inspire others with your technical craftsmanship

Create your own **PetcliniX** flavor.
Show us how you think software should be built.

Read more about the [goals](about.md) of the project.

---

## 🎯 Project Goals

- ✅ Showcase multiple technologies and architectural styles
- ✅ Encourage experimentation and learning
- ✅ Serve as a reference for best practices


---

## 🚀 Rules for a Showcase

To keep **PetcliniX** showcases consistent, accessible, and inspiring, please follow these guidelines when creating your own flavor:


1. **Functionality**:
Implement the application so that all features listed under 'Functionality Requirements' are fulfilled.

2. **Repository Naming**:
The repository name must include the main  programming language, the backend framework and optional the frontend framework and a short descriptor (e.g., java-spring-react-mtier).

3. **README Requirements**:
Your README.md must:
    * Clearly explain the idea or paradigm being showcased.
    * Include instructions on how to run the project locally or in a containerized environment.

4. **Executable Setup**:
The repository must contain either:
    * A docker-compose.yml file, or
    * A k8s/ folder with Kubernetes manifests

    to ensure all required components can be launched easily.


---

## 🖥️ Functionality Requirements from End-User Perspective

The application can handle three different roles.

> **Design note — depth over breadth.** PetcliniX is meant to be understood and reviewed in one sitting.
> Most features below are intentionally plain CRUD — that part of the domain is well covered by tutorials.
> **Appointment scheduling is the deliberate exception.** It's where the real business logic lives, and it's
> the feature every implementation is expected to handle properly (see the [Domain Model](petclinix_domainmodel.md)
> for the lifecycle and rules). Don't try to compensate for its simplicity elsewhere by adding more domains
> (billing, inventory, etc.) — that dilutes the "grok it in one session" goal without adding architectural insight.

### 👥 Roles

- **Pet Owner** — a clinic customer who owns one or more pets.
- **Veterinarian** — the vet and any clinic staff working the front line: booking, appointments, treatment.
- **Admin** — a technical/system administrator, not clinic staff. Operates the platform itself
  (e.g. deactivating a banned owner or vet account, monitoring system activity) rather than
  treating pets or managing appointments.

#### Pet Owner
- View and manage pets
- Book appointments
- View visit history

#### Veterinarian
- Define availability and time slots
- View and manage appointments
- Document visits

#### Admin
- Manage user accounts (list, deactivate)
- Monitor booking activity and view stats

### 🖥️ Features

#### 🧍‍♂️ Pet Owner Features

- Register/Login (simple, no mail challenges or OAuth needed)
- Add Pet (name, type, breed, picture upload — *storage location is an implementation detail: keep the
  image out of the primary database (filesystem or object storage, referenced by URL); this is not a
  paradigm-differentiating concern and doesn't need review-session attention*)
- View Pet Profile (with diagnosis & vaccination history)
- Book Appointment (select vet, time slot — only truly open slots may be offered/accepted, see
  [Appointment Business Rules](#appointment-business-rules))
- Cancel or Reschedule Appointment (subject to the cancellation cutoff rule)


#### 🩺 Vet Features

- Register/Login (simple, no mail challenges or OAuth needed)
- Set Availability (recurring weekly schedule, plus one-off exceptions such as vacation or sick leave)
- View and Manage Appointments (confirm, mark completed, mark no-show)
- Record Visit (diagnosis, vaccination, notes), Pet Owner can view the visits


#### 🛠️ Admin Features

- User Management (list, deactivate users)
- Basic Activity Logs (last login, actions)
- Simple Stats Dashboard (e.g., # of pets, appointments per vet)


### Appointment Business Rules

This is the feature every implementation must handle correctly — plain CRUD or a single DB
uniqueness constraint is not sufficient. It's meant to expose how differently each paradigm
handles derived state, concurrency, and lifecycle logic.

1. **Availability is derived, not stored.** A bookable slot = the vet's recurring weekly
   availability, minus already-booked appointments, minus one-off exceptions (vacation/sick leave).
   Nothing about "free slots" is persisted directly.
2. **Variable duration.** Appointments have a duration (depending on visit type), so conflict
   checking is a time-range overlap, not an equality check on a single timestamp.
3. **No double-booking under concurrency.** Two owners attempting to book the same (or an
   overlapping) slot at the same time must not both succeed. This must hold under real concurrent
   requests, not just sequential testing.
4. **Lifecycle / state machine.** `booked → confirmed → completed / cancelled / no-show`. Invalid
   transitions (e.g. completing a cancelled appointment) must be rejected.
5. **Cancellation cutoff.** Cancelling or rescheduling is only allowed until a defined cutoff before
   the slot (e.g. 2 hours). A reschedule is a cancel+rebook that is still subject to rule 3.


---

## 🌐 Get Started
Ready to showcase your paradigm?
Here's how to join the **PetcliniX** movement:

1. Fork or create your own repository based on existing **PetcliniX** GitHub Repositories or start from scratch with **PetcliniX** GitHub template.
2. Name your repo to reflect the main framework or programming language you're using—plus any extra context you'd like to share.
3. Include a clear and concise README that:

    1. Explains your chosen architecture or design idea
    2. Provides setup instructions so others can run your project easily

4. Add either a docker-compose.yml or a k8s/ folder to orchestrate all required components.

You can use the recommended [Domain Model](petclinix_domainmodel.md) as a starting point—or define your own if your paradigm calls for it.

---
