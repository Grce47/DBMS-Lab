'''
    Grace Sharma 20CS30022

    requirements.txt:-
    mysql-connector-python==8.0.32
    protobuf==3.20.3
    tabulate==0.9.0
'''
import mysql.connector
from tabulate import tabulate


def do_query_and_print(cursor, query):
    '''
      Function to execute query and print result
    '''

    cursor.execute(query)
    myres = cursor.fetchall()
    print()
    print(tabulate(myres, headers=cursor.column_names, tablefmt='mysql'))
    print()


def main():
    # LOGIN to MYSQL SERVER
    mydb = mysql.connector.connect(
        host="10.5.18.71",
        user="20CS30022",
        password="20CS30022",
        database="20CS30022"
    )

    # INITIALIAZING CURSOR
    mycursor = mydb.cursor()
    # MENU CODE
    tc = 1
    query = ""
    while (tc != 0):
        tc = int(input("Enter query number (0 to exit) : "))

        if (tc == 0):
            continue
        elif tc == 1:
            query = 'SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X WHERE X.Name = "bypass surgery" and P.EmployeeID = T.Physician and T.Treatment = X.Code; '
        elif tc == 2:
            query = 'SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X, Affiliated_with as A, Department as D WHERE X.Name = "bypass surgery" and P.EmployeeID = T.Physician and T.Treatment = X.Code and A.Physician = P.EmployeeID and D.Name = "cardiology" and D.DepartmentID = A.Department; '
        elif tc == 3:
            query = 'SELECT N.Name FROM Nurse as N WHERE exists ( SELECT * FROM On_Call as O, Block as B, Room as R WHERE R.Number = 123 and R.BlockCode = B.Code and R.BlockFloor = B.Floor and O.BlockCode = B.Code and O.BlockFloor = B.Floor and O.Nurse = N.EmployeeID );'
        elif tc == 4:
            query = 'SELECT P.Name, P.Address FROM Patient as P WHERE exists ( SELECT * FROM Medication as M, Prescribes as S WHERE S.Patient = P.SSN and S.Medication = M.Code and M.Name = "remdesivir" );'
        elif tc == 5:
            query = 'SELECT P.Name, P.InsuranceID FROM Patient as P WHERE exists ( SELECT * FROM ( SELECT Patient, Room, DATEDIFF(End,Start) as Days FROM Stay ) as S, Room as R WHERE S.Patient = P.SSN and S.Room = R.Number and R.Type = "icu" and S.Days > 15 ); '
        elif tc == 6:
            query = 'SELECT N.Name FROM Nurse as N WHERE exists( SELECT * FROM `Procedure` as P, Undergoes as U WHERE P.Name = "bypass surgery" and P.Code = U.`Procedure` and U.AssistingNurse = N.EmployeeID ); '
        elif tc == 7:
            query = 'SELECT N.Name,N.Position,P.name FROM Nurse as N, Physician as P, `Procedure` as X, Undergoes as U WHERE X.Name = "bypass surgery" and X.Code = U.`Procedure` and U.AssistingNurse = N.EmployeeID and U.Physician = P.EmployeeID; '
        elif tc == 8:
            query = 'SELECT P.Name FROM Physician as P WHERE exists ( SELECT * FROM Undergoes as U, `Procedure` as X WHERE U.`Procedure` = X.Code and U.Physician = P.EmployeeID and not exists ( SELECT * FROM Trained_In as T WHERE T.Treatment = X.Code and T.Physician = P.EmployeeID ) );'
        elif tc == 9:
            query = 'SELECT P.Name FROM Physician as P WHERE exists ( SELECT * FROM Undergoes as U, `Procedure` as X, Trained_In as T WHERE U.Physician = P.EmployeeID and U.`Procedure` = X.Code and T.Physician = P.EmployeeID and T.Treatment = X.Code and U.Date > T.CertificationExpires );'
        elif tc == 10:
            query = 'SELECT P.Name,X.Name,U.Date,Y.Name FROM Physician as P, Undergoes as U, `Procedure` as X, Trained_In as T, Patient as Y WHERE U.Physician = P.EmployeeID and U.`Procedure` = X.Code and T.Physician = P.EmployeeID and  T.Treatment = X.Code and U.Date > T.CertificationExpires and U.Patient = Y.SSN; '
        elif tc == 11:
            query = 'SELECT P.Name as Patient_Name, D.Name as Physician_Name  FROM Patient as P, Physician as D WHERE P.PCP = D.EmployeeID and (SELECT Count(*) FROM ( SELECT * FROM Physician, Prescribes WHERE EmployeeID = Physician and Patient = P.SSN and Physician = D.EmployeeID ) as pres_num) > 0 and (SELECT Count(*) FROM ( SELECT SSN FROM Patient, `Procedure`, Undergoes WHERE Patient = SSN and `Procedure` = Code and Patient.SSN = P.SSN and `Procedure`.Cost > 5000 ) as cost_num ) > 0 and ( SELECT Count(*) FROM Appointment, Physician as B, Affiliated_with as A, Department WHERE Appointment.Patient = P.SSN and Appointment.Physician = B.EmployeeID and A.Physician = B.EmployeeID and Department = DepartmentID and Department.Name = "cardiology" ) > 1 and (SELECT Count(*) FROM ( SELECT * FROM Department WHERE Head = D.EmployeeID ) as head_num ) = 0; '
        elif tc == 12:
            query = 'SELECT Z.Name, Z.Brand FROM ( SELECT Code,Brand,Name,( SELECT max(cnt) FROM ( SELECT (SELECT COUNT(*) FROM Prescribes as P WHERE P.Medication = M.Code) as cnt FROM Medication as M ) as T ) as max_val, ( SELECT COUNT(*) FROM Prescribes as S WHERE S.Medication = X.Code ) as cnt FROM Medication as X ) as Z WHERE Z.max_val = Z.cnt; '
        elif tc == 13:
            procedure = input("Enter Procedure Name : ")
            query = f'SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X WHERE X.Name = "{procedure}" and P.EmployeeID = T.Physician and T.Treatment = X.Code; '
        else:
            print("Invalid Input")
            continue

        # EXECUTING QUERY
        do_query_and_print(mycursor, query)
    print("Exiting!")


if __name__ == "__main__":
    main()
