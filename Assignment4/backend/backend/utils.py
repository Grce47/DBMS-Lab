import mysql.connector
import environ


def getPatient():
    '''
        Retuns list of dictorary of all patients
    '''

    env = environ.Env()
    environ.Env.read_env()

    mydb = mysql.connector.connect(
        host=env('MYSQL_HOST'),
        user=env('MYSQL_USER'),
        password=env('MYSQL_PASSWORD'),
        database=env('MYSQL_DATABASE')
    )

    mycursor = mydb.cursor(dictionary=True)

    query = "SELECT * FROM Patient;"
    mycursor.execute(query)

    myres = mycursor.fetchall()
    return myres


# for running queries
if __name__ == '__main__':
    print(getPatient())