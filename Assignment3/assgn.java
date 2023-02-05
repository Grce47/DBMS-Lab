/*
 *  JAVA file for a menu driven program to connect to an SQL database
 * and based on the query number given by the user, perform the
 * appropriate query on the database and show the results. 
*/
// export CLASSPATH=$CLASSPATH:/usr/share/java/mysql-connector-j-8.0.32.jar
import java.io.*;
import java.sql.*;

class assgn
{
    public static void main(String[] args) throws Exception
    {
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
        } 
        catch (SQLException e) {
            System.out.println("Connection Failed! Check output console.");
            e.printStackTrace();
            return;
        }

        if (connection != null) {
            System.out.println("Connected to the database!");
        } 
        else {
            System.out.println("Failed to make connection!");
        }

        // Create a statement
        Statement statement = connection.createStatement();
        ResultSet result = null;

        // Create a buffered reader to read from the console
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        
        // Menu driven program
        System.out.println("----------------------------------------------------------");
        System.out.println("## Choose the query number from the given queries:-");
        System.out.println("-- 1. Name of all physicians who are trained in procedure named `bypass surgery`");
        System.out.println("-- 2. Name of all physicians affiliated with the department name `cardiology` and trained in procedure named `bypass surgery`");
        System.out.println("-- 3. Name of all the nurses who have ever been on call for room 123.");
        System.out.println("-- 4. Name and address of all patients who were prescribed the medication named 'remdesivir'");
        System.out.println("-- 5. Name and InsuranceID of all patients who stayed in 'icu' room type for more than 15 days");
        System.out.println("-- 6. Name of all nurses who assisted in the procedure name 'bypass surgery'");
        System.out.println("-- 7. Name and position of all nurses who assisted in the procedure name 'bypass surgery' along with the names of all the accompanying physicians");
        System.out.println("-- 8. Obtain the names of all physicians who have performed a medical procedure they have never been trained to perform");
        System.out.println("-- 9. Names of all physicians who have performed a medical procedure they were trained to perform but the procedure was done at a date after the physician's certification expired.");
        System.out.println("-- 10. Same as above but with Name of Procedure, Date when procedure was carried out and the name of patient it was carried out on included");
        System.out.println("-- 11. Name of all patients including the name of the corresponding Physician such that: the patient has been prescribed some medication by her physician, has undergone a procedure with a cost larger than 5000, has had atleat 2 appointments where the physician was affiliated with 'cardiology' department and her physician is not the head of any dept.");
        System.out.println("-- 12. Name and brand of the medication(s) which has been prescribed to the highest number of patients");
        System.out.println("-- 13. Name of all physicians who are trained in procedure name given by user");
        System.out.println("-- 0. Exit the prompt.");
        System.out.println("----------------------------------------------------------");
        boolean exit = false;
        while (exit == false)
        {
            System.out.print("\nEnter the query number: ");
    
            // input the query number
            int query = Integer.parseInt(br.readLine());

            // execute the query
            switch (query)
            {  
                case 0:
                    System.out.println("Exiting...");
                    exit = true;
                    result = null;
                    break;

                case 1:
                    result = statement.executeQuery("SELECT Physician.Name FROM Physician, Trained_In, `Procedure` WHERE Physician.EmployeeID = Trained_In.Physician AND Trained_In.Treatment = `Procedure`.Code AND LOWER(`Procedure`.Name) = 'bypass surgery';");
                    break;

                case 2:
                    result = statement.executeQuery("SELECT Physician.Name FROM Physician, Affiliated_with, Department, Trained_In, `Procedure` WHERE Physician.EmployeeID = Affiliated_with.Physician AND Affiliated_with.Department = Department.DepartmentID AND Physician.EmployeeID = Trained_In.Physician AND Trained_In.Treatment = `Procedure`.Code AND LOWER(Department.Name) = 'cardiology' AND LOWER(`Procedure`.Name) = 'bypass surgery';");
                    break;
                
                case 3:
                    result = statement.executeQuery("SELECT DISTINCT Nurse.Name FROM Nurse, On_Call, Room WHERE Nurse.EmployeeID = On_Call.Nurse AND On_Call.BlockCode = Room.BlockCode AND On_Call.BlockFloor = Room.BlockFloor AND Room.`Number` = 123;");
                    break;
                
                case 4:
                    result = statement.executeQuery("SELECT DISTINCT Patient.Name, Patient.Address FROM Patient, Prescribes, Medication WHERE Prescribes.Patient = Patient.SSN AND Prescribes.Medication = Medication.Code AND LOWER(Medication.Name) = 'remdesivir';");
                    break;

                case 5:
                    result = statement.executeQuery("SELECT DISTINCT Patient.Name, Patient.InsuranceID FROM Patient, Room, Stay WHERE Patient.SSN = Stay.Patient AND Stay.Room = Room.Number AND LOWER(Room.Type) = 'icu' AND DATEDIFF(Stay.`End`, Stay.`Start`) > 15;");
                    break;

                case 6:
                    result = statement.executeQuery("SELECT DISTINCT Nurse.Name FROM Nurse, `Procedure`, Undergoes WHERE Undergoes.`Procedure` = `Procedure`.Code AND Undergoes.AssistingNurse = Nurse.EmployeeID AND LOWER(`Procedure`.Name) = 'bypass surgery';");
                    break;

                case 7:
                    result = statement.executeQuery("SELECT DISTINCT Nurse.Name, Nurse.Position, Physician.Name as `Name of Physician` FROM Nurse, `Procedure`, Undergoes, Physician WHERE Undergoes.`Procedure` = `Procedure`.Code AND Undergoes.AssistingNurse = Nurse.EmployeeID AND Undergoes.Physician = Physician.EmployeeID AND LOWER(`Procedure`.Name) = 'bypass surgery';");
                    break;

                case 8:
                    result = statement.executeQuery("SELECT DISTINCT p1.Name FROM Physician as p1, `Procedure`, Undergoes WHERE Undergoes.`Procedure` = `Procedure`.Code AND Undergoes.Physician = p1.EmployeeID AND `Procedure`.Code NOT IN (SELECT `Procedure`.Code FROM `Procedure`, Physician, Trained_In WHERE Trained_In.Physician = p1.EmployeeID AND Trained_In.Treatment = `Procedure`.Code);");
                    break;

                case 9:
                    result = statement.executeQuery("SELECT DISTINCT p1.Name FROM Physician as p1, Undergoes, `Procedure`, Trained_In WHERE `Procedure`.Code IN (SELECT `Procedure`.Code FROM `Procedure`, Trained_In  WHERE Trained_In.Physician = p1.EmployeeID AND Trained_In.Treatment = `Procedure`.Code) AND Undergoes.Physician = p1.EmployeeID AND Undergoes.`Procedure` = `Procedure`.Code AND Trained_In.Physician = p1.EmployeeID AND DATEDIFF(Undergoes.Date, Trained_In.CertificationExpires) > 0; ");
                    break;

                case 10:
                    result = statement.executeQuery("SELECT DISTINCT p1.Name as `Name of Physician`, `Procedure`.Name as `Name of Procedure`, Undergoes.Date, Patient.Name as `Name of Patient` FROM Physician as p1, Undergoes, `Procedure`, Trained_In, Patient WHERE Undergoes.Patient = Patient.SSN AND `Procedure`.Code IN (SELECT `Procedure`.Code FROM `Procedure`, Trained_In  WHERE Trained_In.Physician = p1.EmployeeID AND Trained_In.Treatment = `Procedure`.Code) AND Undergoes.Physician = p1.EmployeeID AND Undergoes.`Procedure` = `Procedure`.Code AND Trained_In.Physician = p1.EmployeeID AND DATEDIFF(Undergoes.Date, Trained_In.CertificationExpires) > 0; ");
                    break;

                case 11:
                    result = statement.executeQuery("SELECT DISTINCT p1.Name as `Name of Patient`, p2.Name as `Name of Physician` FROM Patient as p1, Physician as p2 WHERE p1.PCP = p2.EmployeeID AND EXISTS (SELECT * FROM Physician, Prescribes WHERE Physician.EmployeeID = Prescribes.Physician AND Prescribes.Patient = p1.SSN AND Prescribes.Physician = p2.EmployeeID) AND EXISTS (SELECT * FROM Patient, `Procedure`, Undergoes WHERE Undergoes.Patient = Patient.SSN AND Undergoes.`Procedure` = `Procedure`.Code AND Patient.SSN = p1.SSN AND Procedure.Cost > 5000) AND (SELECT COUNT(*) FROM Appointment, Physician, Affiliated_with, Department WHERE Appointment.Patient = p1.SSN AND Appointment.Physician = Physician.EmployeeID AND Affiliated_with.Physician = Physician.EmployeeID AND Department = DepartmentID AND LOWER(Department.Name) = 'cardiology') > 1 AND NOT EXISTS (SELECT * from Department WHERE Head = p2.EmployeeID);");
                    break;

                case 12:
                    result = statement.executeQuery("SELECT DISTINCT T1.`Name` as `Name of Medication`, T1.`Brand` as `Name of Brand` FROM (SELECT Medication.Name as `Name`, Medication.Brand as `Brand`, COUNT(Prescribes.Medication) as `Count` FROM Medication, Prescribes WHERE Medication.Code = Prescribes.Medication GROUP BY Prescribes.Medication ) as T1 WHERE T1.`Count` IN (SELECT MAX(T2.`Count`) FROM (SELECT Medication.Name as `Name`, Medication.Brand as `Brand`, COUNT(Prescribes.Medication) as `Count` FROM Medication, Prescribes WHERE Medication.Code = Prescribes.Medication GROUP BY Prescribes.Medication) as T2);");
                    break;
                
                case 13:
                    // input the name of the procedure
                    System.out.print("Enter the name of the procedure: ");
                    String procedureName = br.readLine();
                    result = statement.executeQuery("SELECT Physician.Name FROM Physician, Trained_In, `Procedure` WHERE Physician.EmployeeID = Trained_In.Physician AND Trained_In.Treatment = `Procedure`.Code AND LOWER(`Procedure`.Name) ='" + procedureName + "';");
                    break;

                default:
                    result = null;
                    System.out.println("Invalid query number!");
                    break;
            }

            // print the result in a properly formatted table
            if (result != null)
            {
                ResultSetMetaData rsmd = result.getMetaData();
                int columnsNumber = rsmd.getColumnCount();
                while (result.next()) {
                    for (int i = 1; i <= columnsNumber; i++) {
                        if (i > 1) System.out.print(",  ");
                        String columnValue = result.getString(i);
                        System.out.print(rsmd.getColumnName(i) + ": " + columnValue);
                    }
                    System.out.println("");
                }
            }

            System.out.println("----------------------------------------------------------");
        }

        // close the statement
        statement.close();

        // close the connection
        connection.close();
    }
}