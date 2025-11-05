# 🧩 Domain Model - Recommendation

```mermaid
erDiagram
    USER {
        UUID id PK
        STRING username
        STRING passwordHash
        BOOLEAN isActive
        BOOLEAN isAdmin
        DATETIME lastLogin
    }
    USER ||--|| OWNER : is
    USER ||--|| VET : is
    USER ||--|| ACTIVITY_LOG : logs

    OWNER {
        UUID id PK
    }
    OWNER ||--o{ PET : owns
    OWNER ||--o{ APPOINTMENT : books
    
    PET {
        UUID id PK
        UUID ownerId FK
        STRING name
        STRING type
        STRING breed
        BINARY picture
    }
    PET ||--o{ APPOINTMENT : has
   
    VET {
        UUID id PK
    }
    VET ||--o{ AVAILABILITY : sets
    VET ||--o{ APPOINTMENT : sets
    
    AVAILABILITY {
        UUID id PK
        UUID vetId FK
        ENUM dayOfWeek
        TIME startTime
        TIME endTime
    }
    
    APPOINTMENT {
        UUID id PK
        UUID petId FK
        UUID vetId FK
        DATETIME timeSlot
        ENUM status
    }
    APPOINTMENT ||--|{ VISIT : results_in

    VISIT {
        UUID id PK
        UUID appointmentId FK
        ENUM type "diagnosis, vaccination, notes"
        TEXT remark
        DATETIME createdAt
    }

    ACTIVITY_LOG {
        UUID id PK
        UUID userId FK
        STRING action
        DATETIME timestamp
    }


    
```

## Main Entities
| Entity       | Description |
|--------------|-------------|
| `User`       | User with name, role and credentials |
| `Owner`      | User with a pet |
| `Pet`        | Pet with name, birth date, type and picutre |
| `Vet`        | Veterinarian with name |
| `Availability`| Opening hours or available slots of a vet |
| `Appointment`| Scheduled visit between an owner and a vet for a pet |
| `Visit`      | A entry created by vet with notes and diagnosis |
| `ActivityLog`| Simple Audit |

## Relationships

- A `Owner` can own multiple `Pets` (1:N)
- A `Pet` can have multiple `Appointments` (1:N)
- A `Vet` (User) can have multiple `Appointments` (1:N)
- A `Vet` (User) can define multiple `Availability` slots (1:N)
- Each `Appointment` can result in one Visit (1:1)
- A `User` can have multiple `ActivityLogs` (1:N)

---
