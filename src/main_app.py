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
# Additional READ queries (JOINs / aggregates)
# ---------------------------------------------------------
def list_hostages_with_police(connection):
    try:
        cursor = connection.cursor(dictionary=True)
        query = ("SELECT h.hostage_id, h.first_name AS hostage_first, h.last_name AS hostage_last, "
                 "h.status, h.zone, p.police_id, p.first_name AS police_first, p.last_name AS police_last "
                 "FROM HOSTAGES h LEFT JOIN POLICE p ON h.police_id = p.police_id "
                 "ORDER BY h.hostage_id")
        cursor.execute(query)
        rows = cursor.fetchall()
        print('\n📋 Hostages with assigned police:')
        for r in rows:
            print(r)
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


def equipment_by_safehouse(connection):
    try:
        cursor = connection.cursor(dictionary=True)
        query = ("SELECT s.safehouse_id, s.street, s.city, e.equipment_id, e.equipment_type, el.quantity "
                 "FROM SAFEHOUSE s JOIN EQUIPMENT_LOCATION el ON s.safehouse_id = el.safehouse_id "
                 "JOIN EQUIPMENT e ON el.equipment_id = e.equipment_id "
                 "ORDER BY s.safehouse_id, e.equipment_id")
        cursor.execute(query)
        rows = cursor.fetchall()
        print('\n🏠 Equipment by safehouse:')
        for r in rows:
            print(r)
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


def mission_members(connection):
    try:
        mcode = input('Enter mission code (e.g. M001): ').strip()
        cursor = connection.cursor(dictionary=True)
        query = ("SELECT me.mission_code, t.member_id, t.code_name, e.equipment_id, e.equipment_type "
                 "FROM MISSION_EXECUTION me "
                 "JOIN TEAM_MEMBERS t ON me.member_id = t.member_id "
                 "LEFT JOIN EQUIPMENT e ON me.equipment_id = e.equipment_id "
                 "WHERE me.mission_code = %s")
        cursor.execute(query, (mcode,))
        rows = cursor.fetchall()
        print(f'\n🎯 Members for mission {mcode}:')
        for r in rows:
            print(r)
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


def evidence_report(connection):
    try:
        cursor = connection.cursor(dictionary=True)
        query = ("SELECT e.evidence_id, e.police_id, e.description, e.found_time, e.threat_level, cd.mission_code "
                 "FROM EVIDENCE e LEFT JOIN COLLECTED_DURING cd "
                 "ON e.evidence_id = cd.evidence_id "
                 "ORDER BY e.found_time DESC")
        cursor.execute(query)
        rows = cursor.fetchall()
        print('\n🧾 Evidence report (with linked missions when available):')
        for r in rows:
            print(r)
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


def hostages_dependent_count(connection):
    try:
        cursor = connection.cursor(dictionary=True)
        query = ("SELECT h.hostage_id, h.first_name, h.last_name, COUNT(d.dependent_id) AS dependent_count "
                 "FROM HOSTAGES h LEFT JOIN DEPENDENTS d ON h.hostage_id = d.hostage_id "
                 "GROUP BY h.hostage_id ORDER BY dependent_count DESC")
        cursor.execute(query)
        rows = cursor.fetchall()
        print('\n📊 Hostages with number of dependents:')
        for r in rows:
            print(r)
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


# ---------------------------------------------------------
# Additional WRITE operations
# ---------------------------------------------------------
def insert_evidence(connection):
    try:
        print('\n🟢 Insert new evidence:')
        evidence_id = int(input('Evidence ID: '))
        police_id = int(input('Police ID (owner): '))
        description = input('Description: ')[:1000]
        use_now = input('Use current timestamp for found_time? (Y/n): ').strip().lower() or 'y'
        if use_now == 'y':
            found_time = None
        else:
            found_time = input('Found time (YYYY-MM-DD HH:MM:SS): ').strip()
        threat_level = input('Threat level (Low/Medium/High): ').strip()

        cursor = connection.cursor()
        if found_time:
            query = 'INSERT INTO EVIDENCE (evidence_id, police_id, description, found_time, threat_level) VALUES (%s,%s,%s,%s,%s)'
            cursor.execute(query, (evidence_id, police_id, description, found_time, threat_level))
        else:
            query = 'INSERT INTO EVIDENCE (evidence_id, police_id, description, found_time, threat_level) VALUES (%s,%s,%s,NOW(),%s)'
            cursor.execute(query, (evidence_id, police_id, description, threat_level))
        connection.commit()
        print('\n✅ Evidence inserted.')
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


def assign_equipment_location(connection):
    try:
        print('\n🟢 Assign equipment to safehouse (or update quantity):')
        equipment_id = int(input('Equipment ID: '))
        safehouse_id = int(input('Safehouse ID: '))
        qty = int(input('Quantity to set (will replace existing entry if present): '))

        cursor = connection.cursor()
        # Use INSERT ... ON DUPLICATE KEY UPDATE to set/replace quantity
        query = ('INSERT INTO EQUIPMENT_LOCATION (equipment_id, safehouse_id, quantity) VALUES (%s,%s,%s) '
                 'ON DUPLICATE KEY UPDATE quantity = VALUES(quantity)')
        cursor.execute(query, (equipment_id, safehouse_id, qty))
        connection.commit()
        print('\n✅ Equipment-location assigned/updated.')
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


def update_equipment_count(connection):
    try:
        equipment_id = int(input('Equipment ID to update: '))
        new_count = int(input('New equipment_count value: '))
        cursor = connection.cursor()
        query = 'UPDATE EQUIPMENT SET equipment_count = %s WHERE equipment_id = %s'
        cursor.execute(query, (new_count, equipment_id))
        connection.commit()
        print('\n🔄 Equipment count updated.')
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


def delete_equipment(connection):
    try:
        equipment_id = int(input('Equipment ID to delete: '))
        cursor = connection.cursor()
        query = 'DELETE FROM EQUIPMENT WHERE equipment_id = %s'
        cursor.execute(query, (equipment_id,))
        connection.commit()
        print('\n🗑️ Equipment deleted (if existed).')
        cursor.close()
    except Error as e:
        print(f"❌ Error: {e}")


# ---------------------------------------------------------
# 4. INSERT OPERATION (UPDATE)
# ---------------------------------------------------------
def add_new_hostage(connection):
    try:
        print("\n🟢 Enter new hostage details:")
        # Match the HOSTAGES schema columns exactly:
        # hostage_id, first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id
        hostage_id = int(input("Hostage ID: "))
        first_name = input("First Name: ").strip()
        mid_name = input("Middle Name (optional): ").strip() or None
        last_name = input("Last Name: ").strip()
        age = int(input("Age: "))
        status = input("Status (Pending/In-Progress/Resolved): ").strip()
        zone = input("Zone: ").strip()
        govt_posn = input("Govt Position (optional): ").strip() or None
        risk_factor = input("Risk Factor (Low/Medium/High): ").strip()
        police_id = input("Police ID (FK) - leave blank for NULL: ").strip()
        police_id_val = int(police_id) if police_id else None

        query = (
            "INSERT INTO HOSTAGES (hostage_id, first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id) "
            "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        )

        cursor = connection.cursor()
        cursor.execute(query, (hostage_id, first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id_val))
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
        print("6. List hostages with assigned police (JOIN)")
        print("7. List equipment by safehouse (JOIN)")
        print("8. Show mission members and equipment (JOIN)")
        print("9. Evidence report (LEFT JOIN to missions)")
        print("10. Hostages with dependent counts (AGGREGATE)")
        print("11. Insert new evidence (INSERT)")
        print("12. Assign equipment to safehouse (INSERT EQUIPMENT_LOCATION)")
        print("13. Update equipment count (UPDATE)")
        print("14. Delete equipment (DELETE)")
        print("15. Exit")
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
            list_hostages_with_police(connection)
        elif choice == "7":
            equipment_by_safehouse(connection)
        elif choice == "8":
            mission_members(connection)
        elif choice == "9":
            evidence_report(connection)
        elif choice == "10":
            hostages_dependent_count(connection)
        elif choice == "11":
            insert_evidence(connection)
        elif choice == "12":
            assign_equipment_location(connection)
        elif choice == "13":
            update_equipment_count(connection)
        elif choice == "14":
            delete_equipment(connection)
        elif choice == "15":
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
