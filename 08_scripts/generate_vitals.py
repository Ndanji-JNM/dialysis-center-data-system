"""
Dialysis Vital Signs Generator

Reads dialysis sessions from MySQL
and generates realistic pre/post dialysis vital signs.

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
# DATABASE CONNECTION
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
    uf_goal_ml,
    fluid_removed_ml,
    session_status
FROM sessions;
""")


sessions = cursor.fetchall()

print(f"Loaded {len(sessions)} dialysis sessions.")


# ==========================================================
# GENERATE VITAL PARAMETERS
# ==========================================================

def generate_vital_parameters(session):

    # Pre dialysis weight
    pre_weight = round(
        random.uniform(50, 95),
        1
    )


    # Weight removed based on fluid removed
    weight_loss = session["fluid_removed_ml"] / 1000


    post_weight = round(
        pre_weight - weight_loss + random.uniform(-0.2, 0.2),
        1
    )


    # Blood pressure before dialysis

    pre_systolic = random.randint(
        140,
        190
    )

    pre_diastolic = random.randint(
        80,
        110
    )


    # Blood pressure after dialysis

    post_systolic = pre_systolic - random.randint(
        5,
        25
    )

    post_diastolic = pre_diastolic - random.randint(
        3,
        15
    )


    # Pulse

    pre_pulse = random.randint(
        70,
        100
    )

    post_pulse = pre_pulse + random.randint(
        -5,
         5
    )


    return {

        "session_id": session["session_id"],

        "pre_systolic_bp": pre_systolic,

        "pre_diastolic_bp": pre_diastolic,

        "pre_pulse": pre_pulse,

        "pre_weight": pre_weight,

        "post_systolic_bp": post_systolic,

        "post_diastolic_bp": post_diastolic,

        "post_pulse": post_pulse,

        "post_weight": post_weight

    }

# ==========================================================
# GENERATE VITAL LOGS
# ==========================================================

generated_vitals = []


for session in sessions:

    if session["session_status"] == "Missed":
        continue


    vital = generate_vital_parameters(session)

    generated_vitals.append(vital)



print()
print("Vital generation complete.")
print(f"Generated vital records: {len(generated_vitals)}")


print()

for vital in generated_vitals[:5]:

    print(vital)

# ==========================================================
# CLOSE CONNECTION
# ==========================================================

cursor.close()
connection.close()

print()
print("Database connection closed.")