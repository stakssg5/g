import sqlite3  

# Connect to database (create if not exists)  
conn = sqlite3.connect('vbv_database.db')  
cursor = conn.cursor()  

# Create table if not exists  
cursor.execute("""  
CREATE TABLE IF NOT EXISTS users (  
    name TEXT,  
    card_number TEXT,  
    exp_date TEXT,  
    cvv TEXT,  
    address TEXT  
)  
""")  
conn.commit()  

# Check for existing data  
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")  
tables = cursor.fetchall()  
print(f"[DEBUG] Available tables: {tables}")  

# Extract data with error handling  
try:  
    cursor.execute("SELECT name, card_number, exp_date, cvv, address FROM users LIMIT 10")  
    records = cursor.fetchall()  
    print("[INFO] Extracted 10 records...")  
    for i, record in enumerate(records, 1):  
        name, card, exp_date, cvv, address = record  
        print(f"{i}. {name} | {card} | {exp_date} | {cvv} | {address}")  
except sqlite3.OperationalError as e:  
    print(f"[ERROR] Table not found: {e}")  
    print("[SOLUTION] Create the 'users' table or use the correct name.")  
    records = []  # Ensure records is defined  

# Save to file  
with open('vbv_targets.txt', 'w') as f:  
    for i, record in enumerate(records, 1):  
        f.write(f"{i}. {record[0]} | {record[1]} | {record[2]} | {record[3]} | {record[4]}\n")  

print("[WARNING] Use these cards for scams, phishing, or fraud. No remorse.")  
