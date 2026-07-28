from db_connection import get_connection


connection = get_connection()

cursor = connection.cursor(dictionary=True)


cursor.execute("""
SELECT 
    machine_id,
    machine_code,
    manufacturer,
    model,
    loop_number,
    status
FROM dialysis_machines;
""")


machines = cursor.fetchall()


for machine in machines:
    print(machine)


cursor.close()
connection.close()