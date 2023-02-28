/*
    Grace Sharma 20CS30022
    Set Env Var:
        export CLASSPATH=$CLASSPATH:/usr/share/java/mysql-connector-j-8.0.32.jar
    Run Program:
        javac assign3_20CS30022.java && java assign3_20CS30022
*/
import java.io.*;
import java.sql.*;
import java.util.Formatter;

class assign3_20CS30022 {
    public static void main(String[] args) throws Exception {
        // load the JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Error in loading JDBC driver!");
            e.printStackTrace();
            return;
        }

        // Information about the database
        String hostname = "jdbc:mysql://10.5.18.71/20CS30022";
        String username = "20CS30022";
        String password = "20CS30022";

        // Connect to the database
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(hostname, username, password);
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console.");
            e.printStackTrace();
            return;
        }

        if (connection == null) {
            System.out.println("Failed to make connection!");
        }

        // Create a statement
        Statement statement = connection.createStatement();
        ResultSet result = null;

        // Create a buffered reader to read from the console
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int tc = 1;
        while (tc != 0) {
            System.out.print("Enter query number (0 to exit): ");

            // input the query number
            tc = Integer.parseInt(br.readLine());

            // execute the query
            switch (tc) {
                case 0:
                    break;
                case 1:
                    result = statement.executeQuery(
                            "SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X WHERE X.Name = \"bypass surgery\" and P.EmployeeID = T.Physician and T.Treatment = X.Code;");
                    break;

                case 2:
                    result = statement.executeQuery(
                            "SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X, Affiliated_with as A, Department as D WHERE X.Name = \"bypass surgery\" and P.EmployeeID = T.Physician and T.Treatment = X.Code and A.Physician = P.EmployeeID and D.Name = \"cardiology\" and D.DepartmentID = A.Department; ");
                    break;

                case 3:
                    result = statement.executeQuery(
                            "SELECT N.Name FROM Nurse as N WHERE exists ( SELECT * FROM On_Call as O, Block as B, Room as R WHERE R.Number = 123 and R.BlockCode = B.Code and R.BlockFloor = B.Floor and O.BlockCode = B.Code and O.BlockFloor = B.Floor and O.Nurse = N.EmployeeID ); ");
                    break;

                case 4:
                    result = statement.executeQuery(
                            "SELECT P.Name, P.Address FROM Patient as P WHERE exists ( SELECT * FROM Medication as M, Prescribes as S WHERE S.Patient = P.SSN and S.Medication = M.Code and M.Name = \"remdesivir\" ); ");
                    break;

                case 5:
                    result = statement.executeQuery(
                            "SELECT P.Name, P.InsuranceID FROM Patient as P WHERE exists ( SELECT * FROM ( SELECT Patient, Room, DATEDIFF(End,Start) as Days FROM Stay ) as S, Room as R WHERE S.Patient = P.SSN and S.Room = R.Number and R.Type = \"icu\" and S.Days > 15 );");
                    break;

                case 6:
                    result = statement.executeQuery(
                            "SELECT N.Name FROM Nurse as N WHERE exists( SELECT * FROM `Procedure` as P, Undergoes as U WHERE P.Name = \"bypass surgery\" and P.Code = U.`Procedure` and U.AssistingNurse = N.EmployeeID );");
                    break;

                case 7:
                    result = statement.executeQuery(
                            "SELECT N.Name,N.Position,P.name FROM Nurse as N, Physician as P, `Procedure` as X, Undergoes as U WHERE X.Name = \"bypass surgery\" and X.Code = U.`Procedure` and U.AssistingNurse = N.EmployeeID and U.Physician = P.EmployeeID; ");
                    break;

                case 8:
                    result = statement.executeQuery(
                            "SELECT P.Name FROM Physician as P WHERE exists ( SELECT * FROM Undergoes as U, `Procedure` as X WHERE U.`Procedure` = X.Code and U.Physician = P.EmployeeID and not exists ( SELECT * FROM Trained_In as T WHERE T.Treatment = X.Code and T.Physician = P.EmployeeID ) );");
                    break;

                case 9:
                    result = statement.executeQuery(
                            "SELECT P.Name FROM Physician as P  WHERE exists ( SELECT * FROM Undergoes as U, `Procedure` as X, Trained_In as T     WHERE U.Physician = P.EmployeeID and U.`Procedure` = X.Code and T.Physician = P.EmployeeID and T.Treatment = X.Code and U.Date > T.CertificationExpires );");
                    break;

                case 10:
                    result = statement.executeQuery(
                            "SELECT P.Name,X.Name,U.Date,Y.Name FROM Physician as P, Undergoes as U, `Procedure` as X, Trained_In as T, Patient as Y WHERE U.Physician = P.EmployeeID and U.`Procedure` = X.Code and T.Physician = P.EmployeeID and  T.Treatment = X.Code and U.Date > T.CertificationExpires and U.Patient = Y.SSN; ");
                    break;

                case 11:
                    result = statement.executeQuery(
                            "SELECT P.Name as Patient_Name, D.Name as Physician_Name  FROM Patient as P, Physician as D  WHERE P.PCP = D.EmployeeID and (SELECT Count(*) FROM ( SELECT * FROM Physician, Prescribes WHERE EmployeeID = Physician and Patient = P.SSN and Physician = D.EmployeeID ) as pres_num) > 0 and (SELECT Count(*) FROM ( SELECT SSN FROM Patient, `Procedure`, Undergoes WHERE Patient = SSN and `Procedure` = Code and Patient.SSN = P.SSN and `Procedure`.Cost > 5000 ) as cost_num ) > 0 and ( SELECT Count(*) FROM Appointment, Physician as B, Affiliated_with as A, Department WHERE Appointment.Patient = P.SSN and Appointment.Physician = B.EmployeeID and A.Physician = B.EmployeeID and Department = DepartmentID and Department.Name = 'cardiology' ) > 1 and (SELECT Count(*) FROM ( SELECT * FROM Department WHERE Head = D.EmployeeID ) as head_num ) = 0;");
                    break;

                case 12:
                    result = statement.executeQuery(
                            "SELECT Z.Name, Z.Brand  FROM (SELECT Code,Brand,Name,(SELECT max(cnt) FROM ( SELECT (SELECT COUNT(*) FROM Prescribes as P WHERE P.Medication = M.Code) as cnt FROM Medication as M ) as T ) as max_val, ( SELECT COUNT(*) FROM Prescribes as S WHERE S.Medication = X.Code ) as cnt FROM Medication as X ) as Z WHERE Z.max_val = Z.cnt; ");
                    break;

                case 13:
                    // input the name of the procedure
                    System.out.print("Enter Procedure Name : ");
                    String procedure = br.readLine();
                    result = statement.executeQuery(
                            "SELECT P.Name FROM Physician as P, Trained_In as T, `Procedure` as X WHERE X.Name = \""
                                    + procedure + "\" and P.EmployeeID = T.Physician and T.Treatment = X.Code;");
                    break;

                default:
                    tc = -1;
                    System.out.println("Invalid input");
                    break;
            }

            // print the result in a properly formatted table
            if (tc != 0 && tc != -1) {
                ResultSetMetaData rsmd = result.getMetaData();
                int columnsNumber = rsmd.getColumnCount();

                // Print the table in formatted way with column names
                Formatter fmt = new Formatter();

                for (int i = 1; i <= columnsNumber; i++) {
                    fmt.format("%-40s", rsmd.getColumnName(i));
                }
                System.out.println(fmt);
                fmt.close();
                
                fmt = new Formatter();

                for (int i = 1; i <= (40 * columnsNumber); i++)
                    System.out.print("-");

                System.out.print("\n");
                // Print the data
                while (result.next()) {

                    fmt.format("\n");
                    for (int i = 1; i <= columnsNumber; i++) {
                        fmt.format("%-40s", result.getString(i));
                    }
                }
                System.out.println(fmt);
                fmt.close();
                for (int i = 1; i <= (40 * columnsNumber); i++)
                    System.out.print("-");
                System.out.print("\n");
            }
        }

        System.out.println("Exiting!");

        // close the statement
        statement.close();

        // close the connection
        connection.close();
    }
}