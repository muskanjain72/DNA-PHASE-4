import mysql.connector
from mysql.connector import Error
from getpass import getpass
from colorama import Fore, Style, init

init(autoreset=True)


# ---------------------------------------------------------
# 1. CONNECT TO DATABASE
# ---------------------------------------------------------
def connect_db():
    print(Fore.CYAN + "\nEnter MySQL Credentials")
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user=input(Fore.YELLOW + "Enter MySQL username: "),
            password=getpass(Fore.YELLOW + "Enter MySQL password: "),
            database="money_heist"
        )

        if connection.is_connected():
            print(Fore.GREEN + "\n✔ Connected to MySQL database successfully.\n")
            return connection

    except Error as e:
        print(Fore.RED + f"❌ Error while connecting to MySQL: {e}")
        return None


# ---------------------------------------------------------
# Helper for nice printing
# ---------------------------------------------------------
def print_header(title):
    print(Fore.MAGENTA + "\n" + "=" * 70)
    print(Fore.MAGENTA + f"{title}".center(70))
    print(Fore.MAGENTA + "=" * 70 + "\n")


def print_rows(rows):
    if not rows:
        print(Fore.YELLOW + "⚠ No records found.\n")
        return
    for r in rows:
        print(Fore.CYAN + str(r))
    print("\n" + Fore.MAGENTA + "-" * 70)


# ---------------------------------------------------------
# READ QUERIES
# ---------------------------------------------------------
def view_all_hostages(connection):
    print_header("ALL HOSTAGES")
    try:
        cur = connection.cursor(dictionary=True)
        cur.execute("SELECT * FROM HOSTAGES")
        print_rows(cur.fetchall())
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ Error fetching hostages: {e}")


def get_hostage_by_id(connection):
    print_header("SEARCH HOSTAGE BY ID")
    try:
        hid = int(input("Enter Hostage ID: "))
        cur = connection.cursor(dictionary=True)
        cur.execute("SELECT * FROM HOSTAGES WHERE hostage_id=%s", (hid,))
        result = cur.fetchone()
        if result:
            print(Fore.GREEN + "\n🎯 Hostage Found:")
            print(Fore.CYAN + str(result))
        else:
            print(Fore.YELLOW + "\n⚠ No hostage found.")
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ Error: {e}")


def list_hostages_with_police(connection):
    print_header("HOSTAGES WITH ASSIGNED POLICE")
    try:
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT h.hostage_id, h.first_name AS hostage_first, h.last_name AS hostage_last,
               h.status, h.zone,
               p.police_id, p.first_name AS police_first, p.last_name AS police_last
        FROM HOSTAGES h
        LEFT JOIN POLICE p ON h.police_id = p.police_id
        ORDER BY h.hostage_id;
        """
        cur.execute(query)
        print_rows(cur.fetchall())
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def equipment_by_safehouse(connection):
    print_header("EQUIPMENT BY SAFEHOUSE")
    try:
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT s.safehouse_id, s.street, s.city,
               e.equipment_id, e.equipment_type, el.quantity
        FROM SAFEHOUSE s
        JOIN EQUIPMENT_LOCATION el ON s.safehouse_id = el.safehouse_id
        JOIN EQUIPMENT e ON el.equipment_id = e.equipment_id
        ORDER BY s.safehouse_id, e.equipment_id;
        """
        cur.execute(query)
        print_rows(cur.fetchall())
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def mission_members(connection):
    print_header("MISSION EXECUTION DETAILS")
    try:
        mcode = input("Enter Mission Code: ").strip()
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT me.mission_code, t.member_id, t.code_name,
               e.equipment_id, e.equipment_type
        FROM MISSION_EXECUTION me
        JOIN TEAM_MEMBERS t ON me.member_id = t.member_id
        LEFT JOIN EQUIPMENT e ON me.equipment_id = e.equipment_id
        WHERE me.mission_code = %s;
        """
        cur.execute(query, (mcode,))
        print_rows(cur.fetchall())
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def evidence_report(connection):
    print_header("EVIDENCE REPORT (WITH MISSIONS)")
    try:
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT e.evidence_id, e.police_id, e.description,
               e.found_time, e.threat_level,
               cd.mission_code
        FROM EVIDENCE e
        LEFT JOIN COLLECTED_DURING cd
        ON e.evidence_id = cd.evidence_id AND e.police_id = cd.police_id
        ORDER BY e.found_time DESC;
        """
        cur.execute(query)
        print_rows(cur.fetchall())
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def hostages_dependent_count(connection):
    print_header("HOSTAGES WITH DEPENDENT COUNTS")
    try:
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT h.hostage_id, h.first_name, h.last_name,
               COUNT(d.dependent_id) AS dependent_count
        FROM HOSTAGES h
        LEFT JOIN DEPENDENTS d ON h.hostage_id = d.hostage_id
        GROUP BY h.hostage_id
        ORDER BY dependent_count DESC;
        """
        cur.execute(query)
        print_rows(cur.fetchall())
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


# ---------------------------------------------------------
# WRITE OPERATIONS
# ---------------------------------------------------------
def insert_evidence(connection):
    print_header("INSERT NEW EVIDENCE")
    try:
        evidence_id = int(input("Evidence ID: "))
        police_id = int(input("Police ID: "))
        description = input("Description: ")
        threat_level = input("Threat Level: ")
        use_now = input("Use current timestamp? (Y/n): ").strip().lower()

        cur = connection.cursor()

        if use_now == 'n':
            ts = input("Enter timestamp (YYYY-MM-DD HH:MM:SS): ")
            query = """INSERT INTO EVIDENCE VALUES (%s,%s,%s,%s,%s)"""
            cur.execute(query, (evidence_id, police_id, description, ts, threat_level))
        else:
            query = """INSERT INTO EVIDENCE VALUES (%s,%s,%s,NOW(),%s)"""
            cur.execute(query, (evidence_id, police_id, description, threat_level))

        connection.commit()
        print(Fore.GREEN + "✔ Evidence inserted.")

        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def assign_equipment_location(connection):
    print_header("ASSIGN EQUIPMENT TO SAFEHOUSE")
    try:
        equipment_id = int(input("Equipment ID: "))
        safehouse_id = int(input("Safehouse ID: "))
        qty = int(input("Quantity: "))

        cur = connection.cursor()
        query = """
        INSERT INTO EQUIPMENT_LOCATION VALUES (%s,%s,%s)
        ON DUPLICATE KEY UPDATE quantity = VALUES(quantity);
        """
        cur.execute(query, (equipment_id, safehouse_id, qty))
        connection.commit()

        print(Fore.GREEN + "✔ Equipment assigned/updated.")
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def update_equipment_count(connection):
    print_header("UPDATE EQUIPMENT COUNT")
    try:
        equipment_id = int(input("Equipment ID: "))
        new_count = int(input("New Count: "))

        cur = connection.cursor()
        cur.execute("UPDATE EQUIPMENT SET equipment_count=%s WHERE equipment_id=%s",
                    (new_count, equipment_id))
        connection.commit()
        print(Fore.GREEN + "✔ Equipment updated.")
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def delete_equipment(connection):
    print_header("DELETE EQUIPMENT")
    try:
        equipment_id = int(input("Equipment ID: "))
        cur = connection.cursor()
        cur.execute("DELETE FROM EQUIPMENT WHERE equipment_id=%s", (equipment_id,))
        connection.commit()
        print(Fore.GREEN + "✔ Equipment deleted (if existed).")
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


# ---------------------------------------------------------
# MAIN MENU
# ---------------------------------------------------------
def main_menu(connection):
    while True:
        print(Fore.YELLOW + Style.BRIGHT + """
======================== MONEY HEIST DB MENU ========================
1.  View all hostages
2.  Search hostage by ID
3.  Add new hostage
4.  Update hostage status
5.  Delete hostage
6.  Hostages with assigned police (JOIN)
7.  Equipment by Safehouse (JOIN)
8.  Mission Members + Equipment (JOIN)
9.  Evidence Report (JOIN)
10. Hostages Dependent Count (GROUP BY)
11. Insert Evidence
12. Assign Equipment to Safehouse
13. Update Equipment Count
14. Delete Equipment
15. Exit
=====================================================================
""")

        ch = input(Fore.CYAN + "Enter choice: ")

        if ch == "1": view_all_hostages(connection)
        elif ch == "2": get_hostage_by_id(connection)
        elif ch == "3": add_new_hostage(connection)
        elif ch == "4": update_hostage_status(connection)
        elif ch == "5": delete_hostage(connection)
        elif ch == "6": list_hostages_with_police(connection)
        elif ch == "7": equipment_by_safehouse(connection)
        elif ch == "8": mission_members(connection)
        elif ch == "9": evidence_report(connection)
        elif ch == "10": hostages_dependent_count(connection)
        elif ch == "11": insert_evidence(connection)
        elif ch == "12": assign_equipment_location(connection)
        elif ch == "13": update_equipment_count(connection)
        elif ch == "14": delete_equipment(connection)
        elif ch == "15":
            print(Fore.GREEN + "\n👋 Exiting...")
            break
        else:
            print(Fore.RED + "❌ Invalid choice. Try again.")


# ---------------------------------------------------------
# MAIN
# ---------------------------------------------------------
if __name__ == "__main__":
    conn = connect_db()
    if conn:
        main_menu(conn)
        conn.close()
