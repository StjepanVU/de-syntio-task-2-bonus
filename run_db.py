import sqlite3, time, os, csv, sys
from tabulate import tabulate

db_path = "db/database.sqlite"
init_scripts = [
    "scripts/create_tables.sql",
    "scripts/populate_db.sql"
]
report_script_path = "scripts/get_sales_report.sql"
monthly_revenue_script_path = "scripts/get_monthly_revenue_report.sql"

def initialize_db():
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    for script in init_scripts:
        with open(script, "r", encoding="utf-8") as file:
            sql_script = file.read()
            cursor.executescript(sql_script)
            print(f"Executed {script}")
    
    conn.commit()
    conn.close()
    print("Database initialized!")

def run_sales_report():
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    with open(report_script_path, "r", encoding="utf-8") as file:
        sql_query = file.read()
    
    start_time = time.time()

    try:
        cursor.execute(sql_query)
        rows = cursor.fetchall()

        end_time = time.time()

        columns = [description[0] for description in cursor.description]

        execution_time = end_time - start_time
        
        print("Sales Report:\n")
        print(tabulate(rows, headers=columns, tablefmt="fancy_grid"))
        print(f"\nExecution Time: {execution_time:.4f} seconds\n")
        
        # Generate a CSV file in the 'reports' folder
        reports_folder = "reports"
        os.makedirs(reports_folder, exist_ok=True)  # Create folder if it doesn't exist
        current_date = time.strftime("%Y-%m-%d_%H-%M-%S")
        csv_file_path = os.path.join(reports_folder, f"sales_report_{current_date}.csv")

        with open(csv_file_path, mode="w", newline="", encoding="utf-8") as csv_file:
            writer = csv.writer(csv_file)
            writer.writerow(columns)  # Write header row
            writer.writerows(rows)    # Write data rows

        print(f"CSV report generated at: {csv_file_path}")
        
    except sqlite3.Error as e:
        print(f"Error running report: {e}")

    conn.close()

def run_monthly_revenue():
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    with open(monthly_revenue_script_path, "r", encoding="utf-8") as file:
        sql_query = file.read()
    
    start_time = time.time()

    try:
        cursor.execute(sql_query)
        rows = cursor.fetchall()

        end_time = time.time()

        columns = [description[0] for description in cursor.description]

        execution_time = end_time - start_time
        
        print("Monthly Revenue Report:\n")
        print(tabulate(rows, headers=columns, tablefmt="fancy_grid"))
        print(f"\nExecution Time: {execution_time:.4f} seconds\n")
        
        # Generate a CSV file in the 'reports' folder
        reports_folder = "reports"
        os.makedirs(reports_folder, exist_ok=True)  # Create folder if it doesn't exist
        current_date = time.strftime("%Y-%m-%d_%H-%M-%S")
        csv_file_path = os.path.join(reports_folder, f"monthly_revenue_{current_date}.csv")

        with open(csv_file_path, mode="w", newline="", encoding="utf-8") as csv_file:
            writer = csv.writer(csv_file)
            writer.writerow(columns)  # Write header row
            writer.writerows(rows)    # Write data rows

        print(f"CSV report generated at: {csv_file_path}")
        
    except sqlite3.Error as e:
        print(f"Error running report: {e}")

    conn.close()

initialize_db()
run_sales_report()
time.sleep(1)
run_monthly_revenue()

if sys.stdin.isatty():
    input("Press Enter to exit...")
