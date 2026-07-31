# Python Automation

**Project:** Dialysis Session Tracking System  
**Author:** Joseph Ndanji Muleba  
**Version:** 1.0  
**Last Updated:** July 2026

---

## Purpose

This document describes the Python automation used in the Dialysis Session Tracking System.

Python was used to generate realistic synthetic healthcare data based on existing reference data stored in the MySQL database. Rather than inserting random records manually, the scripts automate the creation of transactional data while maintaining database relationships and basic clinical logic.

---

## Overview

The automation scripts connect directly to the MySQL database, retrieve existing reference data, generate realistic dialysis records, and export the generated data as SQL scripts for import into the database.

This approach allows the project to produce large volumes of consistent, repeatable, and relationally accurate data.

---

## Python Environment

The project was developed using:

- Python 3.x
- `mysql-connector-python`

Install the required package using:

```bash
pip install mysql-connector-python
```

---

## Script Overview

### `db_connection.py`

Creates the connection between Python and the MySQL database.

Responsibilities:

- Connect to MySQL
- Return a reusable database connection
- Handle authentication details
- Support all automation scripts

---

### `generate_sessions.py`

Generates synthetic dialysis treatment sessions.

The script reads:

- Active patients
- Operational dialysis machines
- Active dialysis nurses

For each patient, the script generates realistic dialysis sessions containing:

- Session date
- Assigned machine
- Assigned nurse
- Prescribed duration
- Blood flow rate
- Dialysate flow rate
- Ultrafiltration goal
- Fluid removed
- Session status

The script also enforces infection-control rules by assigning patients only to machines within the appropriate infection-control loop.

Generated data is exported to:

```
generated_sessions.sql
```

---

### `generate_vitals.py`

Generates pre- and post-dialysis vital signs.

The script reads dialysis sessions from the database and generates:

- Blood pressure
- Pulse
- Patient weight before dialysis
- Patient weight after dialysis

Clinical validation is applied during generation to ensure that post-dialysis weight reflects the amount of fluid removed during treatment.

Vital records are exported to:

```
generated_vitals.sql
```

---

### `generate_complications.py`

Generates dialysis-related complications.

The script analyses completed and interrupted dialysis sessions and assigns complications using weighted probabilities.

Examples include:

- Muscle cramps
- Hypotension
- Nausea
- Blood leak alarm
- Access clotting
- Chest pain

Interrupted sessions have a higher probability of receiving complications, while completed sessions receive fewer events.

Generated records are exported to:

```
generated_complications.sql
```

---

## Data Generation Workflow

The automation process follows this sequence:

1. Connect to the MySQL database.
2. Read reference (master) data.
3. Generate synthetic transactional data.
4. Apply validation and clinical rules.
5. Export the generated SQL statements.
6. Import the generated SQL files into MySQL.
7. Validate the imported data using SQL queries.

---

## Clinical Logic

Several clinical rules were incorporated to improve realism.

Examples include:

- Patients are assigned only to machines within their infection-control loop.
- Fluid removed does not exceed the prescribed ultrafiltration goal.
- Post-dialysis weight reflects fluid removal during treatment.
- Interrupted dialysis sessions are more likely to contain complications.
- Complication types are selected using weighted probabilities to better reflect clinical practice.

These rules improve the realism of the generated dataset while remaining entirely synthetic.

---

## Advantages of Automation

Using Python automation provides several benefits:

- Generates large datasets quickly.
- Maintains relational integrity.
- Produces consistent and repeatable results.
- Reduces manual data entry.
- Simplifies testing and validation.
- Supports future expansion of the project.

---

## Future Improvements

Possible enhancements include:

- Medication administration records
- Laboratory result generation
- Dialysis prescription generation
- Machine maintenance history
- Appointment scheduling
- Additional clinical validation rules
- Configurable generation settings