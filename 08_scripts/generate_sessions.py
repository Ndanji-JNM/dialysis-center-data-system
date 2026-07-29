"""
Dialysis Session Generator

This script reads data from the MySQL database and generates
realistic dialysis session records.

The generated SQL file can be imported into the sessions table.

Author: Joseph Ndanji Muleba
Project: Dialysis Session Tracking System
"""

# ==========================================================
# IMPORTS
# ==========================================================

import random
from datetime import date, timedelta
from pathlib import Path

from db_connection import get_connection


# ==========================================================
# PROJECT PATHS
# ==========================================================

PROJECT_FOLDER = Path(__file__).resolve().parent.parent

OUTPUT_FILE = PROJECT_FOLDER / "01_database" / "generated_sessions.sql"

# ==========================================================
# CONNECT TO DATABASE
# ==========================================================

connection = get_connection()

cursor = connection.cursor(dictionary=True)

print("Connected to MySQL database.")

# ==========================================================
# LOAD PATIENTS
# ==========================================================

cursor.execute("""
SELECT
    patient_id,
    infection_status
FROM patients
WHERE status = 'Active';
""")

patients = cursor.fetchall()

print(f"Loaded {len(patients)} active patients.")

# ==========================================================
# LOAD DIALYSIS MACHINES
# ==========================================================

cursor.execute("""
SELECT
    machine_id,
    loop_number
FROM dialysis_machines
WHERE status = 'Operational';
""")

machines = cursor.fetchall()

print(f"Loaded {len(machines)} operational machines.")

# ==========================================================
# BUILD MACHINE MAP BASED ON INFECTION CONTROL LOOPS
# ==========================================================

machine_map = {
    "None": [],
    "HIV": [],
    "Hepatitis C": [],
    "Hepatitis B": []
}


for machine in machines:

    if machine["loop_number"] == 1:
        machine_map["None"].append(machine["machine_id"])

    elif machine["loop_number"] == 2:
        machine_map["HIV"].append(machine["machine_id"])

    elif machine["loop_number"] == 3:
        machine_map["Hepatitis C"].append(machine["machine_id"])

    elif machine["loop_number"] == 4:
        machine_map["Hepatitis B"].append(machine["machine_id"])


print()
print("Machine allocation:")
print("-" * 30)

for infection, machine_ids in machine_map.items():
    print(f"{infection}: {machine_ids}")

# ==========================================================
# LOAD DIALYSIS NURSES
# ==========================================================

cursor.execute("""
SELECT
    s.staff_id,
    s.first_name,
    s.last_name
FROM staff s
JOIN staff_roles r
    ON s.role_id = r.role_id
WHERE r.role_name = 'Dialysis Nurse'
  AND s.status = 'Active';
""")

nurses = cursor.fetchall()

print(f"Loaded {len(nurses)} dialysis nurses.")

cursor.close()
connection.close()

