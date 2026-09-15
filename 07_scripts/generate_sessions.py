"""
Dialysis Session Generator

Reads reference data from MySQL and generates realistic dialysis
session records for the Dialysis Session Tracking System.

Author: Joseph Ndanji Muleba
Project: Dialysis Session Tracking System
"""

# ==========================================================
# IMPORTS
# ==========================================================

import random
from datetime import date, datetime, time, timedelta
from pathlib import Path

from db_connection import get_connection


# ==========================================================
# PROJECT PATHS
# ==========================================================

PROJECT_FOLDER = Path(__file__).resolve().parent.parent

OUTPUT_FILE = PROJECT_FOLDER / "01_database" / "generated_sessions.sql"


# ==========================================================
# DATABASE CONNECTION
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

# Three dialysis shifts commonly used

SHIFT_START_TIMES = [
    time(6, 30),
    time(12, 30),
    time(18, 0)
]

# ==========================================================
# RANDOM SESSION DATE
# ==========================================================

def random_session_date():

    days = (session_end_date - session_start_date).days

    return session_start_date + timedelta(
        days=random.randint(0, days)
    )

# ==========================================================
# RANDOM SESSION TIME
# ==========================================================

def generate_session_times(duration_hours):

    start = random.choice(SHIFT_START_TIMES)

    start_datetime = datetime.combine(
        date.today(),
        start
    )

    end_datetime = start_datetime + timedelta(
        hours=duration_hours
    )

    return (
        start_datetime.time(),
        end_datetime.time()
    )


# ==========================================================
# DIALYSIS PARAMETERS
# ==========================================================

def generate_dialysis_parameters():

    prescribed_duration = random.choice([
        3.5,
        4.0,
        4.5
    ])

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
        prescribed_duration,
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

    available_machines = machine_map[infection_status]

    if len(available_machines) == 0:
        continue

    for i in range(number_of_sessions_per_patient):

        machine_id = random.choice(available_machines)

        nurse = random.choice(nurses)

        session_date = random_session_date()

        (
            prescribed_duration,
            blood_flow_rate,
            dialysate_flow_rate,
            uf_goal,
            fluid_removed
        ) = generate_dialysis_parameters()

        # ---------------------------------------------
        # Session outcome
        # ---------------------------------------------

        session_status = random.choices(
            [
                "Completed",
                "Interrupted",
                "Missed"
            ],
            weights=[
                90,
                7,
                3
            ],
            k=1
        )[0]

        # ---------------------------------------------
        # Actual duration
        # ---------------------------------------------

        if session_status == "Completed":

            actual_duration = prescribed_duration

        elif session_status == "Interrupted":

            actual_duration = round(
                random.uniform(
                    prescribed_duration * 0.40,
                    prescribed_duration * 0.90
                ),
                1
            )

            # Usually less fluid removed
            fluid_removed = random.randint(
                int(uf_goal * 0.35),
                int(uf_goal * 0.80)
            )

        else:

            actual_duration = 0

            fluid_removed = 0

        # ---------------------------------------------
        # Start / End Time
        # ---------------------------------------------

        if session_status == "Missed":

            start_time = None
            end_time = None

        else:

            start_time, end_time = generate_session_times(
                actual_duration
            )

        generated_sessions.append({

            "patient_id": patient["patient_id"],

            "machine_id": machine_id,

            "staff_id": nurse["staff_id"],

            "session_date": session_date,

            "start_time": start_time,

            "end_time": end_time,

            "prescribed_duration": prescribed_duration,

            "actual_duration": actual_duration,

            "blood_flow_rate": blood_flow_rate,

            "dialysate_flow_rate": dialysate_flow_rate,

            "uf_goal": uf_goal,

            "fluid_removed": fluid_removed,

            "session_status": session_status

        })

print()
print("Session generation complete.")
print(f"Generated sessions: {len(generated_sessions)}")

# ==========================================================
# EXPORT SESSIONS TO SQL FILE
# ==========================================================

with open(OUTPUT_FILE, "w", encoding="utf-8") as file:

    file.write("-- Generated Dialysis Session Data\n")
    file.write("-- Synthetic data based on a Zambian dialysis centre scenario\n")
    file.write("-- Generated using Python\n\n")

    for session in generated_sessions:

        # Convert Python None to SQL NULL
        if session["start_time"] is None:
            start_time = "NULL"
        else:
            start_time = f"'{session['start_time']}'"

        if session["end_time"] is None:
            end_time = "NULL"
        else:
            end_time = f"'{session['end_time']}'"

        sql = f"""
INSERT INTO sessions
(
    patient_id,
    machine_id,
    staff_id,
    session_date,
    start_time,
    end_time,
    prescribed_duration_hours,
    actual_duration_hours,
    blood_flow_rate,
    dialysate_flow_rate,
    uf_goal_ml,
    fluid_removed_ml,
    session_status,
    notes
)
VALUES
(
    {session['patient_id']},
    {session['machine_id']},
    {session['staff_id']},
    '{session['session_date']}',
    {start_time},
    {end_time},
    {session['prescribed_duration']},
    {session['actual_duration']},
    {session['blood_flow_rate']},
    {session['dialysate_flow_rate']},
    {session['uf_goal']},
    {session['fluid_removed']},
    '{session['session_status']}',
    NULL
);

"""

        file.write(sql)

print()
print("SQL export complete.")
print(f"File created: {OUTPUT_FILE}")

cursor.close()
connection.close()
