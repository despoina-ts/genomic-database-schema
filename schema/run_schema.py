import mysql.connector
from pathlib import Path

HOST = "localhost"
USER = "root"
PASSWORD = "199613bill"

SQL_FILE = Path(__file__).parent / "schema" / "schema.sql"


def print_result(columns, rows):
    widths = [len(str(c)) for c in columns]
    for row in rows:
        for i, val in enumerate(row):
            widths[i] = max(widths[i], len(str(val)))

    header = " | ".join(str(columns[i]).ljust(widths[i]) for i in range(len(columns)))
    sep = "-+-".join("-" * widths[i] for i in range(len(columns)))
    print(header)
    print(sep)
    for row in rows:
        print(" | ".join(str(row[i]).ljust(widths[i]) for i in range(len(columns))))
    print()


with open(SQL_FILE, "r", encoding="utf-8") as f:
    sql_script = f.read()

conn = mysql.connector.connect(host=HOST, user=USER, password=PASSWORD)
cur = conn.cursor()

for res in cur.execute(sql_script, multi=True):
    if res.with_rows:
        rows = res.fetchall()
        cols = res.column_names
        print_result(cols, rows)
    else:
        conn.commit()

cur.close()
conn.close()
