import psycopg2
import psutil
from psycopg2.extras import RealDictCursor
from utils import HOST, PASSWORD, DBNAME, PORT, USER


# Connect to the database
conn = psycopg2.connect(database=DBNAME, user=USER,
                        password=PASSWORD, host=HOST, port=PORT)

# Create a cursor object
cur = conn.cursor(cursor_factory=RealDictCursor)

# Execute your query and measure the time
query = "SELECT * FROM actor;"
start_time = psutil.Process().cpu_times().user
cur.execute(query)
end_time = psutil.Process().cpu_times().user
execution_time = end_time - start_time
print(
    f"The execution time of query '{query}' is: {execution_time:.25f} seconds")

# Get memory usage information
process = psutil.Process()
memory_info = process.memory_info()
print(f"Memory usage: {memory_info.rss / 1024 / 1024:.2f} MB")

# Get query result and process it
result = cur.fetchall()
for row in result:
    # Process the row
    # print(row)
    continue
    # Close the cursor and connection
cur.close()
conn.close()
