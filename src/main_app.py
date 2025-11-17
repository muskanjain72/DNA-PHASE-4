import mysql.connector
from mysql.connector import Error


# ---------------------------------------------------------
# 1. CREATE A CONNECTION TO MYSQL DATABASE
# ---------------------------------------------------------
def connect_db():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user=input("Enter MySQL username: "),
            password=input("Enter MySQL password: "),
            database="money_heist"
        )

        if connection.is_connected():
            print("\n✅ Connected to MySQL database successfully.\n")
            return connection

    except Error as e:
        print(f"❌ Error while connecting to MySQL: {e}")
        return None


# ---------------------------------------------------------
# 2. EXAMPLE QUERY FUNCTION (READ)
# ---------------------------------------------------------
def view_all_hostages(connection):
    try:
        cursor = connection.cursor(dictionary=True)
        query = "SELECT * FROM HOSTAGES"
        cursor.execute(query)
        rows = cursor.fetchall()

        print("\n📌 All Hostages:\n")
        for row in rows:
            print(row)

        cursor.close()

    except Error as e:
        print(f"❌ Error fetching hostages: {e}")


# ---------------------------------------------------------
# 3. PARAMETERIZED SEARCH QUERY (READ)
# ---------------------------------------------------------
def get_hostage_by_id(connection):
    try:
        hid = int(input("Enter Hostage ID: "))

        cursor = connection.cursor(dictionary=True)
        query = "SELECT * FROM HOSTAGES WHERE hostage_id = %s"
        cursor.execute(query, (hid,))
        data = cursor.fetchone()

        if data:
            print("\n🎯 Hostage Found:")
            print(data)
        else:
            print("\n⚠️ No hostage found with this ID.")

        cursor.close()

    except Error as e:
        print(f"❌ Error: {e}")


# ---------------------------------------------------------
# 4. INSERT OPERATION (UPDATE)
# ---------------------------------------------------------
def add_new_hostage(connection):
    try:
        print("\n🟢 Enter new hostage details:")

        data = (
            int(input("Hostage ID: ")),
            input("First Name: "),
            input("Middle Name (optional): "),
            input("Last Name: "),
            int(input("Age: ")),
            input("City: "),
            input("Status: "),
            input("Zone: "),
            input("Govt Position: "),
            input("Risk Factor: "),
            int(input("Police ID (FK): "))
        )

        query = """
        INSERT INTO HOSTAGES 
        (hostage_id, first_name, mid_name, last_name, age, city, status, zone, govt_posn, risk_factor, police_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        cursor = connection.cursor()
        cursor.execute(query, data)
        connection.commit()

        print("\n✅ Hostage added successfully.")

        cursor.close()

    except Error as e:
        print(f"❌ Error inserting data: {e}")


# ---------------------------------------------------------
# 5. UPDATE OPERATION
# ---------------------------------------------------------
def update_hostage_status(connection):
    try:
        hid = int(input("Enter Hostage ID to update: "))
        new_status = input("Enter new status: ")

        cursor = connection.cursor()
        query = "UPDATE HOSTAGES SET status = %s WHERE hostage_id = %s"
        cursor.execute(query, (new_status, hid))
        connection.commit()

        print("\n🔄 Hostage status updated successfully.\n")

        cursor.close()

    except Error as e:
        print(f"❌ Error: {e}")


# ---------------------------------------------------------
# 6. DELETE OPERATION
# ---------------------------------------------------------
def delete_hostage(connection):
    try:
        hid = int(input("Enter Hostage ID to delete: "))

        cursor = connection.cursor()
        query = "DELETE FROM HOSTAGES WHERE hostage_id = %s"
        cursor.execute(query, (hid,))
        connection.commit()

        print("\n🗑️ Hostage deleted successfully.\n")

        cursor.close()

    except Error as e:
        print(f"❌ Error: {e}")


# ---------------------------------------------------------
# 7. MENU SYSTEM (CLI)
# ---------------------------------------------------------
def main_menu(connection):
    while True:

        print("\n================= MONEY HEIST DB MENU =================")
        print("1. View all hostages")
        print("2. Search hostage by ID")
        print("3. Add new hostage")
        print("4. Update hostage status")
        print("5. Delete hostage")
        print("6. Exit")
        print("========================================================")

        choice = input("\nEnter choice: ")

        if choice == "1":
            view_all_hostages(connection)
        elif choice == "2":
            get_hostage_by_id(connection)
        elif choice == "3":
            add_new_hostage(connection)
        elif choice == "4":
            update_hostage_status(connection)
        elif choice == "5":
            delete_hostage(connection)
        elif choice == "6":
            print("\n👋 Exiting program...")
            break
        else:
            print("\n⚠️ Invalid choice! Try again.")


# ---------------------------------------------------------
# 8. MAIN FUNCTION
# ---------------------------------------------------------
if __name__ == "__main__":
    conn = connect_db()
    if conn:
        main_menu(conn)
        conn.close()

# *******************************************
