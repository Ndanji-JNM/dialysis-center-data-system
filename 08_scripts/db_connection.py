import mysql.connector
def get_connection():
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Canada(2249).",
        database="dialysis_tracker"
    )
    return connection
if __name__ == "__main__":
    connection = get_connection()
    print("Database connection successful!")
    connection.close()