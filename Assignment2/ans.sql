-- 1) Names of all physicians who are trained in procedure name “bypass surgery” 
SELECT P.Name 
FROM Physician as P, Trained_In as T, `Procedure` as X
WHERE X.Name = "bypass surgery" and P.EmployeeID = T.Physician and T.Treatment = X.Code;

-- 2) Names of all physicians affiliated with the department name “cardiology” and trained in “bypass surgery”
SELECT P.Name 
FROM Physician as P, Trained_In as T, `Procedure` as X, Affiliated_with as A, Department as D
WHERE X.Name = "bypass surgery" and P.EmployeeID = T.Physician and T.Treatment = X.Code and A.Physician = P.EmployeeID and D.Name = "cardiology" and D.DepartmentID = A.Department;

-- 3) Names of all the nurses who have ever been on call for room 123
SELECT N.Name
FROM Nurse as N
WHERE exists (
    SELECT * 
    FROM On_Call as O, Block as B, Room as R
    WHERE R.Number = 123 and R.BlockCode = B.Code and R.BlockFloor = B.Floor and O.BlockCode = B.Code and O.BlockFloor = B.Floor and O.Nurse = N.EmployeeID
);

-- 4) Names and addresses of all patients who were prescribed the medication named “remdesivir”
SELECT P.Name, P.Address
FROM Patient as P
WHERE exists (
    SELECT * 
    FROM Medication as M, Prescribes as S
    WHERE S.Patient = P.SSN and S.Medication = M.Code and M.Name = "remdesivir"
);

-- 5) Name and insurance id of all patients who stayed in the “icu” room type for more than 15 days
SELECT P.Name, P.InsuranceID
FROM Patient as P
WHERE exists (
    SELECT * 
    FROM 
    (
        SELECT Patient, Room, DATEDIFF(End,Start) as Days
        FROM Stay
    ) as S, Room as R
    WHERE S.Patient = P.SSN and S.Room = R.Number and R.Type = "icu" and S.Days > 15
);

-- 6) Names of all nurses who assisted in the procedure name “bypass surgery”
SELECT N.Name
FROM Nurse as N
WHERE exists(
    SELECT * 
    FROM `Procedure` as P, Undergoes as U
    WHERE P.Name = "bypass surgery" and P.Code = U.`Procedure` and U.AssistingNurse = N.EmployeeID
);

-- 7) Name and position of all nurses who assisted in the procedure name “bypass surgery” along with the names of and the accompanying physicians
SELECT N.Name,N.Position,P.name
FROM Nurse as N, Physician as P, `Procedure` as X, Undergoes as U
WHERE X.Name = "bypass surgery" and X.Code = U.`Procedure` and U.AssistingNurse = N.EmployeeID and U.Physician = P.EmployeeID;


-- 8) Obtain the names of all physicians who have performed a medical procedure they have never been trained to perform
SELECT P.Name
FROM Physician as P
WHERE exists
(
    SELECT * 
    FROM Undergoes as U, `Procedure` as X
    WHERE U.`Procedure` = X.Code and U.Physician = P.EmployeeID and not exists (
        SELECT *
        FROM Trained_In as T
        WHERE T.Treatment = X.Code and T.Physician = P.EmployeeID
    )
);

-- 9) Names of all physicians who have performed a medical procedure that they are trained to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires)
SELECT P.Name
FROM Physician as P 
WHERE exists (
    SELECT * 
    FROM Undergoes as U, `Procedure` as X, Trained_In as T
    WHERE U.Physician = P.EmployeeID and U.`Procedure` = X.Code and T.Physician = P.EmployeeID and T.Treatment = X.Code and U.Date > T.CertificationExpires
);

-- 10) Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on
SELECT P.Name,X.Name,U.Date,Y.Name
FROM Physician as P, Undergoes as U, `Procedure` as X, Trained_In as T, Patient as Y
WHERE U.Physician = P.EmployeeID and U.`Procedure` = X.Code and T.Physician = P.EmployeeID and  T.Treatment = X.Code and U.Date > T.CertificationExpires and U.Patient = Y.SSN;

-- 11) Names of all patients (also include, for each patient, the name of the patient's physician), such that all the following are true: • The patient has been prescribed some medication by his/her physician • The patient has undergone a procedure with a cost larger that 5000 • The patient has had at least two appointment where the physician was affiliated with the cardiology department • The patient's physician is not the head of any department
SELECT P.Name as Patient_Name, D.Name as Physician_Name 
FROM Patient as P, Physician as D 
WHERE P.PCP = D.EmployeeID and (SELECT Count(*) FROM (
    SELECT * 
    FROM Physician, Prescribes 
    WHERE EmployeeID = Physician and Patient = P.SSN 
    and Physician = D.EmployeeID
) as pres_num) > 0 and (SELECT Count(*) FROM (
    SELECT SSN 
    FROM Patient, `Procedure`, Undergoes 
    WHERE Patient = SSN and `Procedure` = Code and Patient.SSN = P.SSN and `Procedure`.Cost > 5000
) as cost_num ) > 0 and (
    SELECT Count(*) 
    FROM Appointment, Physician as B, Affiliated_with as A, Department 
    WHERE Appointment.Patient = P.SSN and Appointment.Physician = B.EmployeeID and A.Physician = B.EmployeeID and Department = DepartmentID and Department.Name = 'cardiology'
) > 1 and (SELECT Count(*) FROM (
        SELECT * 
        FROM Department 
        WHERE Head = D.EmployeeID
    ) as head_num
) = 0;

-- 12) Name and brand of the medication which has been prescribed to the highest number of patients
SELECT Z.Name, Z.Brand 
FROM (
        SELECT Code,Brand,Name,(
                                    SELECT max(cnt)
                                    FROM 
                                    (
                                        SELECT (SELECT COUNT(*) FROM Prescribes as P WHERE P.Medication = M.Code) as cnt
                                        FROM Medication as M
                                    ) as T
                                ) as max_val, 
                                (
                                    SELECT COUNT(*) FROM Prescribes as S WHERE S.Medication = X.Code
                                ) as cnt
        FROM Medication as X
) as Z
WHERE Z.max_val = Z.cnt;
