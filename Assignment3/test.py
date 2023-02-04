import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="20CS30022",
  database="20CS30022"
)

mycursor = mydb.cursor()
