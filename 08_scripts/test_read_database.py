from db_connection import get_connection


connection = get_connection()

cursor = connection.cursor(dictionary=True)


cursor.execute("""
SELECT *
FROM patients
LIMIT 5;
""")


patients = cursor.fetchall()


for patient in patients:
    print(patient)


cursor.close()
connection.close()