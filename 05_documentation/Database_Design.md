# Database Design

**Project:** Dialysis Session Tracking System  
**Author:** Joseph Ndanji Muleba  
**Version:** 1.0  
**Last Updated:** July 2026


## Purpose

This document describes the design of the relational database used in the Dialysis Session Tracking System. It explains the database structure, table relationships, primary keys, foreign keys, and the design decisions used to maintain data integrity.

## Database Overview

The project uses a relational database implemented in `MySQL`.

The database models the core workflow of a dialysis centre by storing information about:

* Patients
* Staff
* Dialysis machines
* Dialysis sessions
* Patient vital signs
* Dialysis complications

The database was designed using normalization principles to reduce redundancy while maintaining referential integrity.


## Entity Relationship Overview

The database follows a relational structure where reference tables provide master data, while transactional tables capture dialysis treatment activities.
The `sessions` table acts as the central transactional table linking patients, healthcare staff, and dialysis machines during each dialysis encounter.
An entity relationship diagram will be added to visually represent the relationships between tables.## Database Tables


### `staff_roles`

Stores the different staff roles available within the dialysis centre.
Each role is assigned a unique identifier that is referenced by the `staff` table.

This include:

* Dialysis Nurse
* Dialysis Technologist
* Nephrologist
* Biomedical Engineer


### `staff`

Stores employee information for healthcare professionals working in the dialysis centre.

Each staff member belongs to one role through the `role_id` foreign key.

The table is used when assigning healthcare professionals to dialysis sessions.


### `patients`

Stores demographic and clinical information for dialysis patients.

Example includes:

* Diagnosis
* Blood group
* Infection status
* Registration status

**The infection status is used by the Python session generator to allocate patients to the correct dialysis machine loop**.


### `dialysis_machines`

Stores dialysis machine information.

Includes:

* Machine code
* Manufacturer
* Model
* Serial number
* Infection-control loop
* Operational status

**The loop number is used during synthetic session generation to enforce infection-control protocols.**


### `sessions`

This is the central transactional table.

Each record represents one dialysis treatment.

It references:

* `patients`
* `dialysis_machines`
* `staff`

and stores treatment parameters such as:

* Blood flow rate
* Dialysate flow rate
* Ultrafiltration goal
* Fluid removed
* Session duration
* Session status

### `vital_logs`

Stores pre- and post-dialysis vital signs.

Each record belongs to one dialysis session.

Separating vital signs into their own table keeps the sessions table focused on treatment data while allowing future expansion.


### `session_complications`

Stores complications that occur during dialysis.

Each complication references one dialysis session.

Not every session contains a complication.

The table allows later analysis of complication frequency and treatment outcomes



### Primary Keys

|Table | Primary Key|
|------|------------|
|`staff_roles` | `role_id`|
|`staff` | `staff_id`|
|`patients` | `patient_id`|
|`dialysis_machines`| `machine_id`|
|`sessions` | `session_id`|
|`vital_logs` |	`vital_id`|
|`session_complications` | `complication_id`|


### Foreign Keys

|Child Table|Foreign Key| Parent Table|
|-----------|-----------|-------------|
|`staff`| `role_id` | `staff_roles`|
|`sessions`| `patient_id` | `patients`|
|`sessions`| `machine_id` | `dialysis_machines`|
|`sessions`| `staff_id` | `staff`|
|`vital_logs`| `session_id` | `sessions`|
|`session_complications`| `session_id`|	`sessions`|


## Database Design Decisions

The database follows relational database design principles to minimize redundancy and maintain data integrity.

Key design decisions include:

- Separating reference (master) data from transactional data.
- Using primary and foreign keys to enforce relationships.
- Storing patient vital signs separately from dialysis sessions to improve scalability.
- Recording dialysis complications independently because not every session contains a complication.
- Using infection-control loops during session generation to simulate real haemodialysis practice.

 
## Clinical Design Considerations

The database structure reflects common haemodialysis workflows.

Patients are assigned an infection status, while dialysis machines are assigned infection-control loops. During synthetic session generation, patients are allocated only to machines within the corresponding infection-control loop. This simulates standard infection prevention practices commonly used in haemodialysis units.

Clinical values such as ultrafiltration goals, fluid removal, vital signs, and dialysis complications were generated using realistic ranges to resemble typical dialysis treatment scenarios while remaining entirely synthetic.


## Future Improvements

* Medication administration table
* Laboratory results
* Vascular access history
* Hospital admissions
* Dialysis prescription management
* Appointment scheduling