# Dialysis Session Tracking System

A healthcare data analytics portfolio project that uses MySQL, Python, SQL, and Power BI to track and analyze dialysis treatment activity, clinical measurements, complications, and operational data.

## Project Overview

The system uses a relational MySQL database containing synthetic dialysis-unit data. Python scripts generate sample records, SQL is used for analysis, and Power BI provides an interactive dashboard for exploring the data.

The project demonstrates how healthcare data can be structured, processed, analyzed, and presented for decision-making.

## Key Areas

- Patient records and dialysis activity
- Treatment session outcomes
- Pre- and post-dialysis vital signs
- Fluid removal and treatment duration
- Session complications
- Dialysis machine activity
- Staff activity and operational performance
- Patient-level analysis and drill-through

## Tools & Technologies

- **MySQL** — database design and data storage
- **Python** — synthetic data generation
- **SQL** — data analysis and validation
- **Power Query** — data preparation
- **Power BI** — interactive dashboards and visualization
- **DAX** — calculated measures and KPIs
- **MySQL Workbench** — database development and schema design

## Dashboard

The Power BI dashboard contains six main analysis areas:

| Page | Purpose |
|---|---|
| Overview | High-level view of dialysis activity |
| Patients | Patient demographics and clinical characteristics |
| Sessions | Treatment activity and session outcomes |
| Clinical Monitoring | Vital signs and treatment measurements |
| Complications | Complication patterns and recorded events |
| Operations | Staff, machines, and operational activity |

A patient-level drill-through page provides more detailed analysis for individual patients.

## Database

The database contains related tables for:

- Patients
- Dialysis Sessions
- Vital Logs
- Session Complications
- Staff
- Staff Roles
- Dialysis Machines

The relational structure uses primary and foreign keys to connect treatment, clinical, staff, and operational records.

See [`04_database_design`](04_database_design/) for the database schema.

## Project Structure
dialysis-session-tracking-system/

01_database/
02_analysis/
03_powerbi/
04_database_design/
05_documentation/
06_images/
07_scripts/
## Data 

The dataset is synthetic and was created for portfolio and analytical demonstration purposes. It does not contain real patient information or represent real clinical outcomes.

## What This Project Demonstrates

- Relational database design
- Data generation and preparation
- SQL querying and analysis
- Data quality checking
- Healthcare data analysis
- Dashboard development
- KPI development using DAX
- Data visualization
- Translating structured data into actionable insights



## Author

**Joseph Ndanji Muleba**