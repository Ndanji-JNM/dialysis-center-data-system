# Database Setup

This folder contains the SQL scripts used to create, configure, and
populate the `dialysis_tracker` MySQL database.

The database supports the Dialysis Session Tracking System and provides
the data used for analysis and visualization in Power BI.

## Database Structure

The database contains the following main tables:

- `patients` — patient demographic and dialysis information
- `staff` — staff records
- `staff_roles` — staff role definitions
- `dialysis_machines` — dialysis machine information and status
- `sessions` — dialysis session records
- `vital_logs` — pre- and post-dialysis vital signs
- `session_complications` — complications recorded during dialysis sessions

## SQL Files

| File | Purpose |
|---|---|
| `01_Create_Database.sql` | Creates the `dialysis_tracker` database |
| `02_Create_Tables.sql` | Creates the database tables |
| `03_Insert_sample_Data.sql` | Inserts initial sample/reference data |
| `04_constraints.sql` | Defines database constraints and relationships |
| `generated_sessions.sql` | Generates synthetic dialysis session records |
| `generated_vital.sql` | Generates synthetic vital-sign records |
| `generated_complications.sql` | Generates synthetic complication records |

## Execution Order

For a fresh database setup, execute the scripts in this order:

### 1. Create the database

Run:

`01_Create_Database.sql`

This creates the `dialysis_tracker` database.

### 2. Create the tables

Run:

`02_Create_Tables.sql`

This creates the database tables and their primary-key structure.

### 3. Insert sample data

Run:

`03_Insert_sample_Data.sql`

This inserts the initial sample/reference records required by the
database.

### 4. Apply constraints

Run:

`04_constraints.sql`

This applies the required foreign-key and other database constraints.

### 5. Generate synthetic session data

Run:

`generated_sessions.sql`

This generates synthetic dialysis session records.

### 6. Generate vital-sign data

Run:

`generated_vital.sql`

This generates synthetic pre- and post-dialysis vital-sign records
associated with dialysis sessions.

### 7. Generate complication data

Run:

`generated_complications.sql`

This generates synthetic complication records associated with dialysis
sessions.

## Verification

After running the scripts, select the `dialysis_tracker` schema in
MySQL Workbench and refresh the schema.

Run:

```sql
USE dialysis_tracker;

SHOW TABLES;