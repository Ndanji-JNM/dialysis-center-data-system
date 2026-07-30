"""
Dialysis Session Complication Generator

Reads dialysis sessions from MySQL
and generates realistic dialysis complications.

Author: Joseph Ndanji Muleba
Project: Dialysis Session Tracking System
"""

# ==========================================================
# IMPORTS
# ==========================================================

import random
from pathlib import Path

from db_connection import get_connection


# ==========================================================
# PROJECT PATHS
# ==========================================================

PROJECT_FOLDER = Path(__file__).resolve().parent.parent

OUTPUT_FILE = PROJECT_FOLDER / "01_database" / "generated_complications.sql"


# ==========================================================
# CONNECT TO DATABASE
# ==========================================================

connection = get_connection()

cursor = connection.cursor(dictionary=True)

print("Connected to MySQL database.")

# ==========================================================
# LOAD DIALYSIS SESSIONS
# ==========================================================

cursor.execute("""
SELECT
    session_id,
    session_status
FROM sessions;
""")

sessions = cursor.fetchall()

print(f"Loaded {len(sessions)} dialysis sessions.")

# ==========================================================
# COMPLICATION LIBRARY
# ==========================================================

complications = [

    {
        "type": "Muscle Cramps",
        "severity": "Mild",
        "intervention": "Saline administered and ultrafiltration reduced."
    },

    {
        "type": "Hypotension",
        "severity": "Moderate",
        "intervention": "Normal saline administered and patient placed in Trendelenburg position."
    },

    {
        "type": "Nausea",
        "severity": "Moderate",
        "intervention": "Dialysis slowed and antiemetic administered."
    },

    {
        "type": "Access Clotting",
        "severity": "Severe",
        "intervention": "Dialysis circuit replaced."
    },

    {
        "type": "Chest Pain",
        "severity": "Severe",
        "intervention": "Dialysis terminated and physician notified."
    },

    {
        "type": "Blood Leak Alarm",
        "severity": "Severe",
        "intervention": "Dialysis stopped and machine inspected."
    }

]

print()
print("Available complications:")

for complication in complications:

    print(complication)


# ==========================================================
# GENERATE COMPLICATIONS
# ==========================================================

generated_complications = []

for session in sessions:

    status = session["session_status"]

    # Missed sessions have no complications
    if status == "Missed":
        continue

    # Decide whether this session gets a complication
    if status == "Completed":
        has_complication = random.random() < 0.05

    elif status == "Interrupted":
        has_complication = random.random() < 0.80

    else:
        has_complication = False

    if not has_complication:
        continue

    complication = random.choices(
    complications,
    weights=[40,20,20,8,7,5],
    k=1
)[0]

    generated_complications.append({

        "session_id": session["session_id"],

        "complication_type": complication["type"],

        "severity": complication["severity"],

        "intervention": complication["intervention"]

    })


print()
print("Complication generation complete.")
print(f"Generated complications: {len(generated_complications)}")
print()

from collections import Counter


print()
print("Complication distribution:")
print("---------------------------")

complication_counts = Counter(
    item["complication_type"]
    for item in generated_complications
)


for complication, count in complication_counts.items():
    print(f"{complication}: {count}")

for complication in generated_complications[:5]:
    print(complication)


# ==========================================================
# EXPORT COMPLICATIONS TO SQL
# ==========================================================

OUTPUT_FILE = PROJECT_FOLDER / "01_database" / "generated_complications.sql"


with open(OUTPUT_FILE, "w", encoding="utf-8") as file:

    file.write("-- Generated Dialysis Complications\n")
    file.write("-- Synthetic data generated using Python\n\n")


    for complication in generated_complications:

        sql = f"""
INSERT INTO session_complications
(
    session_id,
    complication_type,
    severity,
    intervention
)
VALUES
(
    {complication['session_id']},
    '{complication['complication_type']}',
    '{complication['severity']}',
    '{complication['intervention']}'
);

"""

        file.write(sql)


print()
print("SQL export complete.")
print(f"File created: {OUTPUT_FILE}")

cursor.close()
connection.close()

print()
print("Database connection closed.")
