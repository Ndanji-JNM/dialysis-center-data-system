# Data Dictionary

**Project:** Dialysis Session Tracking System  
**Author:** Joseph Ndanji Muleba  
**Version:** 1.0  
**Last Updated:** July 2026


## Purpose

This document describes the main database tables used in the Dialysis Session Tracking System and explains their purpose, relationships, and important fields.

The database structure supports dialysis treatment tracking, clinical monitoring, and healthcare analytics using synthetic data.


---

### Table: staff_roles

**Purpose:**  
Stores the different staff roles available within the dialysis unit.

**Primary Key:**
- role_id

**Columns**

- role_id
- role_name


---

### Table: staff

**Purpose:**  
Stores healthcare professionals working in the dialysis unit.

**Primary Key:**
- staff_id

**Foreign Key:**
- role_id

**Columns**

- staff_id
- first_name
- last_name
- gender
- phone
- email
- role_id
- hire_date
- status


---

### Table: patients

**Purpose:**  
Stores patient demographic and clinical registration information.

**Primary Key:**
- patient_id

**Columns**

- patient_id
- first_name
- last_name
- gender
- date_of_birth
- blood_group
- diagnosis
- infection_status
- phone
- emergency_contact
- address
- registration_date
- status


**Note:**  
The `infection_status` field is used during synthetic session generation to assign patients to the appropriate dialysis machine infection-control loop.


---

### Table: dialysis_machines

**Purpose:**  
Stores information about dialysis machines used in the dialysis unit.

**Primary Key:**
- machine_id

**Columns**

- machine_id
- machine_code
- manufacturer
- model
- serial_number
- loop_number
- installation_date
- status


**Note:**  
The `loop_number` field represents infection-control machine grouping. During synthetic session generation, patients are assigned only to machines within the appropriate loop based on infection status.


---

### Table: sessions

**Purpose:**  
Records every dialysis treatment session performed in the dialysis unit.

This is the central transactional table linking patients, dialysis machines, and healthcare staff.

**Primary Key:**
- session_id

**Foreign Keys:**
- patient_id
- machine_id
- staff_id

**Columns**

- session_id
- patient_id
- machine_id
- staff_id
- session_date
- start_time
- end_time
- prescribed_duration_hours
- actual_duration_hours
- blood_flow_rate
- dialysate_flow_rate
- uf_goal_ml
- fluid_removed_ml
- session_status
- notes


---

### Table: vital_logs

**Purpose:**  
Stores patient vital signs recorded before and after each dialysis session.

**Primary Key:**
- vital_id

**Foreign Key:**
- session_id

**Columns**

- vital_id
- session_id
- pre_systolic_bp
- pre_diastolic_bp
- pre_pulse
- pre_weight
- post_systolic_bp
- post_diastolic_bp
- post_pulse
- post_weight


**Note:**  
Vital signs are stored separately from the sessions table to keep treatment records organized and allow future expansion of clinical monitoring data.


---

### Table: session_complications

**Purpose:**  
Stores complications recorded during dialysis sessions.

Not every dialysis session contains a complication, therefore these records are stored separately.

**Primary Key:**
- complication_id

**Foreign Key:**
- session_id

**Columns**

- complication_id
- session_id
- complication_type
- severity
- intervention
- resolved


---

## Data Classification

The database tables are grouped into the following categories:


### Reference Data

These tables contain manually created master data used by the system.

- staff_roles
- staff
- patients
- dialysis_machines


### Transactional Data

These tables record dialysis activities generated during the workflow.

- sessions


### Clinical Monitoring Data

These tables store patient treatment observations and events.

- vital_logs
- session_complications


---

## Data Generation Notes

The project uses Python scripts to generate synthetic dialysis records while maintaining relationships with existing database records.

Generated data includes:

- Dialysis sessions
- Patient vital signs
- Dialysis complications

All generated records reference existing patients, staff members, and dialysis machines to maintain relational integrity.


---

## Data Assumptions

- All data used in this project is synthetic.
- No real patient information is included.
- Clinical values are generated to resemble realistic dialysis scenarios.
- The database is designed for healthcare data modelling, analytics, and portfolio demonstration purposes.