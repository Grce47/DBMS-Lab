/*
 *    Grace Sharma 20CS30022
 *    Compile With Command : gcc assign3_20CS30022.c -o a.out `mysql_config --cflags --libs`
 *    Run Program : ./a.out
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>

// Space for formatting result
#define SPACE "40"

// Handling Errors
void finish_with_error(MYSQL *con)
{
    fprintf(stderr, "%s\n", mysql_error(con));
    mysql_close(con);
    exit(1);
}

// Function to do query and print Result
void do_query_and_print_result(MYSQL *con, const char *query)
{
    int i;

    // EXECUTING SQL QUERY
    if (mysql_query(con, query))
    {
        finish_with_error(con);
    }

    // BUFFER WHERE RESULT IS STORED
    MYSQL_RES *result = mysql_store_result(con);

    if (result == NULL)
    {
        finish_with_error(con);
    }

    int num_fields = mysql_num_fields(result);

    MYSQL_ROW row;
    MYSQL_FIELD *field;
    int cnt = 0, j, once = 1;

    const int SPACE_INT = atoi(SPACE);
    char printf_format[100];
    strcpy(printf_format, "%-");
    strcat(printf_format, SPACE);
    strcat(printf_format, "s");

    printf("\n");
    while ((row = mysql_fetch_row(result)))
    {
        for (i = 0; i < num_fields; i++)
        {
            if (i == 0)
            {
                while (field = mysql_fetch_field(result))
                {
                    printf(printf_format, field->name);
                    cnt++;
                }

                printf("\n");
                for (j = 0; j < (SPACE_INT * cnt) && once; j++)
                    printf("-");
                once = 0;
                printf("\n");
            }

            printf(printf_format, row[i] ? row[i] : "NULL");
        }
    }
    printf("\n");
    for (j = 0; j < (SPACE_INT * cnt); j++)
        printf("-");
    printf("\n\n");
    mysql_free_result(result);
}

// Menu Code
void menu_start(MYSQL *con)
{
    const int QUERY_SIZE = 100001, PROCEDURE_SIZE = 100;
    int tc = 0;
    char query[QUERY_SIZE], procedure[PROCEDURE_SIZE];
    do
    {
        printf("Enter query number (0 to exit) : ");
        scanf("%d", &tc);
        switch (tc)
        {
        case 0:
            break;
        case 1:
            strcpy(query, "SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X WHERE X.Name = \"bypass surgery\" and P.EmployeeID = T.Physician and T.Treatment = X.Code;");
            break;
        case 2:
            strcpy(query, "SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X, Affiliated_with as A, Department as D WHERE X.Name = \"bypass surgery\" and P.EmployeeID = T.Physician and T.Treatment = X.Code and A.Physician = P.EmployeeID and D.Name = \"cardiology\" and D.DepartmentID = A.Department; ");
            break;
        case 3:
            strcpy(query, "SELECT N.Name FROM Nurse as N WHERE exists ( SELECT * FROM On_Call as O, Block as B, Room as R WHERE R.Number = 123 and R.BlockCode = B.Code and R.BlockFloor = B.Floor and O.BlockCode = B.Code and O.BlockFloor = B.Floor and O.Nurse = N.EmployeeID ); ");
            break;
        case 4:
            strcpy(query, "SELECT P.Name, P.Address FROM Patient as P WHERE exists ( SELECT * FROM Medication as M, Prescribes as S WHERE S.Patient = P.SSN and S.Medication = M.Code and M.Name = \"remdesivir\" ); ");
            break;
        case 5:
            strcpy(query, "SELECT P.Name, P.InsuranceID FROM Patient as P WHERE exists ( SELECT * FROM ( SELECT Patient, Room, DATEDIFF(End,Start) as Days FROM Stay ) as S, Room as R WHERE S.Patient = P.SSN and S.Room = R.Number and R.Type = \"icu\" and S.Days > 15 );");
            break;
        case 6:
            strcpy(query, "SELECT N.Name FROM Nurse as N WHERE exists( SELECT * FROM `Procedure` as P, Undergoes as U WHERE P.Name = \"bypass surgery\" and P.Code = U.`Procedure` and U.AssistingNurse = N.EmployeeID );");
            break;
        case 7:
            strcpy(query, "SELECT N.Name,N.Position,P.name FROM Nurse as N, Physician as P, `Procedure` as X, Undergoes as U WHERE X.Name = \"bypass surgery\" and X.Code = U.`Procedure` and U.AssistingNurse = N.EmployeeID and U.Physician = P.EmployeeID; ");
            break;
        case 8:
            strcpy(query, "SELECT P.Name FROM Physician as P WHERE exists ( SELECT * FROM Undergoes as U, `Procedure` as X WHERE U.`Procedure` = X.Code and U.Physician = P.EmployeeID and not exists ( SELECT * FROM Trained_In as T WHERE T.Treatment = X.Code and T.Physician = P.EmployeeID ) );");
            break;
        case 9:
            strcpy(query, "SELECT P.Name FROM Physician as P  WHERE exists ( SELECT * FROM Undergoes as U, `Procedure` as X, Trained_In as T     WHERE U.Physician = P.EmployeeID and U.`Procedure` = X.Code and T.Physician = P.EmployeeID and T.Treatment = X.Code and U.Date > T.CertificationExpires );");
            break;
        case 10:
            strcpy(query, "SELECT P.Name,X.Name,U.Date,Y.Name FROM Physician as P, Undergoes as U, `Procedure` as X, Trained_In as T, Patient as Y WHERE U.Physician = P.EmployeeID and U.`Procedure` = X.Code and T.Physician = P.EmployeeID and  T.Treatment = X.Code and U.Date > T.CertificationExpires and U.Patient = Y.SSN; ");
            break;
        case 11:
            strcpy(query, "SELECT P.Name as Patient_Name, D.Name as Physician_Name  FROM Patient as P, Physician as D  WHERE P.PCP = D.EmployeeID and (SELECT Count(*) FROM ( SELECT * FROM Physician, Prescribes WHERE EmployeeID = Physician and Patient = P.SSN and Physician = D.EmployeeID ) as pres_num) > 0 and (SELECT Count(*) FROM ( SELECT SSN FROM Patient, `Procedure`, Undergoes WHERE Patient = SSN and `Procedure` = Code and Patient.SSN = P.SSN and `Procedure`.Cost > 5000 ) as cost_num ) > 0 and ( SELECT Count(*) FROM Appointment, Physician as B, Affiliated_with as A, Department WHERE Appointment.Patient = P.SSN and Appointment.Physician = B.EmployeeID and A.Physician = B.EmployeeID and Department = DepartmentID and Department.Name = 'cardiology' ) > 1 and (SELECT Count(*) FROM ( SELECT * FROM Department WHERE Head = D.EmployeeID ) as head_num ) = 0;");
            break;
        case 12:
            strcpy(query, "SELECT Z.Name, Z.Brand  FROM (SELECT Code,Brand,Name,(SELECT max(cnt) FROM ( SELECT (SELECT COUNT(*) FROM Prescribes as P WHERE P.Medication = M.Code) as cnt FROM Medication as M ) as T ) as max_val, ( SELECT COUNT(*) FROM Prescribes as S WHERE S.Medication = X.Code ) as cnt FROM Medication as X ) as Z WHERE Z.max_val = Z.cnt; ");
            break;
        case 13:
            printf("Enter Procedure Name : ");
            scanf(" %[^\n]", procedure);
            strcpy(query, "SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X WHERE X.Name = \"");
            strcat(query, procedure);
            strcat(query, "\" and P.EmployeeID = T.Physician and T.Treatment = X.Code;");
            break;
        default:
            printf("Invalid Input\n");
            tc = -1;
            break;
        }

        if (tc != 0 && tc != -1)
        {
            // CALLING QUERY HERE AND PRINTING RESULT
            do_query_and_print_result(con, query);
        }

    } while (tc != 0);
    printf("Exiting!!\n");
}

int main()
{
    const char *username = "root", *password = "20CS30022";
    
    // CONNECTING WITH DATABASE
    MYSQL *con = mysql_init(NULL);

    if (con == NULL)
    {
        fprintf(stderr, "%s\n", mysql_error(con));
        exit(1);
    }

    // LOGIN TO MYSQL SERVER
    if (mysql_real_connect(con, "localhost", username, password, NULL, 0, NULL, 0) == NULL)
    {
        finish_with_error(con);
    }

    // USE DATABASE
    if (mysql_query(con, "USE 20CS30022"))
    {
        finish_with_error(con);
    }

    // MENU START
    menu_start(con);

    // CLOSING MYSQL
    mysql_close(con);
    exit(0);
}