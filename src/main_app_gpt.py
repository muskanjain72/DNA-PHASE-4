import mysql.connector
from mysql.connector import Error
from getpass import getpass
import sys
import time
from colorama import Fore, Style, init

init(autoreset=True)


# ======================================================
# 1. DATABASE CONNECTION
# ======================================================
def get_connection():
    print(Fore.CYAN + "\nEnter MySQL Credentials")
    user = input("Username: ").strip()
    pwd = getpass("Password: ")

    try:
        conn = mysql.connector.connect(
            host="localhost",
            user=user,
            password=pwd,
            database="money_heist"
        )

        if conn.is_connected():
            print(Fore.GREEN + "\n✔ Connected successfully.")
            return conn

    except Error as e:
        print(Fore.RED + f"✘ Could not connect: {e}")
        sys.exit(1)


# ======================================================
# Helper visuals
# ======================================================
def loading(msg="Processing"):
    print(Fore.YELLOW, msg, end="")
    for _ in range(3):
        print(".", end="")
        time.sleep(0.3)
    print()


def print_result(rows):
    print("\n")
    for row in rows:
        print(Fore.CYAN + str(row))
    print("\n" + "-" * 60)


# ======================================================
# READ QUERIES (Advanced & good for demo)
# ======================================================

def read_hostage_police(conn):
    sql = """
    SELECT H.hostage_id, H.first_name, H.last_name, H.status,
           P.first_name AS police_first, P.last_name AS police_last
    FROM HOSTAGES H
    LEFT JOIN POLICE P ON H.police_id = P.police_id
    ORDER BY H.hostage_id;
    """
    run_query(conn, sql)


def read_security_monitoring(conn):
    sql = """
    SELECT S.system_type, H.first_name, H.last_name
    FROM SECURITY_SYSTEM S
    JOIN MONITORED M ON S.system_id = M.system_id
    JOIN HOSTAGES H ON H.hostage_id = M.hostage_id;
    """
    run_query(conn, sql)


def read_mission_execution(conn):
    sql = """
    SELECT ME.mission_code, TM.code_name,
           E.equipment_type, SH.city
    FROM MISSION_EXECUTION ME
    JOIN TEAM_MEMBERS TM ON TM.member_id = ME.member_id
    JOIN EQUIPMENT E ON E.equipment_id = ME.equipment_id
    JOIN SAFEHOUSE SH ON SH.safehouse_id = ME.safehouse_id;
    """
    run_query(conn, sql)


def read_high_risk_police(conn):
    sql = """
    SELECT P.first_name, P.last_name, H.first_name AS hostage, H.risk_factor
    FROM POLICE P
    JOIN HOSTAGES H ON P.police_id = H.police_id
    WHERE H.risk_factor = 'High';
    """
    run_query(conn, sql)


def read_hostage_zone_counts(conn):
    sql = """
    SELECT zone, COUNT(*) AS total
    FROM HOSTAGES
    GROUP BY zone;
    """
    run_query(conn, sql)


# ======================================================
# WRITE OPERATIONS (SMART & RELEVANT)
# ======================================================

# 1) Assign a police officer to claim a hostage
def assign_police_claim(conn):
    print(Fore.CYAN + "\nAssign police to a hostage.")

    police_id = int(input("Enter police_id: "))
    hostage_id = int(input("Enter hostage_id: "))

    sql = "INSERT INTO CLAIMS (police_id, hostage_id) VALUES (%s, %s);"
    write_query(conn, sql, (police_id, hostage_id),
                "Police successfully assigned to hostage!")

    # Also reflect in HOSTAGES table
    sql2 = "UPDATE HOSTAGES SET police_id=%s WHERE hostage_id=%s"
    write_query(conn, sql2, (police_id, hostage_id),
                "Hostage updated with new police assignment!")


# 2) Add new communication log
def add_communication_log(conn):
    print(Fore.CYAN + "\nAdd Communication Log")

    ts = input("Timestamp (YYYY-MM-DD HH:MM:SS): ")
    msg_type = input("Message type: ")
    duration = int(input("Duration in seconds: "))
    content = input("Content: ")
    police_id = input("Police ID (or NULL): ")
    member_id = input("Team Member ID (or NULL): ")

    police_id = None if police_id.upper() == "NULL" else police_id
    member_id = None if member_id.upper() == "NULL" else member_id

    sql = """
    INSERT INTO COMMUNICATION_LOG
    (timestamp, msg_type, duration, content, police_id, member_id)
    VALUES (%s, %s, %s, %s, %s, %s)
    """

    params = (ts, msg_type, duration, content, police_id, member_id)
    write_query(conn, sql, params, "Communication log added!")


# 3) Add new evidence for a police officer
def add_evidence(conn):
    print(Fore.CYAN + "\nAdd Evidence for a Police Officer")

    police_id = int(input("Police ID: "))
    desc = input("Description: ")
    ts = input("Found time (YYYY-MM-DD HH:MM:SS): ")
    threat = input("Threat level: ")

    # compute next evidence_id for that police officer
    sql = "SELECT COALESCE(MAX(evidence_id),0) + 1 FROM EVIDENCE WHERE police_id=%s"
    cur = conn.cursor()
    cur.execute(sql, (police_id,))
    next_evid = cur.fetchone()[0]

    sql2 = """
    INSERT INTO EVIDENCE (evidence_id, police_id, description, found_time, threat_level)
    VALUES (%s, %s, %s, %s, %s)
    """
    params = (next_evid, police_id, desc, ts, threat)

    write_query(conn, sql2, params, "Evidence added successfully!")


# ======================================================
# GENERIC QUERY FUNCTIONS
# ======================================================

def run_query(conn, sql, params=None):
    try:
        cur = conn.cursor(dictionary=True)
        cur.execute(sql, params or ())
        rows = cur.fetchall()

        if not rows:
            print(Fore.YELLOW + "\nNo results.")
            return

        print_result(rows)

    except Error as e:
        print(Fore.RED + f"Query Error: {e}")


def write_query(conn, sql, params, success_msg):
    try:
        loading("Executing")
        cur = conn.cursor()
        cur.execute(sql, params)
        conn.commit()
        print(Fore.GREEN + "✔ " + success_msg)

    except Error as e:
        print(Fore.RED + f"Write Error: {e}")


# ======================================================
# MAIN MENU
# ======================================================

def main():
    conn = get_connection()

    while True:
        print(Fore.MAGENTA + Style.BRIGHT + """
=================== MONEY HEIST DB SYSTEM ===================

READ OPERATIONS:
1. Hostages with assigned police
2. Hostages monitored by security systems
3. Mission execution details
4. Police handling high-risk hostages
5. Hostage count by zone

WRITE OPERATIONS:
6. Assign police to hostage (CLAIMS + HOSTAGES)
7. Add communication log
8. Add evidence for police

q. Quit
==============================================================
""")

        choice = input(Fore.YELLOW + "Enter option: ").strip().lower()

        if choice == "1": read_hostage_police(conn)
        elif choice == "2": read_security_monitoring(conn)
        elif choice == "3": read_mission_execution(conn)
        elif choice == "4": read_high_risk_police(conn)
        elif choice == "5": read_hostage_zone_counts(conn)

        elif choice == "6": assign_police_claim(conn)
        elif choice == "7": add_communication_log(conn)
        elif choice == "8": add_evidence(conn)

        elif choice == "q":
            print(Fore.CYAN + "\nGoodbye!")
            conn.close()
            break

        else:
            print(Fore.RED + "Invalid choice. Try again.")


if __name__ == "__main__":
    main()
