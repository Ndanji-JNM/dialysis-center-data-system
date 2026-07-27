# Data Dictionary

## Project

**Dialysis Session Tracking System**

This document describes the tables used in the database and their purpose.

---

### Table: staff_roles

Purpose:
Stores the different staff roles used in the dialysis unit.

Primary Key:
- role_id

Columns

- role_id
- role_name

---

### Table: staff

Purpose:
Stores healthcare professionals working in the dialysis unit.

Primary Key:
- staff_id

Foreign Key:
- role_id

Columns

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

Purpose:
Stores patient demographic and registration information.

Primary Key:
- patient_id

Columns

- patient_id
- first_name
- last_name
- gender
- date_of_birth
- blood_group
- diagnosis
- phone
- emergency_contact
- address
- registration_date
- status

---

### Table: dialysis_machines

Purpose:
Stores information about dialysis machines used in the dialysis unit.

Primary Key:
- machine_id

Columns

- machine_id
- machine_code
- manufacturer
- model
- serial_number
- loop_number
- installation_date
- status

---

### Table: sessions

Purpose:
Records every dialysis treatment session performed in the dialysis unit.

Primary Key:
- session_id

Foreign Keys:
- patient_id
- machine_id
- staff_id

Columns

- session_id
- patient_id
- machine_id
- staff_id
- session_date
- start_time
- end_time
- duration_minutes
- prescribed_duration
- blood_flow_rate
- dialysate_flow_rate
- ultrafiltration_goal
- fluid_removed
- session_status
- notes

---

### Table: vital_logs

Purpose:
Stores patient vital signs before and after each dialysis session.

Primary Key:
- vital_id

Foreign Key:
- session_id

Columns

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

---

### Table: session_complications

Purpose:
Stores complications recorded during dialysis sessions.

Primary Key:
- complication_id

Foreign Key:
- session_id

Columns

- complication_id
- session_id
- complication_type
- severity
- intervention
- resolved