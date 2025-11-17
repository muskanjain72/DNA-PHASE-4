import pymysql
import sys
from getpass import getpass


# =====================================================
# DATABASE CONNECTION FUNCTION
# =====================================================
def get_db_connection(db_user, db_pass, db_host, db_name):
    """Establishes a connection to the MySQL database."""
    try:
        connection = pymysql.connect(
            host=db_host,
            user=db_user,
            password=db_pass,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor,  # Return results as dictionaries
            autocommit=False                         # We will manually commit
        )
        print("\nDatabase connection successful.\n")
        return connection

    except pymysql.Error as e:
        print(f"Error connecting to MySQL Database: {e}", file=sys.stderr)
        return None


# =====================================================
# SAMPLE QUERY: VIEW ALL HOSTAGES
# =====================================================
def view_all_hostages(connection):
    """Reads and prints all hostages."""
    print("\n--- HOSTAGE LIST ---\n")
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM HOSTAGES"
            cursor.execute(sql)
            results = cursor.fetchall()

            if not results:
                print("No hostages found.")
            else:
                for row in results:
                    print(row)

    except pymysql.Error as e:
        print(f"Error: {e}", file=sys.stderr)


# =====================================================
# SAMPLE QUERY: SEARCH HOSTAGE BY ID
# =====================================================
def search_hostage_by_id(connection):
    """Searches a hostage by hostage_id."""
    try:
        hid = input("Enter Hostage ID: ").strip()

        with connection.cursor() as cursor:
            sql = "SELECT * FROM HOSTAGES WHERE hostage_id = %s"
            cursor.execute(sql, (hid,))
            result = cursor.fetchone()

            if not result:
                print(f"No hostage found with ID {hid}")
            else:
                print("\nHostage Found:")
                print(result)

    except pymysql.Error as e:
        print(f"Error: {e}", file=sys.stderr)


# =====================================================
# INSERT OPERATION
# =====================================================
def add_hostage(connection):
    """Inserts a new hostage record."""
    try:
        print("\n--- Enter Hostage Details ---")
        data = (
            input("Hostage ID: ").strip(),
            input("First Name: "),
            input("Middle Name (optional): "),
            input("Last Name: "),
            input("Age: "),
            input("City: "),
            input("Status: "),
            input("Zone: "),
            input("Govt Position: "),
            input("Risk Factor: "),
            input("Assigned Police ID: ")
        )

        sql = """
        INSERT INTO HOSTAGES
        (hostage_id, first_name, mid_name, last_name, age, city, status, zone, govt_posn, risk_factor, police_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        with connection.cursor() as cursor:
            cursor.execute(sql, data)
            connection.commit()

        print("\nHostage added successfully!")

    except pymysql.Error as e:
        print(f"Insert Error: {e}", file=sys.stderr)


# =====================================================
# UPDATE OPERATION
# =====================================================
def update_hostage_status(connection):
    """Updates the status of a hostage."""
    try:
        hid = input("Enter Hostage ID to update: ").strip()
        new_status = input("Enter new status: ")

        sql = "UPDATE HOSTAGES SET status = %s WHERE hostage_id = %s"

        with connection.cursor() as cursor:
            cursor.execute(sql, (new_status, hid))
            connection.commit()

        print("\nHostage status updated successfully.")

    except pymysql.Error as e:
        print(f"Update Error: {e}", file=sys.stderr)


# =====================================================
# DELETE OPERATION
# =====================================================
def delete_hostage(connection):
    """Deletes a hostage using hostage_id."""
    try:
        hid = input("Enter Hostage ID to delete: ").strip()

        sql = "DELETE FROM HOSTAGES WHERE hostage_id = %s"

        with connection.cursor() as cursor:
            cursor.execute(sql, (hid,))
            connection.commit()

        print("\nHostage deleted successfully.")

    except pymysql.Error as e:
        print(f"Delete Error: {e}", file=sys.stderr)


# =====================================================
# MAIN CLI MENU
# =====================================================
def main_cli(connection):
    """Main command-line interface loop."""
    try:
        while True:
            print("\n========== MONEY HEIST DB INTERFACE ==========")
            print("1: View All Hostages (READ)")
            print("2: Search Hostage by ID (READ)")
            print("3: Add New Hostage (INSERT)")
            print("4: Update Hostage Status (UPDATE)")
            print("5: Delete Hostage (DELETE)")
            print("q: Quit")
            print("===============================================")

            choice = input("Enter your choice: ").strip().lower()

            if choice == '1':
                view_all_hostages(connection)
            elif choice == '2':
                search_hostage_by_id(connection)
            elif choice == '3':
                add_hostage(connection)
            elif choice == '4':
                update_hostage_status(connection)
            elif choice == '5':
                delete_hostage(connection)
            elif choice == 'q':
                print("\nExiting application...")
                break
            else:
                print("Invalid choice. Please try again.")

    finally:
        if connection:
            connection.close()
            print("Database connection closed.")


# =====================================================
# MAIN PROGRAM START
# =====================================================
if __name__ == "__main__":
    DB_HOST = 'localhost'
    DB_NAME = 'money_heist'

    print("Please enter your MySQL credentials.")
    DB_USER = input("Username: ").strip()
    DB_PASS = getpass("Password: ")

    db_conn = get_db_connection(DB_USER, DB_PASS, DB_HOST, DB_NAME)

    if db_conn:
        main_cli(db_conn)
    else:
        print("Failed to connect to database. Exiting...")
        sys.exit(1)
