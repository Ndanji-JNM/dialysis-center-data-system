# Project Requirements

**Project:** Dialysis Session Tracking System  
**Author:** Joseph Ndanji Muleba  
**Version:** 1.0  
**Last Updated:** July 2026

# Requirements

## Purpose

The project integrates SQL database design, Python automation, and Power BI reporting to simulate the operations of a dialysis centre using synthetic healthcare data. It demonstrates an end-to-end healthcare analytics workflow, from database development and synthetic data generation to business intelligence reporting.

## Technology Stack
 
### Database Management System

 `MySQL 8.0` or later

Used for:

* Designing the relational database
* Creating database tables and relationships
* Storing reference and transactional data
* Executing SQL queries and validation checks

### Programming Language
 
`Python 3.x`

Used for:

* Connecting to the MySQL database
* Reading reference data
* Generating synthetic dialysis sessions
* Generating patient vital signs
* Generating dialysis complications
* Exporting generated records into SQL scripts

 Python Library:

* `mysql-connector-python`

### Installation

```bash
pip install mysql-connector-python
```

### Business Intelligence 

 `Microsoft Power BI Desktop`

Used for:

* Building interactive dashboards
* Visualizing dialysis centre performance
* Creating Key Performance Indicators (KPIs)
* Analyzing operational trends

### Development Environment

Recommended code editor:

`Visual Studio Code`

Used for:

* SQL development
* Python scripting
* Documentation
* Version control with Git

### Reference Data Requirements

The following tables contain manually created reference (**master**) data using SQL scripts.

* `Staff_Roles`
* `Staff`
* `Patients`
* `Dialysis_Machines`

These tables must be populated before running any Python data generation scripts.

### Python Generated Data

Python reads the existing reference data from the MySQL database and generates transactional healthcare records.

Generated tables include:

* `Sessions`
* `Vital_Logs`
* `Session_Complications`

This approach maintains relational integrity by ensuring that generated records reference existing patients, staff members, and dialysis machines.


## Project Workflow

The recommended execution order is:

1. Create the database.
2. Create all database tables.
3. Insert reference (master) data.
4. Configure the database connection in `db_connection.py`.
5. Generate dialysis sessions using Python.
6. Import generated session data into MySQL.
7. Generate vital signs using Python.
8. Import generated vital records into MySQL.
9. Generate dialysis complications using Python.
10. Import generated complication records into MySQL.
11. Perform validation queries.
12. Build Power BI dashboards.

## Software Requirements

 Minimum software versions:

| Software | Version |
|----------|---------|
| MySQL Server | 8.0+ |
| Python | 3.x |
| Power BI Desktop | Latest Stable Release |
| Visual Studio Code | Latest Stable Release |
| Git | Recommended |


## Minimum Hardware Requirements

* Windows 10 or Windows 11
* Dual-core processor
* 8 GB RAM
* 2 GB available storage
* Internet connection (for software installation only)

## Recommended Hardware

* Windows 11
* Quad-core processor
* 16 GB RAM
* SSD storage
* Dual-monitor setup (recommended for SQL and Power BI development)

## Python Scripts

The project currently includes the following automation scripts:

|Script	| Purpose|
|-------|--------|
|`db_connection.py` | Connects Python to the MySQL database|
|`generate_sessions.py`	| Generates synthetic dialysis session records|
|`generate_vitals.py`	| Generates realistic patient vital signs|
|`generate_complications.py`| Generates dialysis-related complications|

### Database Requirements

The project assumes the following tables exist before executing Python scripts:

* `staff_roles`
* `staff`
* `patients`
* `dialysis_machines`
* `sessions`
* `vital_logs`
* `session_complications`

### Assumptions

* All data is synthetic and generated for educational and portfolio purposes.
* No real patient information is included.
* Clinical values are generated to resemble realistic dialysis scenarios.
* The project is intended for database design, data engineering, and analytics demonstration only.

## Future Enhancements

Potential future improvements include:
- Additional dialysis quality indicators
- Patient outcome analysis
- Dialysis scheduling optimization
- Predictive analytics using machine learning
- Integration with KoboToolbox for synthetic field data collection
- Public health dialysis needs analysis dashboards
