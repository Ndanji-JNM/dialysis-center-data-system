# Dialysis Session Tracking System

## 1. Project Overview

The Dialysis Session Tracking System is a healthcare data analytics portfolio project designed to demonstrate an end-to-end workflow for storing, analysing, and visualising dialysis treatment data.

The project uses synthetic data and does not contain real patient information.

## 2. Project Objectives

The project was developed to demonstrate practical skills in:

- Relational database design
- SQL
- Data validation and analysis
- Python-based synthetic data generation
- Power BI
- DAX
- Data modelling
- Interactive dashboard development

## 3. System Workflow

Synthetic Data Generation → MySQL Database → SQL Analysis & Validation → Power BI Data Model → DAX Measures → Interactive Dashboard

## 4. Database

The MySQL database is named `dialysis_tracker`.

The main tables include:

- `patients`
- `sessions`
- `vital_logs`
- `session_complications`
- `staff`
- `staff_roles`
- `dialysis_machines`

Primary and foreign keys are used to maintain relationships between related records.

## 5. Data Generation

Synthetic records were generated to provide a realistic dataset for analytical purposes.

The generated data includes:

- Patient records
- Dialysis sessions
- Vital measurements
- Treatment parameters
- Session complications
- Staff assignments
- Dialysis machines
- Infection-control assignments

The data is intended for analytical demonstration rather than clinical use.

## 6. SQL Analysis

SQL queries were used to examine:

- Patient characteristics
- Session activity and outcomes
- Treatment parameters
- Clinical measurements
- Complications
- Machine operations
- Infection-control allocation
- Staff activity
- Data quality

Detailed queries are available in `02_analysis/analysis_queries.sql`.

The main observations are summarized in `02_analysis/findings.md`.

## 7. Power BI Dashboard

The Power BI dashboard provides interactive analysis across six main areas:

| Page | Purpose |
|---|---|
| Overview | High-level view of dialysis activity |
| Patients | Patient demographics and clinical characteristics |
| Sessions | Treatment activity and session outcomes |
| Clinical Monitoring | Vital signs and treatment measurements |
| Complications | Complication patterns, severity and interventions |
| Operations | Staff, machines and operational activity |

A patient-level drill-through page is also available for detailed individual analysis.

## 8. Data Model

The Power BI model connects the database tables through their primary and foreign-key relationships.

Key relationships include:

- Patients → Sessions
- Sessions → Vital Logs
- Sessions → Session Complications
- Dialysis Machines → Sessions
- Staff → Sessions
- Staff Roles → Staff

Relationships are configured to support analysis while maintaining appropriate filter direction.

## 9. Key Measures

DAX measures are used to calculate metrics such as:

- Total Sessions
- Completed Sessions
- Completion Rate
- Active Patients
- Average Session Duration
- Average Fluid Removed
- Patient Completion Rate

Additional measures support clinical and patient-level analysis.

## 10. Limitations

This is a portfolio project using synthetic data.

Patient information, clinical measurements, complications, staff activity, and operational records were generated for demonstration purposes.

The system should not be interpreted as a production clinical information system or used to make medical decisions.

## 11. Project Structure

01_database/
02_analysis/
03_powerbi/
04_database_design/
05_documentation/
06_images/
07_sample_output/
08_scripts/
README.md

## 12. Skills Demonstrated

This project demonstrates practical experience with:

- MySQL
- SQL
- Python
- Power BI
- DAX
- Data modelling
- Data validation
- Healthcare data analysis
- Dashboard development
- Technical documentation