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


def _print_and_run(cur, query, params=None):
    """Helper: print SQL and params, execute and return fetched rows (if any)."""
    print(Fore.BLUE + "\n-- SQL QUERY --")
    print(Fore.BLUE + query.strip())
    if params:
        print(Fore.BLUE + f"-- PARAMS: {params}")
    try:
        if params:
            cur.execute(query, params)
        else:
            cur.execute(query)
    except Error as e:
        print(Fore.RED + f"❌ SQL execution error: {e}")
        return []
    # If it's a SELECT-like query, fetch rows
    try:
        return cur.fetchall()
    except Exception:
        return []


def _print_and_exec(cur, query, params=None):
    """Helper for non-SELECT statements: print SQL, execute, and return affected rowcount."""
    print(Fore.BLUE + "\n-- SQL QUERY --")
    print(Fore.BLUE + query.strip())
    if params:
        print(Fore.BLUE + f"-- PARAMS: {params}")
    try:
        if params:
            cur.execute(query, params)
        else:
            cur.execute(query)
        return cur.rowcount
    except Error as e:
        print(Fore.RED + f"❌ SQL execution error: {e}")
        return 0


# ---------------------------------------------------------
# READ QUERIES
# ---------------------------------------------------------
def view_all_hostages(connection):
    print_header("ALL HOSTAGES")
    try:
        cur = connection.cursor(dictionary=True)
        rows = _print_and_run(cur, "SELECT * FROM HOSTAGES")
        print_rows(rows)
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ Error fetching hostages: {e}")


def get_hostage_by_id(connection):
    print_header("SEARCH HOSTAGE BY ID")
    try:
        hid = int(input("Enter Hostage ID: "))
        cur = connection.cursor(dictionary=True)
        rows = _print_and_run(cur, "SELECT * FROM HOSTAGES WHERE hostage_id=%s", (hid,))
        result = rows[0] if rows else None
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
        rows = _print_and_run(cur, query)
        print_rows(rows)
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
        rows = _print_and_run(cur, query)
        print_rows(rows)
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
        rows = _print_and_run(cur, query, (mcode,))
        print_rows(rows)
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
        rows = _print_and_run(cur, query)
        print_rows(rows)
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
        rows = _print_and_run(cur, query)
        print_rows(rows)
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


# ---------------------------------------------------------
# Additional complex READ queries (each prints SQL before running)
# ---------------------------------------------------------
def mission_summary(connection):
    """Summary per mission: member count, members list, safehouse and evidence count."""
    print_header("MISSION SUMMARY")
    try:
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT me.mission_code,
               COUNT(DISTINCT me.member_id) AS member_count,
               GROUP_CONCAT(DISTINCT t.code_name SEPARATOR ', ') AS members,
               GROUP_CONCAT(DISTINCT CONCAT(s.safehouse_id, ':', s.city) SEPARATOR ', ') AS safehouses,
               COUNT(DISTINCT cd.evidence_id) AS evidence_count
        FROM MISSION_EXECUTION me
        LEFT JOIN TEAM_MEMBERS t ON me.member_id = t.member_id
        LEFT JOIN SAFEHOUSE s ON me.safehouse_id = s.safehouse_id
        LEFT JOIN COLLECTED_DURING cd ON me.mission_code = cd.mission_code
        GROUP BY me.mission_code
        ORDER BY evidence_count DESC, member_count DESC;
        """
        rows = _print_and_run(cur, query)
        print_rows(rows)
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def police_activity_report(connection):
    """Activity per police: number of evidence items collected, missions involved, hostages claimed."""
    print_header("POLICE ACTIVITY REPORT")
    try:
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT p.police_id, p.first_name, p.last_name,
               COUNT(DISTINCT e.evidence_id) AS evidence_found,
               COUNT(DISTINCT cd.mission_code) AS missions_involved,
               COUNT(DISTINCT h.hostage_id) AS hostages_claimed
        FROM POLICE p
        LEFT JOIN EVIDENCE e ON p.police_id = e.police_id
        LEFT JOIN COLLECTED_DURING cd ON p.police_id = cd.police_id
        LEFT JOIN CLAIMS c ON p.police_id = c.police_id
        LEFT JOIN HOSTAGES h ON c.hostage_id = h.hostage_id
        GROUP BY p.police_id
        ORDER BY evidence_found DESC;
        """
        rows = _print_and_run(cur, query)
        print_rows(rows)
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def supplier_resource_usage(connection):
    """Which suppliers supply which safehouses and members (joins 3 tables)."""
    print_header("SUPPLIER -> RESOURCE COORDINATION -> SAFEHOUSE")
    try:
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT s.supplier_id, s.first_name, s.last_name,
               rc.member_id, tm.code_name AS member_code,
               rc.safehouse_id, sh.street AS safehouse_street, sh.city
        FROM SUPPLIER s
        JOIN RESOURCE_COORDINATION rc ON s.supplier_id = rc.supplier_id
        LEFT JOIN TEAM_MEMBERS tm ON rc.member_id = tm.member_id
        LEFT JOIN SAFEHOUSE sh ON rc.safehouse_id = sh.safehouse_id
        ORDER BY s.supplier_id, rc.safehouse_id;
        """
        rows = _print_and_run(cur, query)
        print_rows(rows)
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def high_risk_hostages_and_security(connection):
    """Hostages flagged High risk with their medical conditions and monitoring systems."""
    print_header("HIGH-RISK HOSTAGES & SECURITY MONITORING")
    try:
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT h.hostage_id, h.first_name, h.last_name,
               GROUP_CONCAT(DISTINCT hmc.hostage_ailment SEPARATOR '; ') AS ailments,
               GROUP_CONCAT(DISTINCT ss.system_type SEPARATOR '; ') AS monitoring_systems
        FROM HOSTAGES h
        LEFT JOIN HOSTAGE_MEDICAL_CONDITION hmc ON h.hostage_id = hmc.hostage_id
        LEFT JOIN MONITORED m ON h.hostage_id = m.hostage_id
        LEFT JOIN SECURITY_SYSTEM ss ON m.system_id = ss.system_id
        WHERE h.risk_factor = 'High'
        GROUP BY h.hostage_id
        ORDER BY h.hostage_id;
        """
        rows = _print_and_run(cur, query)
        print_rows(rows)
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ {e}")


def equipment_stock_alert(connection):
    """Aggregate equipment across safehouses and flag low stock items."""
    print_header("EQUIPMENT STOCK ALERT")
    try:
        threshold_raw = input("Show equipment with total quantity less than (default 50): ").strip()
        threshold = int(threshold_raw) if threshold_raw else 50
        cur = connection.cursor(dictionary=True)
        query = """
        SELECT e.equipment_id, e.equipment_type,
               SUM(el.quantity) AS total_quantity,
               GROUP_CONCAT(DISTINCT CONCAT(sh.safehouse_id, ':', sh.city) SEPARATOR ', ') AS locations
        FROM EQUIPMENT e
        LEFT JOIN EQUIPMENT_LOCATION el ON e.equipment_id = el.equipment_id
        LEFT JOIN SAFEHOUSE sh ON el.safehouse_id = sh.safehouse_id
        GROUP BY e.equipment_id
        HAVING total_quantity < %s
        ORDER BY total_quantity ASC;
        """
        rows = _print_and_run(cur, query, (threshold,))
        print_rows(rows)
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
# HOSTAGE CRUD helpers (missing implementations)
# ---------------------------------------------------------
def add_new_hostage(connection):
    """Insert a new hostage. hostage_id is AUTO_INCREMENT so we omit it."""
    print_header("ADD NEW HOSTAGE")
    try:
        first = input("First name: ").strip()
        mid = input("Middle name (or press Enter): ").strip() or None
        last = input("Last name: ").strip()
        age = input("Age (or press Enter): ").strip()
        age_val = int(age) if age else None
        status = input("Status (Pending/In-Progress/Resolved): ").strip() or 'Pending'
        zone = input("Zone (e.g., Vault A / Lobby): ").strip() or None
        govt_posn = input("Government position (or press Enter): ").strip() or None
        risk = input("Risk factor (Low/Medium/High): ").strip() or None
        police = input("Assigned police_id (or press Enter): ").strip()
        police_id = int(police) if police else None

        cur = connection.cursor()
        query = ("INSERT INTO HOSTAGES (first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id) "
                 "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)")
        cur.execute(query, (first, mid, last, age_val, status, zone, govt_posn, risk, police_id))
        connection.commit()
        print(Fore.GREEN + "✔ Hostage added.")
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ Error adding hostage: {e}")


def update_hostage_status(connection):
    """Update the status field for a hostage."""
    print_header("UPDATE HOSTAGE STATUS")
    try:
        hid = int(input("Enter Hostage ID: "))
        new_status = input("New status (Pending/In-Progress/Resolved): ").strip()
        cur = connection.cursor()
        cur.execute("UPDATE HOSTAGES SET status=%s WHERE hostage_id=%s", (new_status, hid))
        connection.commit()
        if cur.rowcount:
            print(Fore.GREEN + "✔ Hostage status updated.")
        else:
            print(Fore.YELLOW + "⚠ No hostage updated (id may not exist).")
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ Error updating hostage status: {e}")


def delete_hostage(connection):
    """Delete a hostage by id (with confirmation)."""
    print_header("DELETE HOSTAGE")
    try:
        hid = int(input("Enter Hostage ID to delete: "))
        confirm = input(Fore.RED + f"Type DELETE to confirm deletion of hostage {hid}: ").strip()
        if confirm != 'DELETE':
            print(Fore.YELLOW + "Deletion cancelled.")
            return
        cur = connection.cursor()
        cur.execute("DELETE FROM HOSTAGES WHERE hostage_id=%s", (hid,))
        connection.commit()
        if cur.rowcount:
            print(Fore.GREEN + "✔ Hostage deleted.")
        else:
            print(Fore.YELLOW + "⚠ No hostage deleted (id may not exist).")
        cur.close()
    except Error as e:
        print(Fore.RED + f"❌ Error deleting hostage: {e}")


# Backwards-compatible alias if any code expects this name
def search_hostage_by_id(connection):
    return get_hostage_by_id(connection)


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
15. Mission Summary (complex JOIN/AGG)
16. Police Activity Report (complex JOIN/AGG)
17. Supplier Resource Usage (3-table JOIN)
18. High-risk Hostages & Security (multi JOIN)
19. Equipment Stock Alert (aggregation + HAVING)
20. Exit
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
        elif ch == "15": mission_summary(connection)
        elif ch == "16": police_activity_report(connection)
        elif ch == "17": supplier_resource_usage(connection)
        elif ch == "18": high_risk_hostages_and_security(connection)
        elif ch == "19": equipment_stock_alert(connection)
        elif ch == "20":
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
