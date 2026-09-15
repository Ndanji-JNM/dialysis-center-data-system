# Database Design

The project uses a relational MySQL database to organize dialysis-unit records.

The database separates patient information, treatment sessions, staff, dialysis machines, vital measurements, and session complications into related tables.

## Main Relationships

- Patients → Sessions
- Staff → Sessions
- Dialysis Machines → Sessions
- Sessions → Vital Logs
- Sessions → Session Complications

Primary and foreign keys are used to maintain relationships between the tables.

The database structure was visualized using MySQL Workbench's Reverse Engineer feature.

See `database_schema.png` for the complete database structure.