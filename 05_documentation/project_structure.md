# Project Structure

**Project:** Dialysis Session Tracking System  
**Author:** Joseph Ndanji Muleba  
**Version:** 1.0  
**Last Updated:** July 2026

---

## Purpose

This document describes the organization of the project repository and explains the purpose of each folder and major file.

The repository is structured to separate database development, Python automation, data analysis, Power BI reporting, project documentation, and supporting resources. This organization improves maintainability and makes the project easier to understand and reproduce.

---

## Repository Structure

---
dialysis-session-tracking-system/
│
├── 01_database/
├── 02_analysis/
├── 03_powerbi/
├── 04_database-design/
├── 05_documentation/
├── 06_images/
├── 07_sample-output/
├── 08_scripts/
│
├── README.md
├── LICENSE
└── .gitattributes

## Folder Descriptions

### `01_database`

Contains all SQL files required to build and populate the database.

Typical contents include:

- Database creation script
- Table creation script
- Reference (master) data
- Generated SQL files
- Validation queries

This folder allows the database to be recreated from scratch.

---

### `02_analysis`

Contains SQL analysis queries used to explore and validate the generated data.

Examples include:

- Session summaries
- Complication analysis
- Machine utilization
- Patient statistics
- Clinical validation queries

These queries demonstrate how the database can be used for operational reporting and healthcare analytics.

---

### `03_powerbi`

Contains Power BI resources used for reporting and dashboard development.

Typical contents include:

- Power BI project (`.pbix`)
- Dashboard screenshots
- Exported reports

---

### `04_database-design`

Contains database design resources.

Examples include:

- Entity Relationship Diagram (ERD)
- Database schema
- Table relationship diagrams
- Database design files

---

### `05_documentation`

Contains project documentation explaining the design, implementation, and workflow.

Documents include:

- Requirements
- Database Design
- Data Dictionary
- Project Structure
- SQL Workflow
- Python Automation

---

### `06_images`

Contains images used throughout the project documentation.

Examples include:

- ERD diagrams
- Database screenshots
- Dashboard screenshots
- Workflow illustrations

---

### `07_sample-output`

Contains examples of generated outputs from the project.

Examples include:

- Generated SQL files
- Console output
- Query results
- Validation examples

These files demonstrate the results produced by the automation scripts.

---

### `08_scripts`

Contains all Python automation scripts.

Current scripts include:

| Script | Purpose |
|---------|---------|
| `db_connection.py` | Connects Python to the MySQL database |
| `generate_sessions.py` | Generates synthetic dialysis session records |
| `generate_vitals.py` | Generates synthetic patient vital signs |
| `generate_complications.py` | Generates dialysis-related complications |

These scripts automate transactional data generation while preserving database relationships and clinical logic.

---

## Root Files

### `README.md`

Provides an overview of the project, setup instructions, technologies used, screenshots, and links to the supporting documentation.

---

### `LICENSE`

Defines the licensing terms for the project.

---

### `.gitattributes`

Stores Git configuration settings for the repository.

---

## Development Workflow

The project is organized around the following workflow:

1. Design the database.
2. Build the database using SQL.
3. Populate reference (master) data.
4. Generate synthetic transactional data with Python.
5. Validate the generated data using SQL.
6. Analyze the data.
7. Build interactive dashboards in Power BI.
8. Document the project.

---

## Design Philosophy

The repository separates different parts of the project into dedicated folders to improve readability and maintainability.

- **Database** stores SQL scripts and generated SQL files.
- **Scripts** contains Python automation.
- **Analysis** contains SQL queries for validation and reporting.
- **Power BI** contains dashboards and visualizations.
- **Documentation** explains the project and implementation.
- **Images** stores diagrams and screenshots.
- **Sample Output** provides examples of generated results.
 