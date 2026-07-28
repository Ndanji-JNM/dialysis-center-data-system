import random
from datetime import date, timedelta


# =====================================================
# Dialysis Session Data Generator
#
# Generates synthetic dialysis sessions
# for DRCDC (fictional Zambian dialysis centre)
#
# No real patient data is used.
# =====================================================


OUTPUT_FILE = "../database/generated_sessions.sql"


# Dialysis nurses
NURSES = [4, 5, 6]


# Machine assignment by infection status
MACHINE_MAP = {

    "None": [1, 2, 5],          # Loop 1

    "HIV": [3],                # Loop 2

    "Hepatitis C": [4],        # Loop 3

    "Hepatitis B": [6]         # Loop 4
}


# Session patterns
DAYS_A = [0, 2, 4]   # Mon Wed Fri
DAYS_B = [1, 3, 5]   # Tue Thu Sat


# Patient infection status
# Must match patient IDs from database

patients = [

    {"id":1, "infection":"None", "schedule":"A"},
    {"id":2, "infection":"None", "schedule":"B"},
    {"id":3, "infection":"None", "schedule":"A"},
    {"id":4, "infection":"None", "schedule":"B"},
    {"id":5, "infection":"None", "schedule":"A"},
    {"id":6, "infection":"None", "schedule":"B"},

    {"id":7, "infection":"HIV", "schedule":"A"},

    {"id":8, "infection":"None", "schedule":"B"},
    {"id":9, "infection":"None", "schedule":"A"},
    {"id":10,"infection":"None", "schedule":"B"},

    {"id":11,"infection":"None", "schedule":"A"},
    {"id":12,"infection":"None", "schedule":"B"},

    {"id":13,"infection":"Hepatitis C", "schedule":"A"},

    {"id":14,"infection":"None", "schedule":"B"},
    {"id":15,"infection":"None", "schedule":"A"},
    {"id":16,"infection":"None", "schedule":"B"},
    {"id":17,"infection":"None", "schedule":"A"},

    {"id":18,"infection":"HIV", "schedule":"B"},

    {"id":19,"infection":"None", "schedule":"A"},
    {"id":20,"infection":"None", "schedule":"B"},
    {"id":21,"infection":"None", "schedule":"A"},

    {"id":22,"infection":"Hepatitis B", "schedule":"B"},

    {"id":23,"infection":"None", "schedule":"A"},
    {"id":24,"infection":"None", "schedule":"B"},
    {"id":25,"infection":"None", "schedule":"A"},
    {"id":26,"infection":"None", "schedule":"B"},

    {"id":27,"infection":"HIV", "schedule":"A"},

    {"id":28,"infection":"None", "schedule":"B"},

    {"id":29,"infection":"Hepatitis C", "schedule":"A"},

    {"id":30,"infection":"None", "schedule":"B"}
]


def random_time():

    times = [
        "07:00:00",
        "12:00:00",
        "17:00:00"
    ]

    return random.choice(times)



def create_end_time(start):

    if start == "07:00:00":
        return "11:00:00"

    if start == "12:00:00":
        return "16:00:00"

    return "21:00:00"



def generate_session_values():

    sessions = []

    session_id = 1


    start_date = date(2024,1,1)

    end_date = date(2024,3,31)


    current = start_date


    while current <= end_date:


        for patient in patients:


            weekday = current.weekday()


            allowed_days = (
                DAYS_A
                if patient["schedule"] == "A"
                else DAYS_B
            )


            if weekday in allowed_days:


                machine = random.choice(
                    MACHINE_MAP[patient["infection"]]
                )


                nurse = random.choice(NURSES)


                prescribed = random.choice(
                    [4.0,4.0,4.0,3.5,4.5]
                )


                status = random.choices(
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


                if status == "Interrupted":

                    actual = random.choice(
                        [1.5,2.0,2.5,3.0]
                    )

                elif status == "Missed":

                    actual = 0

                else:

                    actual = prescribed



                uf_goal = random.choice(
                    [
                        1000,
                        1500,
                        2000,
                        2500,
                        3000,
                        3500,
                        4000
                    ]
                )


                # rare high UF
                if random.random() < 0.05:
                    uf_goal = random.choice(
                        [
                            4500,
                            5000
                        ]
                    )


                fluid_removed = uf_goal + random.randint(
                    -200,
                    200
                )


                if fluid_removed < 0:
                    fluid_removed = 0


                bfr = random.choice(
                    [
                        250,
                        300,
                        350,
                        400
                    ]
                )


                dfr = random.choice(
                    [
                        500,
                        700,
                        800
                    ]
                )


                start = random_time()

                end = create_end_time(start)


                notes = "Routine dialysis session"


                if status == "Interrupted":
                    notes = "Session interrupted due to clinical concern"


                sessions.append(
                    f"""(
{patient['id']},
{machine},
{nurse},
'{current}',
'{start}',
'{end}',
{prescribed},
{actual},
{bfr},
{dfr},
{uf_goal},
{fluid_removed},
'{status}',
'{notes}'
)"""
                )


                session_id += 1


        current += timedelta(days=1)


    return sessions



sessions = generate_session_values()



with open(OUTPUT_FILE,"w") as file:


    file.write(
"""-- =====================================================
-- Generated Dialysis Sessions
-- DRCDC Synthetic Dataset
-- =====================================================

USE dialysis_tracker;


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

"""
    )


    file.write(
        ",\n".join(sessions)
    )


    file.write(";")



print(
    f"Generated {len(sessions)} dialysis sessions"
)