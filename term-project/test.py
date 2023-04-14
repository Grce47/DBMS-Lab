import psycopg2
from utils import HOST, PASSWORD, DBNAME, PORT, USER



# Connect to the database
conn = psycopg2.connect(database=DBNAME, user=USER,
                        password=PASSWORD, host=HOST, port=PORT)


# create a cursor object to execute SQL queries
cur = conn.cursor()



cur.close()
conn.close()