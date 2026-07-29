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
# CHECK MACHINE AVAILABILITY
# ==========================================================

for infection, machine_ids in machine_map.items():

    if len(machine_ids) == 0:
        print(f"Warning: No operational machine available for {infection} loop.")

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

# ==========================================================
# SESSION GENERATION SETTINGS
# ==========================================================

number_of_sessions_per_patient = 40

session_start_date = date(2024, 1, 1)
session_end_date = date(2025, 12, 31)

# ==========================================================
# GENERATE RANDOM SESSION DATE
# ==========================================================

def random_session_date():

    days_between = (session_end_date - session_start_date).days

    random_days = random.randint(0, days_between)

    return session_start_date + timedelta(days=random_days)

# ==========================================================
# GENERATE DIALYSIS PARAMETERS
# ==========================================================

def generate_dialysis_parameters():

    duration_hours = random.choice([3.5, 4.0, 4.5])

    blood_flow_rate = random.choice([
        250,
        300,
        350,
        400
    ])

    dialysate_flow_rate = random.choice([
        500,
        600,
        800
    ])

    uf_goal = random.randint(500, 4000)

    fluid_removed = random.randint(
        int(uf_goal * 0.85),
        uf_goal
    )

    return (
        duration_hours,
        blood_flow_rate,
        dialysate_flow_rate,
        uf_goal,
        fluid_removed
    )

 # ==========================================================
# GENERATE DIALYSIS SESSIONS
# ==========================================================

generated_sessions = []


for patient in patients:

    infection_status = patient["infection_status"]

    # Select machines from correct infection-control loop
    available_machines = machine_map[infection_status]

    # Safety check
    if len(available_machines) == 0:
        continue


    for i in range(number_of_sessions_per_patient):

        machine_id = random.choice(available_machines)

        nurse = random.choice(nurses)

        session_date = random_session_date()


        (
            duration_hours,
            blood_flow_rate,
            dialysate_flow_rate,
            uf_goal,
            fluid_removed
        ) = generate_dialysis_parameters()


        session_status = random.choices(
            [
                "Completed",
                "Interrupted",
                "Missed"
            ],
            weights=[
                90,
                8,
                2
            ]
        )[0]


        generated_sessions.append({

            "patient_id": patient["patient_id"],

            "machine_id": machine_id,

            "staff_id": nurse["staff_id"],

            "session_date": session_date,

            "duration_hours": duration_hours,

            "blood_flow_rate": blood_flow_rate,

            "dialysate_flow_rate": dialysate_flow_rate,

            "uf_goal": uf_goal,

            "fluid_removed": fluid_removed,

            "session_status": session_status

        })

print()
print("Session generation complete.")
print(f"Generated sessions: {len(generated_sessions)}")

cursor.close()
connection.close()

