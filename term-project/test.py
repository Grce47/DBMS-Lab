import psycopg2

# Set up the connection parameters
host = '10.5.18.71'
dbname = '20CS30022'
user = '20CS30022'
password = '20CS30022'
port = '5432'

# Establish the connection
conn = psycopg2.connect(
    host=host,
    dbname=dbname,
    user=user,
    password=password,
    port=port
)

# Open a cursor to perform database operations
cur = conn.cursor()

# Example query
cur.execute('SELECT * FROM actor;')

# Fetch the results
results = cur.fetchall()

# Print the results
for row in results:
    print(row)

# Close the cursor and connection
cur.close()
conn.close()
