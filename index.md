# 🐾 **PetcliniX** – Proof your paradigm

Welcome to **PetcliniX**, your launchpad for architectural creativity and technical excellence. Inspired by the legendary 
Spring Petclinic, this project invites developers to build, break, and boldly explore software paradigms in a familiar yet 
flexible environment.
Whether you're into building the next ⭐ framework, crafting microservices, designing event-driven systems, applying clean 
architecture, exploring bleeding-edge tech stacks — or proving that plain C is still king — **PetcliniX** is your canvas.

**Proof your paradigm.**


---

## 🚀 What is **PetcliniX**?

**PetcliniX** is more than a demo — it's a developer-driven showcase. It offers a realistic domain to:

* Prototype your favorite architecture or design pattern
* Validate ideas in a runnable, extensible environment
* Share your best practices with the community
* Inspire others with your technical craftsmanship

Create your own **PetcliniX** flavor. Show us how you think software should be built.

Read more about the [goals](about.md) of the project.

---

## 🎯 Project Goals

- ✅ Showcase multiple technologies and architectural styles
- ✅ Encourage experimentation and learning
- ✅ Serve as a reference for best practices


---

## 🏗️ Implementations

See **PetcliniX** in action. Browse the [available implementations](implementations.md) to explore how different
teams tackled the same domain with different paradigms and tech stacks.

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

### 👥 Roles

#### Pet Owner
- View and manage pets
- Book appointments
- View visit history

#### Veterinarian
- Define availability and time slots
- View and manage appointments
- Document visits

#### Admin / Clinic Staff
- Manage owners, pets, vets, and appointments
- Monitor booking activity

### 🖥️ Features

#### 🧍‍♂️ Pet Owner Features

- Register/Login (simple, no mail challenges or OAuth needed)
- Add Pet (name, type, breed, picture upload)
- View Pet Profile (with diagnosis & vaccination history)
- Book Appointment (select vet, time slot)


#### 🩺 Vet Features

- Register/Login (simple, no mail challenges or OAuth needed)
- Set Availability (weekly schedule, bookable slots)
- View Appointments
- Record Visit (diagnosis, vaccination, notes), Pet Owner can view the visits


#### 🛠️ Admin Features

- User Management (list, deactivate users)
- Basic Activity Logs (last login, actions)
- Simple Stats Dashboard (e.g., # of pets, appointments per vet)


---

## 🌐 Get Started
Ready to showcase your paradigm? Here's how to join the **PetcliniX** movement:

1. Fork or create your own repository based on existing **PetcliniX** GitHub Repositories or start from scratch with **PetcliniX** GitHub template.
2. Name your repo to reflect the main framework or programming language you're using—plus any extra context you'd like to share.
3. Include a clear and concise README that:

    1. Explains your chosen architecture or design idea
    2. Provides setup instructions so others can run your project easily

4. Add either a docker-compose.yml or a k8s/ folder to orchestrate all required components.

You can use the recommended [Domain Model](petclinix_domainmodel.md) as a starting point—or define your own if your paradigm calls for it.

---
