CREATE TABLE Physician ( 
    EmployeeID INT NOT NULL PRIMARY KEY, 
    Name TEXT NOT NULL, 
    Position TEXT NOT NULL, 
    SSN INT NOT NULL
);

CREATE TABLE Department ( 
    DepartmentID INT NOT NULL PRIMARY KEY, 
    Name TEXT NOT NULL, 
    Head INT NOT NULL, 
    FOREIGN KEY (Head) REFERENCES Physician(EmployeeID) 
);

CREATE TABLE Affiliated_with (
    Physician INT NOT NULL,
    Department INT NOT NULL,
    PrimaryAffiliation BOOLEAN NOT NULL ,
    PRIMARY KEY ( Physician, Department ),
    FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
    FOREIGN KEY (Department) REFERENCES Department(DepartmentID)
);

CREATE TABLE `Procedure` (
    Code INT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Cost INT NOT NULL
);

CREATE TABLE Trained_In(
    Physician INT NOT NULL,
    Treatment INT NOT NULL, 
    CertificationDate DATETIME NOT NULL,
    CertificationExpires DATETIME NOT NULL,
    PRIMARY KEY ( Physician, Treatment),
    FOREIGN KEY ( Physician ) REFERENCES Physician(EmployeeID),
    FOREIGN KEY ( Treatment ) REFERENCES `Procedure`(Code)
);

CREATE TABLE Patient (
    SSN INT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Address TEXT NOT NULL,
    Phone TEXT NOT NULL,
    InsuranceID INT NOT NULL,
    PCP INT NOT NULL,
    FOREIGN KEY (PCP) REFERENCES Physician(EmployeeID)
);

CREATE TABLE Block (
    Floor INT NOT NULL,
    Code INT NOT NULL,
    PRIMARY KEY (Floor, Code)
);

CREATE TABLE Nurse (
    EmployeeID INT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Position TEXT NOT NULL,
    Registered BOOLEAN NOT NULL,
    SSN INT NOT NULL
);

CREATE TABLE On_Call(
    Nurse INT NOT NULL,
    BlockFloor INT NOT NULL,
    BlockCode INT NOT NULL,
    Start DATETIME NOT NULL,
    End DATETIME NOT NULL,
    PRIMARY KEY (Nurse,BlockFloor,BlockCode,Start,End),
    FOREIGN KEY (Nurse) REFERENCES Nurse(EmployeeID),
    FOREIGN KEY (BlockFloor,BlockCode) REFERENCES Block(Floor,Code)
);

CREATE TABLE Room(
    Number INT NOT NULL PRIMARY KEY,
    Type TEXT NOT NULL,
    BlockFloor INT NOT NULL,
    BlockCode INT NOT NULL,
    Unavailable BOOLEAN NOT NULL,
    FOREIGN KEY (BlockFloor,BlockCode) REFERENCES Block(Floor,Code)
);

CREATE TABLE Stay (
    StayID INT NOT NULL PRIMARY KEY,
    Patient INT NOT NULL,
    Room INT NOT NULL,
    Start DATETIME NOT NULL,
    End DATETIME NOT NULL,
    FOREIGN KEY (Patient) REFERENCES Patient(SSN),
    FOREIGN KEY (Room) REFERENCES Room(Number)
);

CREATE TABLE Undergoes(
    Patient INT NOT NULL,
    `Procedure` INT NOT NULL,
    Stay INT NOT NULL,
    Date DATETIME NOT NULL,
    Physician INT NOT NULL,
    AssistingNurse INT,
    PRIMARY KEY (Patient,`Procedure`,Stay,Date),
    FOREIGN KEY (Patient) REFERENCES Patient(SSN),
    FOREIGN KEY (`Procedure`) REFERENCES `Procedure`(Code),
    FOREIGN KEY (Stay) REFERENCES Stay(StayID),
    FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
    FOREIGN KEY (AssistingNurse) REFERENCES Nurse(EmployeeID)
);

CREATE TABLE Medication(
    Code INT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Brand TEXT NOT NULL,
    Description TEXT NOT NULL
);

CREATE TABLE Appointment(
    AppointmentID INT NOT NULL PRIMARY KEY,
    Patient INT NOT NULL,
    PrepNurse INT,
    Physician INT NOT NULL,
    Start DATETIME NOT NULL,
    End DATETIME NOT NULL,
    ExaminationRoom TEXT NOT NULL,
    FOREIGN KEY (Patient) REFERENCES Patient(SSN),
    FOREIGN KEY (PrepNurse) REFERENCES Nurse(EmployeeID),
    FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID)
);

CREATE TABLE Prescribes (
    Physician INT NOT NULL,
    Patient INT NOT NULL,
    Medication INT NOT NULL,
    Date DATETIME NOT NULL,
    Appointment INT,
    Dose TEXT NOT NULL,
    PRIMARY KEY(Physician,Patient,Medication,Date),
    FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
    FOREIGN KEY (Patient) REFERENCES Patient(SSN),
    FOREIGN KEY (Medication) REFERENCES Medication(Code),
    FOREIGN KEY (Appointment) REFERENCES Appointment(AppointmentID)
);


-- INSERTING 40 Physician
insert into Physician (EmployeeID, Name, Position, SSN) values (1, 'Derrik Mainwaring', 'Radiologist', '2174');
insert into Physician (EmployeeID, Name, Position, SSN) values (2, 'Tymothy Jzhakov', 'Dermatologist', '0150');
insert into Physician (EmployeeID, Name, Position, SSN) values (3, 'Tynan Keel', 'Psychiatrist', '4026');
insert into Physician (EmployeeID, Name, Position, SSN) values (4, 'Bradney Dymond', 'Dermatologist', '1688');
insert into Physician (EmployeeID, Name, Position, SSN) values (5, 'Perry Aizik', 'Radiologist', '4790');
insert into Physician (EmployeeID, Name, Position, SSN) values (6, 'Niven Burdess', 'Dermatologist', '9864');
insert into Physician (EmployeeID, Name, Position, SSN) values (7, 'Franzen Bassill', 'Dermatologist', '8168');
insert into Physician (EmployeeID, Name, Position, SSN) values (8, 'Judon O''Sherrin', 'Dermatologist', '8416');
insert into Physician (EmployeeID, Name, Position, SSN) values (9, 'Henri Baumler', 'Radiologist', '6334');
insert into Physician (EmployeeID, Name, Position, SSN) values (10, 'Alyda Pagin', 'Psychiatrist', '0955');
insert into Physician (EmployeeID, Name, Position, SSN) values (11, 'Bruno Enriques', 'Dermatologist', '5152');
insert into Physician (EmployeeID, Name, Position, SSN) values (12, 'Elaina Longshaw', 'Dermatologist', '9112');
insert into Physician (EmployeeID, Name, Position, SSN) values (13, 'Jeromy Baggally', 'Obstetrician', '3085');
insert into Physician (EmployeeID, Name, Position, SSN) values (14, 'Cosmo Dorran', 'Psychiatrist', '0929');
insert into Physician (EmployeeID, Name, Position, SSN) values (15, 'Deerdre Bilbrooke', 'Psychiatrist', '5455');
insert into Physician (EmployeeID, Name, Position, SSN) values (16, 'Dallis Fagg', 'Dermatologist', '0386');
insert into Physician (EmployeeID, Name, Position, SSN) values (17, 'Bertie Wintle', 'Psychiatrist', '4874');
insert into Physician (EmployeeID, Name, Position, SSN) values (18, 'Quentin Windaybank', 'Emergency Medicine Physician', '3845');
insert into Physician (EmployeeID, Name, Position, SSN) values (19, 'Delcina Absolem', 'Dermatologist', '0588');
insert into Physician (EmployeeID, Name, Position, SSN) values (20, 'Curr Guyton', 'Dermatologist', '4511');
insert into Physician (EmployeeID, Name, Position, SSN) values (21, 'Lizzie Ashfield', 'Psychiatrist', '4446');
insert into Physician (EmployeeID, Name, Position, SSN) values (22, 'Ellery Killoran', 'Specialist', '9784');
insert into Physician (EmployeeID, Name, Position, SSN) values (23, 'Leann Beedell', 'Dermatologist', '1070');
insert into Physician (EmployeeID, Name, Position, SSN) values (24, 'Rona Everard', 'Psychiatrist', '3240');
insert into Physician (EmployeeID, Name, Position, SSN) values (25, 'Raymund Giurio', 'Psychiatrist', '8296');
insert into Physician (EmployeeID, Name, Position, SSN) values (26, 'Dwight Sedgemond', 'Dermatologist', '8513');
insert into Physician (EmployeeID, Name, Position, SSN) values (27, 'Ramon Ketton', 'Dermatologist', '9537');
insert into Physician (EmployeeID, Name, Position, SSN) values (28, 'Trenton Dredge', 'Dermatologist', '1125');
insert into Physician (EmployeeID, Name, Position, SSN) values (29, 'Em Ishchenko', 'Psychiatrist', '1496');
insert into Physician (EmployeeID, Name, Position, SSN) values (30, 'Ailyn Livens', 'Psychiatrist', '5929');
insert into Physician (EmployeeID, Name, Position, SSN) values (31, 'Man Kirk', 'Dermatologist', '9651');
insert into Physician (EmployeeID, Name, Position, SSN) values (32, 'Corinna Schrei', 'Dermatologist', '5930');
insert into Physician (EmployeeID, Name, Position, SSN) values (33, 'Ilaire Writer', 'Psychiatrist', '2448');
insert into Physician (EmployeeID, Name, Position, SSN) values (34, 'Kiley Leall', 'Psychiatrist', '5311');
insert into Physician (EmployeeID, Name, Position, SSN) values (35, 'Gwendolen Agdahl', 'Dermatologist', '2721');
insert into Physician (EmployeeID, Name, Position, SSN) values (36, 'Morganica Chamney', 'Psychiatrist', '6515');
insert into Physician (EmployeeID, Name, Position, SSN) values (37, 'Magdalene Hathorn', 'Dermatologist', '0729');
insert into Physician (EmployeeID, Name, Position, SSN) values (38, 'Kizzee Dummett', 'Dermatologist', '0916');
insert into Physician (EmployeeID, Name, Position, SSN) values (39, 'Wain Ibbetson', 'Dermatologist', '0867');
insert into Physician (EmployeeID, Name, Position, SSN) values (40, 'Mohammed Dobrovsky', 'Dermatologist', '1362');

-- inserting 40 Trained_In
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (4, 6, '2021-04-27 17:13:19', '2022-12-14 18:52:55');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (36, 6, '2021-04-03 04:09:41', '2022-05-18 10:22:00');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (24, 3, '2021-07-13 09:18:35', '2022-09-17 09:09:21');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (21, 1, '2021-01-22 09:59:28', '2023-10-26 21:48:42');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (30, 4, '2021-10-29 05:58:18', '2022-05-09 05:19:32');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (10, 4, '2021-03-26 06:10:40', '2023-05-10 16:45:03');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (34, 6, '2021-02-14 15:31:17', '2022-01-28 01:52:06');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (35, 1, '2021-12-10 02:00:30', '2023-08-03 00:28:01');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (24, 2, '2021-12-17 04:46:15', '2022-05-10 07:19:53');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (37, 6, '2021-06-17 22:07:23', '2022-03-20 01:12:37');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (36, 1, '2021-01-16 14:05:14', '2022-02-26 08:26:38');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (15, 1, '2021-02-18 12:31:53', '2022-03-22 18:05:05');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (35, 4, '2021-04-20 17:35:11', '2023-02-01 08:12:32');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (3, 4, '2021-10-24 22:29:43', '2023-01-30 22:19:11');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (20, 1, '2021-07-02 08:53:54', '2022-05-20 14:08:08');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (39, 3, '2021-11-27 05:38:01', '2023-12-16 02:42:15');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (12, 2, '2021-07-28 05:00:14', '2022-02-01 09:42:48');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (1, 2, '2021-12-20 11:33:43', '2022-12-10 18:44:51');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (32, 5, '2021-05-31 01:21:15', '2022-09-14 19:00:04');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (21, 2, '2021-10-16 22:10:49', '2022-06-22 16:56:15');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (27, 2, '2021-07-27 20:59:22', '2023-09-22 10:31:51');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (22, 2, '2021-01-14 09:07:38', '2023-08-20 05:09:55');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (25, 5, '2021-01-05 11:03:55', '2022-09-15 22:56:50');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (25, 3, '2021-03-16 08:27:50', '2023-01-22 10:10:36');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (21, 4, '2021-08-09 17:07:20', '2022-11-02 01:30:07');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (5, 6, '2021-02-27 12:41:39', '2023-09-23 01:28:32');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (20, 1, '2021-03-11 02:37:07', '2022-03-03 10:26:12');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (28, 3, '2021-05-03 09:35:35', '2022-09-12 17:39:08');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (4, 4, '2021-08-16 08:15:22', '2023-04-14 18:25:48');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (29, 1, '2021-10-17 06:18:50', '2023-12-12 04:41:56');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (10, 4, '2021-04-20 07:36:05', '2023-02-17 10:01:55');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (27, 1, '2021-10-07 07:09:14', '2023-09-25 02:25:04');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (19, 3, '2021-03-09 16:06:02', '2023-05-17 06:46:48');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (26, 5, '2021-03-04 05:49:27', '2023-02-09 14:47:31');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (9, 3, '2021-10-19 18:32:26', '2023-12-19 07:06:59');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (23, 5, '2021-11-12 04:02:26', '2022-10-07 13:02:19');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (36, 4, '2021-11-28 00:48:37', '2023-01-12 12:23:15');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (4, 2, '2021-06-04 21:53:51', '2022-09-17 00:00:00');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (28, 4, '2021-06-06 17:51:39', '2023-02-21 06:21:38');
insert into Trained_In (Physician, Treatment, CertificationDate, CertificationExpires) values (9, 5, '2021-07-11 23:50:34', '2022-12-26 04:22:11');


-- inserting 30 Patient
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (1, 'Blanch Gilfillan', 'PO Box 90536', '314-870-9640', '59769', 14);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (2, 'Bondon Hanratty', 'Apt 200', '867-987-4380', '45529', 20);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (3, 'Woody Spalding', 'PO Box 41525', '625-615-5238', '43883', 40);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (4, 'Willi Faulconbridge', 'PO Box 48212', '624-970-1433', '37688', 25);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (5, 'Mathilde Burress', 'Suite 80', '301-897-2014', '40631', 31);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (6, 'Nannie Myrie', 'Room 504', '548-199-2252', '88380', 12);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (7, 'Aldridge Bandey', 'Room 423', '418-169-5516', '15205', 8);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (8, 'Audry Buffin', 'Apt 365', '670-399-2247', '96950', 26);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (9, 'Willem Boanas', '4th Floor', '835-513-4767', '27948', 20);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (10, 'Nady Shurrock', 'PO Box 18152', '946-609-0166', '03648', 4);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (11, 'Shep Kastel', '6th Floor', '275-330-9160', '67347', 9);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (12, 'Christie Patise', 'Room 1398', '525-250-3533', '92239', 30);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (13, 'Cesar Rann', '8th Floor', '168-800-3630', '19867', 10);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (14, 'Lanna Tonepohl', 'PO Box 68173', '765-245-5225', '86278', 14);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (15, 'Ricard Gentiry', '14th Floor', '933-993-8797', '72533', 39);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (16, 'Marsh Prendeville', 'PO Box 49866', '252-731-7075', '13419', 39);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (17, 'Caril Sayle', 'Room 1680', '433-378-3659', '39414', 18);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (18, 'Maryjo Probbings', 'Room 65', '952-573-7197', '86543', 24);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (19, 'Korie Brazur', 'Suite 83', '993-716-5710', '76266', 25);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (20, 'Donia Saffrin', 'Apt 562', '596-801-0404', '57499', 14);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (21, 'Caralie Turley', 'Suite 25', '982-638-5232', '23214', 26);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (22, 'Rudy Salzberger', 'Room 632', '624-414-2174', '16104', 39);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (23, 'Ardelle Housen', 'Apt 1783', '339-932-3717', '15997', 26);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (24, 'Gallard Isakowicz', 'Room 643', '828-985-7296', '49219', 37);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (25, 'Bridget Estcot', 'PO Box 49142', '638-242-3529', '12850', 34);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (26, 'Kara Corse', 'Suite 62', '550-741-5121', '94725', 29);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (27, 'Cami Yanez', 'Suite 68', '840-409-8482', '53481', 1);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (28, 'Miner Eseler', 'Room 1822', '556-355-4251', '33254', 31);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (29, 'Pattie Stanyer', 'PO Box 41866', '498-134-6676', '32194', 6);
insert into Patient (SSN, Name, Address, Phone, InsuranceID, PCP) values (30, 'Christopher Jacobs', 'Suite 75', '523-138-8951', '58206', 33);

-- inserting  6 Departments
insert into Department (DepartmentID, Name, Head) values (1, 'Obstetrics and gynecology (OB/GYN)', 11);
insert into Department (DepartmentID, Name, Head) values (2, 'Intensive care unit (ICU)', 11);
insert into Department (DepartmentID, Name, Head) values (3, 'Pediatrics', 30);
insert into Department (DepartmentID, Name, Head) values (4, 'Radiology', 4);
insert into Department (DepartmentID, Name, Head) values (5, 'Emergency department', 15);
insert into Department (DepartmentID, Name, Head) values (6, 'cardiology', 12);

-- inserting 25 Affiliated_with
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (32, 3, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (14, 4, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (19, 3, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (27, 6, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (37, 6, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (1, 6, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (32, 5, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (31, 5, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (29, 3, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (36, 5, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (17, 3, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (15, 5, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (17, 6, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (34, 5, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (23, 4, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (6, 5, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (29, 2, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (24, 2, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (23, 2, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (10, 4, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (9, 5, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (3, 2, true);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (3, 6, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (20, 5, false);
insert into Affiliated_with (Physician, Department, PrimaryAffiliation) values (17, 2, true);

-- inserting 5 procedures
insert into `Procedure` (Code, Name, Cost) values (1, 'follow-up appointments', 4951);
insert into `Procedure` (Code, Name, Cost) values (2, 'bypass surgery', 5297);
insert into `Procedure` (Code, Name, Cost) values (3, 'physical examination', 5217);
insert into `Procedure` (Code, Name, Cost) values (4, 'referral to specialists', 5318);
insert into `Procedure` (Code, Name, Cost) values (5, 'diagnostic testing ', 4659);


-- inserting 2 block
insert into Block (Floor, Code) values (1 , 0);
insert into Block (Floor, Code) values (1 , 1);

-- inserting 50 rooms
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (100, 'er', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (101, 'icu', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (102, 'icu', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (103, 'er', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (104, 'er', 1, 1, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (105, 'icu', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (106, 'er', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (107, 'icu', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (108, 'icu', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (109, 'er', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (110, 'or', 1, 1, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (111, 'or', 1, 1, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (112, 'or', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (113, 'or', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (114, 'or', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (115, 'er', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (116, 'er', 1, 1, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (117, 'er', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (118, 'icu', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (119, 'er', 1, 1, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (120, 'icu', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (121, 'er', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (122, 'or', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (123, 'icu', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (124, 'icu', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (125, 'or', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (126, 'or', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (127, 'icu', 1, 1, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (128, 'er', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (129, 'or', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (130, 'or', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (131, 'er', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (132, 'icu', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (133, 'icu', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (134, 'icu', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (135, 'er', 1, 1, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (136, 'or', 1, 1, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (137, 'icu', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (138, 'er', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (139, 'or', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (140, 'er', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (141, 'or', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (142, 'or', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (143, 'icu', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (144, 'or', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (145, 'or', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (146, 'er', 1, 0, true);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (147, 'icu', 1, 1, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (148, 'or', 1, 0, false);
insert into Room (Number, Type, BlockFloor, BlockCode, Unavailable) values (149, 'er', 1, 1, true);

-- inserting 40 Nurse
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (1, 'Prescott Spillane', 'Hospice and Palliative Care Nurse', false, '116');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (2, 'Elyssa Pottiphar', 'Clinical Nurse Specialist (CNS)', true, '27781');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (3, 'Lyell Lownie', 'Critical Care Nurse', true, '1');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (4, 'Sharity D''Oyley', 'Licensed Practical Nurse (LPN)', true, '6');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (5, 'Ellery Bolzmann', 'Clinical Nurse Specialist (CNS)', true, '1');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (6, 'Wendel de Najera', 'Emergency Room Nurse', true, '792');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (7, 'Caitrin Kubik', 'Registered Nurse (RN)', false, '651');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (8, 'Pebrook Jouanny', 'Certified Nursing Assistant (CNA)', true, '9');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (9, 'Halsey Pyne', 'Pediatric Nurse', true, '3');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (10, 'Livy Leveridge', 'Nurse Practitioner (NP)', true, '8');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (11, 'Fey Vedenyakin', 'Certified Nursing Assistant (CNA)', false, '00');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (12, 'Nye McLaggan', 'Licensed Practical Nurse (LPN)', true, '43377');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (13, 'Pyotr Caldicot', 'Certified Nursing Assistant (CNA)', true, '1');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (14, 'Dwain Chaim', 'Emergency Room Nurse', true, '06');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (15, 'Adham Vanlint', 'Clinical Nurse Specialist (CNS)', true, '0841');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (16, 'Elsa Clears', 'Licensed Practical Nurse (LPN)', false, '46886');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (17, 'Worden Extall', 'Clinical Nurse Specialist (CNS)', true, '79753');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (18, 'Mala Tilbey', 'Licensed Practical Nurse (LPN)', true, '34');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (19, 'Nicko Willsmore', 'Certified Nursing Assistant (CNA)', true, '4147');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (20, 'Emelia Colwill', 'Critical Care Nurse', false, '29');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (21, 'Madelaine Gerrelt', 'Certified Nursing Assistant (CNA)', false, '77');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (22, 'Hayes Farndon', 'Certified Nursing Assistant (CNA)', true, '06701');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (23, 'Towny Scouse', 'Certified Nursing Assistant (CNA)', true, '23789');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (24, 'Andrea Hoyt', 'Clinical Nurse Specialist (CNS)', false, '4370');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (25, 'Marlo Drohun', 'Clinical Nurse Specialist (CNS)', true, '89213');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (26, 'Massimo Boncoeur', 'Nurse Practitioner (NP)', true, '99552');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (27, 'Tannie Curtain', 'Certified Nursing Assistant (CNA)', false, '005');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (28, 'Frank Etherson', 'Pediatric Nurse', false, '7');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (29, 'Harper Rolstone', 'Operating Room Nurse', true, '70');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (30, 'Siegfried Sute', 'Clinical Nurse Specialist (CNS)', false, '6');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (31, 'Lyon Lively', 'Pediatric Nurse', true, '48277');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (32, 'Kitty Rubertelli', 'Critical Care Nurse', false, '12');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (33, 'Yevette Mc Harg', 'Nurse Practitioner (NP)', false, '90');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (34, 'Lucina Lichfield', 'Pediatric Nurse', false, '04');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (35, 'Rutherford Alldis', 'Critical Care Nurse', true, '7561');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (36, 'Sabra Tite', 'Clinical Nurse Specialist (CNS)', false, '1298');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (37, 'Colver Connop', 'Licensed Practical Nurse (LPN)', true, '704');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (38, 'Maynord Tuxell', 'Hospice and Palliative Care Nurse', false, '8888');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (39, 'Bibbie Casterou', 'Critical Care Nurse', false, '70680');
insert into Nurse (EmployeeID, Name, Position, Registered, SSN) values (40, 'Katee Petracek', 'Clinical Nurse Specialist (CNS)', true, '5');


-- inserting 50 On_Calls
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (11, 1, 0, '2022-03-11 15:30:58', '2022-12-22 00:06:04');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (13, 1, 0, '2022-02-18 10:52:50', '2022-11-16 01:50:57');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (33, 1, 1, '2022-07-01 04:32:55', '2022-05-03 02:56:52');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (4, 1, 0, '2022-04-24 10:35:17', '2023-01-25 05:25:00');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (25, 1, 1, '2022-11-02 23:02:33', '2022-08-20 02:12:43');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (24, 1, 0, '2022-01-20 05:16:24', '2022-05-24 16:05:43');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (10, 1, 0, '2022-10-26 15:48:34', '2022-08-22 04:48:27');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (15, 1, 1, '2022-02-21 15:58:38', '2022-07-18 23:46:47');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (7, 1, 0, '2022-06-08 11:41:21', '2022-10-08 17:06:31');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (20, 1, 1, '2022-12-24 17:42:16', '2022-04-25 15:43:31');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (10, 1, 1, '2022-01-30 18:51:39', '2022-04-15 18:04:39');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (7, 1, 0, '2022-12-16 10:41:01', '2022-09-02 09:07:33');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (35, 1, 1, '2022-12-17 05:22:17', '2023-01-20 21:00:23');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (15, 1, 1, '2022-10-28 14:22:49', '2022-09-19 03:44:26');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (14, 1, 1, '2022-02-16 14:59:37', '2022-05-21 21:26:21');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (12, 1, 1, '2022-06-14 08:34:22', '2023-01-12 20:49:50');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (33, 1, 0, '2022-04-10 10:44:15', '2022-06-01 10:12:06');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (10, 1, 0, '2022-01-03 02:02:57', '2022-08-05 02:16:25');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (25, 1, 1, '2022-10-02 13:24:58', '2022-08-04 16:27:42');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (10, 1, 1, '2022-10-27 08:54:49', '2022-03-14 21:40:49');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (31, 1, 1, '2021-12-09 10:13:06', '2022-11-26 19:18:34');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (11, 1, 0, '2022-10-09 22:32:52', '2023-01-18 21:55:25');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (38, 1, 0, '2022-11-09 00:27:20', '2022-05-15 03:44:51');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (5, 1, 0, '2022-07-14 02:05:40', '2022-10-03 14:39:12');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (36, 1, 1, '2022-03-03 16:41:04', '2022-12-13 16:33:44');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (38, 1, 0, '2022-07-15 02:13:38', '2022-10-21 19:05:27');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (10, 1, 1, '2022-02-14 03:06:51', '2022-06-27 03:08:27');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (31, 1, 1, '2022-09-12 17:42:27', '2022-03-18 03:26:40');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (9, 1, 0, '2022-01-13 20:32:12', '2022-02-20 16:02:18');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (29, 1, 1, '2022-06-10 12:25:10', '2022-07-20 20:56:21');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (36, 1, 1, '2022-01-16 19:35:45', '2023-01-17 01:44:14');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (6, 1, 1, '2022-05-24 04:22:33', '2022-10-15 12:51:12');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (25, 1, 0, '2022-02-03 22:32:04', '2022-05-19 15:48:32');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (3, 1, 0, '2022-01-31 14:52:06', '2022-02-02 07:51:54');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (13, 1, 0, '2022-08-03 03:25:03', '2022-11-04 20:13:52');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (20, 1, 0, '2022-03-20 00:30:58', '2022-02-13 05:01:26');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (33, 1, 0, '2022-08-10 07:01:22', '2022-02-27 21:18:47');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (30, 1, 0, '2021-12-29 13:50:34', '2022-05-25 11:16:17');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (21, 1, 1, '2022-09-27 00:51:03', '2022-02-17 05:40:13');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (5, 1, 1, '2022-10-01 14:04:29', '2022-10-21 08:03:34');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (9, 1, 0, '2022-05-31 04:51:45', '2022-02-11 05:04:09');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (34, 1, 1, '2021-12-31 21:14:31', '2022-06-19 06:30:21');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (30, 1, 0, '2021-12-08 04:21:59', '2022-07-01 13:54:21');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (28, 1, 0, '2022-10-08 14:20:08', '2022-03-20 20:38:21');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (3, 1, 1, '2022-05-16 12:04:40', '2022-12-13 05:03:18');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (28, 1, 1, '2022-02-15 22:15:07', '2022-11-04 18:03:50');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (16, 1, 0, '2022-10-08 23:34:32', '2022-07-12 00:35:14');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (30, 1, 1, '2022-01-26 09:45:34', '2022-02-23 20:44:22');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (3, 1, 0, '2022-10-11 08:32:54', '2022-10-23 10:35:18');
insert into On_Call (Nurse, BlockFloor, BlockCode, Start, End) values (34, 1, 0, '2022-04-09 16:27:10', '2022-05-09 09:03:43');


-- inserting 80 Stay
insert into Stay (StayID, Patient, Room, Start, End) values (1, 25, 135, '2021-12-07 08:34:58', '2023-10-04 02:53:08');
insert into Stay (StayID, Patient, Room, Start, End) values (2, 2, 140, '2022-07-27 16:40:55', '2023-02-06 20:50:13');
insert into Stay (StayID, Patient, Room, Start, End) values (3, 12, 133, '2022-04-11 07:59:27', '2023-02-16 20:25:07');
insert into Stay (StayID, Patient, Room, Start, End) values (4, 12, 149, '2022-05-29 11:22:46', '2023-07-29 21:47:29');
insert into Stay (StayID, Patient, Room, Start, End) values (5, 8, 131, '2022-01-06 14:08:04', '2023-06-10 12:19:52');
insert into Stay (StayID, Patient, Room, Start, End) values (6, 21, 100, '2022-09-18 01:25:46', '2023-07-30 14:15:53');
insert into Stay (StayID, Patient, Room, Start, End) values (7, 19, 134, '2022-06-22 05:21:55', '2023-02-19 08:17:43');
insert into Stay (StayID, Patient, Room, Start, End) values (8, 15, 126, '2022-02-23 09:35:09', '2023-05-26 02:51:29');
insert into Stay (StayID, Patient, Room, Start, End) values (9, 4, 125, '2022-09-01 07:46:39', '2023-03-26 07:41:41');
insert into Stay (StayID, Patient, Room, Start, End) values (10, 4, 111, '2022-12-26 00:08:24', '2023-07-20 21:52:20');
insert into Stay (StayID, Patient, Room, Start, End) values (11, 15, 100, '2022-12-06 10:46:59', '2023-01-03 06:46:58');
insert into Stay (StayID, Patient, Room, Start, End) values (12, 5, 106, '2022-06-27 18:46:57', '2023-06-28 00:06:44');
insert into Stay (StayID, Patient, Room, Start, End) values (13, 15, 143, '2021-12-09 08:01:31', '2023-04-22 17:21:40');
insert into Stay (StayID, Patient, Room, Start, End) values (14, 2, 133, '2022-06-06 07:24:04', '2023-03-22 10:41:47');
insert into Stay (StayID, Patient, Room, Start, End) values (15, 23, 122, '2022-09-30 17:07:24', '2023-02-16 11:14:03');
insert into Stay (StayID, Patient, Room, Start, End) values (16, 28, 147, '2022-07-17 21:56:44', '2023-01-24 05:55:36');
insert into Stay (StayID, Patient, Room, Start, End) values (17, 24, 113, '2022-07-01 11:36:02', '2023-02-22 02:30:17');
insert into Stay (StayID, Patient, Room, Start, End) values (18, 25, 114, '2022-07-05 05:08:25', '2023-04-26 03:01:21');
insert into Stay (StayID, Patient, Room, Start, End) values (19, 3, 139, '2022-09-09 16:25:46', '2023-01-11 21:15:54');
insert into Stay (StayID, Patient, Room, Start, End) values (20, 8, 127, '2022-07-23 07:57:40', '2023-03-20 11:25:56');
insert into Stay (StayID, Patient, Room, Start, End) values (21, 4, 132, '2022-11-28 09:47:46', '2023-01-14 07:31:43');
insert into Stay (StayID, Patient, Room, Start, End) values (22, 9, 147, '2022-05-06 08:16:27', '2023-01-08 03:40:23');
insert into Stay (StayID, Patient, Room, Start, End) values (23, 4, 143, '2022-06-25 18:30:15', '2023-09-07 17:39:05');
insert into Stay (StayID, Patient, Room, Start, End) values (24, 14, 149, '2022-07-23 13:02:34', '2023-07-01 23:59:29');
insert into Stay (StayID, Patient, Room, Start, End) values (25, 21, 139, '2021-12-31 20:52:35', '2023-01-30 09:15:16');
insert into Stay (StayID, Patient, Room, Start, End) values (26, 2, 146, '2022-04-11 08:11:37', '2023-01-14 21:01:56');
insert into Stay (StayID, Patient, Room, Start, End) values (27, 8, 129, '2022-07-18 03:13:37', '2023-07-25 10:49:40');
insert into Stay (StayID, Patient, Room, Start, End) values (28, 2, 128, '2022-08-11 00:55:40', '2023-09-24 18:57:19');
insert into Stay (StayID, Patient, Room, Start, End) values (29, 30, 108, '2022-03-20 14:57:08', '2023-04-11 23:14:03');
insert into Stay (StayID, Patient, Room, Start, End) values (30, 5, 116, '2022-04-28 15:22:10', '2023-06-05 17:53:01');
insert into Stay (StayID, Patient, Room, Start, End) values (31, 25, 144, '2022-09-22 08:22:25', '2023-07-14 12:04:48');
insert into Stay (StayID, Patient, Room, Start, End) values (32, 19, 128, '2022-12-13 04:28:25', '2023-09-03 02:47:49');
insert into Stay (StayID, Patient, Room, Start, End) values (33, 3, 134, '2022-11-28 16:35:25', '2023-01-12 23:09:51');
insert into Stay (StayID, Patient, Room, Start, End) values (34, 22, 143, '2022-10-08 12:33:17', '2023-03-25 03:41:12');
insert into Stay (StayID, Patient, Room, Start, End) values (35, 28, 105, '2022-08-20 03:15:23', '2023-01-28 11:48:15');
insert into Stay (StayID, Patient, Room, Start, End) values (36, 22, 138, '2022-02-12 12:58:29', '2023-08-27 13:29:48');
insert into Stay (StayID, Patient, Room, Start, End) values (37, 22, 115, '2022-05-02 09:35:44', '2023-04-16 16:21:20');
insert into Stay (StayID, Patient, Room, Start, End) values (38, 13, 108, '2022-11-20 09:00:50', '2023-02-08 17:12:57');
insert into Stay (StayID, Patient, Room, Start, End) values (39, 14, 142, '2022-10-26 05:43:05', '2023-08-15 09:17:18');
insert into Stay (StayID, Patient, Room, Start, End) values (40, 10, 121, '2022-11-28 14:36:50', '2023-08-04 08:49:38');
insert into Stay (StayID, Patient, Room, Start, End) values (41, 20, 142, '2022-12-27 21:28:17', '2023-06-16 21:52:00');
insert into Stay (StayID, Patient, Room, Start, End) values (42, 18, 113, '2022-07-29 07:08:38', '2023-03-01 15:57:06');
insert into Stay (StayID, Patient, Room, Start, End) values (43, 12, 102, '2022-09-12 18:04:31', '2023-03-31 04:10:34');
insert into Stay (StayID, Patient, Room, Start, End) values (44, 2, 146, '2022-12-24 20:57:31', '2023-04-26 07:02:38');
insert into Stay (StayID, Patient, Room, Start, End) values (45, 17, 136, '2022-04-18 12:56:58', '2023-04-30 01:58:10');
insert into Stay (StayID, Patient, Room, Start, End) values (46, 3, 136, '2022-11-29 13:30:22', '2023-02-25 11:34:52');
insert into Stay (StayID, Patient, Room, Start, End) values (47, 18, 114, '2022-07-18 23:26:33', '2023-10-02 06:06:08');
insert into Stay (StayID, Patient, Room, Start, End) values (48, 3, 119, '2022-01-25 13:31:00', '2023-08-09 10:28:47');
insert into Stay (StayID, Patient, Room, Start, End) values (49, 28, 116, '2022-04-08 06:16:04', '2023-10-25 04:51:00');
insert into Stay (StayID, Patient, Room, Start, End) values (50, 29, 144, '2022-07-13 11:40:37', '2023-08-08 11:43:50');
insert into Stay (StayID, Patient, Room, Start, End) values (51, 8, 134, '2022-12-24 11:46:26', '2023-08-13 14:35:51');
insert into Stay (StayID, Patient, Room, Start, End) values (52, 18, 141, '2022-08-29 23:32:02', '2023-08-24 18:13:30');
insert into Stay (StayID, Patient, Room, Start, End) values (53, 14, 138, '2022-09-18 23:34:06', '2023-03-01 21:37:52');
insert into Stay (StayID, Patient, Room, Start, End) values (54, 27, 112, '2021-12-13 15:22:09', '2023-01-13 07:29:23');
insert into Stay (StayID, Patient, Room, Start, End) values (55, 4, 126, '2022-09-19 01:28:43', '2023-05-11 04:49:40');
insert into Stay (StayID, Patient, Room, Start, End) values (56, 26, 126, '2022-06-07 14:12:42', '2023-03-25 00:04:14');
insert into Stay (StayID, Patient, Room, Start, End) values (57, 3, 106, '2022-01-11 18:46:13', '2023-02-22 21:44:22');
insert into Stay (StayID, Patient, Room, Start, End) values (58, 1, 125, '2022-07-04 07:33:23', '2023-10-06 03:55:22');
insert into Stay (StayID, Patient, Room, Start, End) values (59, 14, 103, '2022-09-05 06:19:55', '2023-06-07 09:40:47');
insert into Stay (StayID, Patient, Room, Start, End) values (60, 28, 142, '2022-05-08 11:40:09', '2023-06-16 11:06:05');
insert into Stay (StayID, Patient, Room, Start, End) values (61, 15, 101, '2022-03-16 03:36:38', '2023-09-03 15:59:20');
insert into Stay (StayID, Patient, Room, Start, End) values (62, 3, 121, '2022-11-07 01:17:53', '2023-04-29 02:01:06');
insert into Stay (StayID, Patient, Room, Start, End) values (63, 26, 136, '2022-06-29 14:45:45', '2023-02-11 06:58:41');
insert into Stay (StayID, Patient, Room, Start, End) values (64, 12, 112, '2021-12-01 14:46:29', '2023-07-29 01:43:30');
insert into Stay (StayID, Patient, Room, Start, End) values (65, 18, 132, '2022-11-11 18:55:23', '2023-01-03 10:10:11');
insert into Stay (StayID, Patient, Room, Start, End) values (66, 24, 128, '2022-12-10 09:46:41', '2023-08-27 22:29:25');
insert into Stay (StayID, Patient, Room, Start, End) values (67, 24, 130, '2022-06-14 01:13:10', '2023-01-14 05:08:32');
insert into Stay (StayID, Patient, Room, Start, End) values (68, 2, 119, '2022-11-08 14:09:44', '2023-03-05 17:55:43');
insert into Stay (StayID, Patient, Room, Start, End) values (69, 19, 101, '2022-06-29 18:53:30', '2023-01-18 00:55:45');
insert into Stay (StayID, Patient, Room, Start, End) values (70, 13, 134, '2022-02-09 07:02:15', '2023-10-05 04:08:33');
insert into Stay (StayID, Patient, Room, Start, End) values (71, 5, 119, '2022-08-01 19:49:49', '2023-06-21 03:47:19');
insert into Stay (StayID, Patient, Room, Start, End) values (72, 2, 133, '2022-04-10 18:48:45', '2023-10-22 20:01:09');
insert into Stay (StayID, Patient, Room, Start, End) values (73, 22, 131, '2022-02-09 04:37:53', '2023-05-10 20:07:21');
insert into Stay (StayID, Patient, Room, Start, End) values (74, 10, 102, '2022-10-29 22:58:45', '2023-06-12 19:11:13');
insert into Stay (StayID, Patient, Room, Start, End) values (75, 3, 130, '2022-11-20 00:56:17', '2023-03-07 03:57:23');
insert into Stay (StayID, Patient, Room, Start, End) values (76, 10, 149, '2022-07-03 20:21:52', '2023-01-03 02:38:17');
insert into Stay (StayID, Patient, Room, Start, End) values (77, 22, 102, '2022-03-03 10:48:05', '2023-01-15 03:18:59');
insert into Stay (StayID, Patient, Room, Start, End) values (78, 29, 144, '2022-09-26 14:29:51', '2023-07-31 11:32:36');
insert into Stay (StayID, Patient, Room, Start, End) values (79, 4, 118, '2022-09-11 19:33:20', '2023-04-04 21:18:35');
insert into Stay (StayID, Patient, Room, Start, End) values (80, 30, 116, '2022-07-13 09:28:31', '2023-04-05 03:50:31');

-- inserting 60 undergoes
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (6, 2, 18, '2022-04-21 03:52:16', 24, 15);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (17, 3, 18, '2022-01-05 14:50:42', 29, 29);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (16, 3, 60, '2022-08-03 16:46:43', 36, 4);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (26, 4, 31, '2022-01-14 02:54:37', 17, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (24, 1, 59, '2022-02-05 03:24:16', 37, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (4, 4, 4, '2022-09-08 17:00:41', 23, 39);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (3, 1, 33, '2022-05-31 21:23:57', 29, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (21, 1, 12, '2022-01-03 11:30:58', 24, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (15, 3, 49, '2022-03-28 22:00:07', 14, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (6, 2, 45, '2022-06-29 11:18:17', 37, 40);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (30, 4, 61, '2022-10-04 10:37:49', 1, 20);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (10, 5, 3, '2022-11-03 01:02:33', 35, 3);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (17, 2, 67, '2022-12-18 00:24:11', 11, 5);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (17, 1, 71, '2022-09-24 05:38:14', 25, 37);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (12, 2, 40, '2022-11-15 09:04:12', 25, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (12, 3, 31, '2022-11-24 08:33:53', 3, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (5, 3, 25, '2022-05-06 04:41:35', 29, 12);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (12, 3, 6, '2022-07-04 15:38:21', 33, 6);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (24, 1, 53, '2022-03-01 08:32:20', 14, 14);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (11, 1, 6, '2022-09-05 09:49:08', 19, 27);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (7, 1, 75, '2022-10-13 15:18:45', 32, 9);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (11, 5, 68, '2022-02-28 03:40:16', 7, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (17, 2, 6, '2022-04-04 00:59:22', 30, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (17, 4, 57, '2022-08-04 13:45:30', 7, 28);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (11, 4, 74, '2022-03-10 19:16:57', 17, 40);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (25, 4, 47, '2023-01-23 16:13:01', 13, 2);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (3, 2, 19, '2022-08-21 12:07:58', 9, 20);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (21, 1, 4, '2022-01-12 15:20:13', 37, 22);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (26, 5, 58, '2022-09-04 16:32:55', 12, 6);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (3, 5, 58, '2023-01-15 04:33:20', 39, 37);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (14, 4, 59, '2022-10-03 16:31:25', 24, 22);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (8, 4, 78, '2023-01-21 01:23:26', 19, 15);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (20, 3, 73, '2022-08-14 14:12:00', 15, 33);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (13, 1, 7, '2022-08-17 00:05:44', 14, 23);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (30, 5, 53, '2022-01-27 19:19:14', 30, 38);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (28, 4, 21, '2022-03-24 02:24:46', 36, 15);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (8, 2, 80, '2022-07-24 18:57:04', 27, 23);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (2, 5, 45, '2022-03-07 06:21:04', 4, 22);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (26, 5, 71, '2022-09-27 00:48:48', 11, 13);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (8, 4, 39, '2022-08-05 08:58:55', 34, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (27, 3, 54, '2022-08-07 05:54:59', 12, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (9, 1, 9, '2022-05-18 14:42:27', 24, 40);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (28, 2, 33, '2022-07-24 23:07:32', 17, 15);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (6, 5, 71, '2022-08-04 05:38:58', 8, 13);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (20, 3, 45, '2022-10-25 03:50:33', 28, 21);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (20, 5, 28, '2022-11-26 02:21:49', 8, 34);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (7, 5, 49, '2022-04-03 18:56:20', 9, 19);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (14, 5, 21, '2022-01-09 01:23:58', 21, 1);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (11, 2, 63, '2022-11-22 05:19:08', 8, 36);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (19, 1, 52, '2022-10-26 18:30:46', 16, 8);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (8, 2, 12, '2022-04-21 14:49:51', 9, 13);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (4, 3, 76, '2022-01-09 12:17:37', 10, 11);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (12, 5, 62, '2022-07-16 02:49:24', 10, 20);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (24, 2, 22, '2022-02-16 12:27:02', 17, 36);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (18, 4, 62, '2022-05-11 02:26:31', 20, 22);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (27, 2, 69, '2022-02-15 04:46:15', 40, 23);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (1, 5, 9, '2022-04-11 17:21:03', 23, 17);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (15, 4, 35, '2022-08-27 20:16:51', 14, null);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (12, 2, 63, '2022-03-18 04:51:45', 31, 29);
insert into Undergoes (Patient, `Procedure`, Stay, Date, Physician, AssistingNurse) values (23, 1, 47, '2022-12-23 02:28:41', 40, null);


-- insert 2 medication
insert into Medication (Code, Name, Brand, Description) values (1, 'remdesivir', 'Veklury', 'Remdesivir is an antiviral medication used to treat COVID-19. It works by inhibiting the replication of the virus in the body.');
insert into Medication (Code, Name, Brand, Description) values (2, 'paracetamol', 'Tylenol', 'Paracetamol is a commonly used over-the-counter pain reliever and fever reducer. It works by blocking the production of certain chemical messengers that cause pain and inflammation in the body.');

-- inserting 100 appointment
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (1, 1, 36, 33, '2022-02-14 02:52:08', '2022-08-03 04:29:20', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (2, 20, 20, 8, '2022-11-30 11:06:15', '2022-10-29 01:24:25', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (3, 21, 7, 17, '2022-12-14 21:51:49', '2022-03-23 08:16:07', 'Ophthalmology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (4, 25, 16, 33, '2022-01-01 14:20:50', '2022-05-09 03:49:50', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (5, 11, 24, 37, '2022-10-12 15:02:30', '2022-08-27 20:09:13', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (6, 14, 25, 23, '2022-09-13 21:13:52', '2022-04-18 20:57:38', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (7, 18, 18, 13, '2022-12-05 20:33:37', '2022-10-27 02:16:05', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (8, 1, 12, 20, '2022-06-05 10:02:22', '2022-11-28 23:35:46', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (9, 25, null, 11, '2022-05-25 01:50:14', '2022-09-08 05:16:49', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (10, 3, 16, 21, '2022-06-19 14:07:23', '2022-02-12 15:59:14', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (11, 8, null, 3, '2022-07-28 17:57:11', '2022-01-20 15:59:40', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (12, 15, 15, 33, '2021-12-18 03:41:26', '2022-09-12 22:01:42', 'Cardiology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (13, 6, 28, 5, '2022-03-18 13:10:32', '2022-10-15 20:24:49', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (14, 2, 28, 27, '2022-09-12 23:16:33', '2022-03-15 15:00:01', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (15, 20, null, 26, '2021-12-28 09:41:40', '2022-01-17 06:34:35', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (16, 11, null, 1, '2022-10-25 21:08:20', '2022-03-26 03:00:17', 'Ophthalmology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (17, 9, null, 6, '2022-11-26 11:12:16', '2022-06-19 06:58:31', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (18, 15, 2, 18, '2022-08-17 10:06:27', '2022-10-13 01:23:00', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (19, 8, null, 22, '2022-01-22 15:27:49', '2022-05-05 17:00:41', 'Cardiology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (20, 1, null, 22, '2022-01-22 08:34:08', '2022-08-16 15:26:12', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (21, 19, 23, 28, '2022-11-01 07:27:55', '2022-11-17 08:59:57', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (22, 8, null, 10, '2022-08-23 09:35:28', '2022-04-18 00:49:37', 'Cardiology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (23, 29, 10, 36, '2022-06-30 14:04:13', '2022-07-30 20:19:06', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (24, 7, 12, 22, '2022-07-25 08:13:46', '2022-02-13 14:25:30', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (25, 4, null, 33, '2022-10-18 10:36:52', '2022-04-01 09:17:18', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (26, 11, 15, 21, '2022-07-14 07:00:58', '2022-11-22 03:55:07', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (27, 26, 10, 15, '2022-10-07 17:53:52', '2022-02-24 18:01:36', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (28, 14, 26, 21, '2022-11-19 05:49:11', '2023-01-23 07:44:19', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (29, 6, 10, 28, '2022-07-12 22:24:32', '2022-03-17 09:36:02', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (30, 17, 36, 29, '2022-06-15 01:42:04', '2022-11-08 16:55:57', 'General examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (31, 18, 23, 18, '2022-05-11 18:26:18', '2022-03-22 02:49:48', 'General examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (32, 25, 26, 7, '2022-10-29 12:42:14', '2023-01-12 15:29:01', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (33, 19, null, 29, '2022-02-25 11:44:25', '2023-01-05 21:29:44', 'General examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (34, 3, 13, 18, '2022-08-19 07:25:51', '2022-12-30 17:28:23', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (35, 24, 23, 3, '2022-09-23 01:51:03', '2022-11-09 04:50:09', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (36, 6, null, 10, '2021-12-23 10:08:48', '2022-03-09 20:06:29', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (37, 23, 22, 30, '2022-11-19 06:12:27', '2022-05-17 11:18:01', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (38, 19, null, 14, '2022-09-29 08:47:30', '2022-10-26 05:09:17', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (39, 26, 9, 29, '2022-09-23 23:38:10', '2022-09-19 06:36:15', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (40, 17, 9, 19, '2022-08-09 18:27:08', '2022-12-18 00:14:31', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (41, 9, null, 22, '2022-05-03 22:57:46', '2022-09-23 13:16:03', 'Pediatrics examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (42, 19, 31, 22, '2022-05-21 15:39:58', '2022-04-29 12:27:37', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (43, 25, 39, 6, '2022-01-25 13:37:39', '2022-04-22 07:58:14', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (44, 25, 24, 34, '2022-01-27 10:58:22', '2022-01-09 06:46:47', 'Ophthalmology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (45, 2, null, 28, '2022-09-07 03:46:35', '2022-02-28 03:41:21', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (46, 26, 21, 9, '2022-05-14 14:09:54', '2022-10-30 23:51:13', 'General examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (47, 17, 30, 4, '2022-04-22 23:09:17', '2022-10-27 17:26:18', 'Pediatrics examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (48, 9, 10, 1, '2022-01-31 14:03:32', '2022-11-15 08:19:09', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (49, 22, 13, 18, '2022-03-01 18:04:20', '2022-02-07 22:08:43', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (50, 13, 2, 17, '2022-10-07 04:14:31', '2022-01-22 11:27:33', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (51, 4, 38, 4, '2022-11-20 13:22:07', '2022-03-20 02:13:05', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (52, 25, 29, 10, '2022-08-04 12:01:32', '2022-04-18 18:50:28', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (53, 2, null, 26, '2022-02-21 15:59:52', '2022-08-19 08:47:42', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (54, 25, 3, 4, '2022-02-27 17:18:16', '2022-01-08 17:09:33', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (55, 16, 7, 6, '2021-12-29 02:43:35', '2022-01-31 18:11:57', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (56, 17, 38, 19, '2022-03-09 02:15:06', '2022-07-10 22:38:33', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (57, 6, null, 30, '2022-03-29 19:35:41', '2022-02-20 08:23:17', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (58, 15, 23, 18, '2022-10-08 11:33:31', '2022-03-09 21:17:16', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (59, 2, 28, 39, '2022-02-14 23:16:17', '2022-09-01 02:53:01', 'Ophthalmology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (60, 9, 27, 31, '2022-08-05 06:23:08', '2022-02-16 05:34:37', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (61, 26, 22, 9, '2022-05-21 01:36:50', '2022-07-17 05:45:11', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (62, 16, 13, 31, '2021-12-16 05:06:29', '2022-03-21 02:26:56', 'General examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (63, 22, 31, 11, '2022-04-21 13:57:01', '2022-07-30 13:17:27', 'General examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (64, 5, null, 25, '2022-02-25 03:39:55', '2022-10-19 18:32:23', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (65, 26, null, 12, '2022-06-01 17:10:08', '2022-09-29 18:17:31', 'Ophthalmology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (66, 8, 40, 19, '2022-03-05 23:14:03', '2022-11-25 07:48:26', 'Cardiology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (67, 28, 26, 25, '2022-08-02 18:33:46', '2022-11-21 15:59:57', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (68, 12, 21, 11, '2022-02-08 23:13:26', '2022-07-01 11:57:26', 'General examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (69, 5, 7, 39, '2022-04-16 14:35:46', '2022-09-12 15:22:31', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (70, 19, null, 37, '2021-12-16 06:41:17', '2022-07-28 12:15:05', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (71, 27, 23, 30, '2022-12-19 07:15:24', '2022-02-16 06:43:02', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (72, 24, null, 6, '2022-05-11 11:44:00', '2022-07-03 04:44:55', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (73, 16, 35, 12, '2022-05-04 06:21:26', '2022-11-30 19:11:13', 'Ophthalmology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (74, 29, 18, 16, '2022-12-08 09:08:43', '2022-09-11 11:51:56', 'Pediatrics examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (75, 5, 8, 1, '2022-10-06 21:35:49', '2022-06-24 19:20:30', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (76, 20, 25, 31, '2022-08-19 10:35:39', '2022-01-25 04:02:29', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (77, 14, 25, 3, '2022-02-03 11:49:18', '2022-01-27 22:19:25', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (78, 12, 11, 39, '2022-11-16 15:18:14', '2022-01-21 16:29:29', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (79, 27, null, 28, '2022-01-19 12:01:19', '2022-03-21 15:45:47', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (80, 3, 36, 22, '2022-06-24 20:35:20', '2023-01-19 20:39:46', 'Ophthalmology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (81, 3, 10, 7, '2022-01-22 00:17:56', '2022-11-17 19:03:33', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (82, 16, 34, 25, '2022-07-27 03:56:48', '2022-10-29 08:54:34', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (83, 7, 27, 8, '2022-11-23 00:45:38', '2022-12-31 02:49:38', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (84, 30, 27, 27, '2022-12-03 09:13:21', '2022-10-11 21:25:28', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (85, 7, 28, 36, '2022-02-07 02:23:34', '2022-01-27 22:08:30', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (86, 26, 40, 9, '2022-12-02 21:24:40', '2022-11-03 18:35:38', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (87, 29, 6, 4, '2022-04-28 21:00:17', '2022-11-25 00:41:03', 'Neurology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (88, 27, null, 40, '2022-10-08 09:08:29', '2022-05-29 20:09:33', 'Cardiology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (89, 11, 12, 30, '2022-03-11 04:32:28', '2022-12-07 08:09:11', 'Gynecological examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (90, 16, 14, 32, '2022-05-11 20:00:43', '2022-10-05 10:34:36', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (91, 5, 39, 36, '2022-01-10 15:29:59', '2022-02-16 13:11:23', 'General examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (92, 22, null, 2, '2022-11-03 23:53:14', '2022-12-14 06:37:25', 'Orthopedic examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (93, 18, 1, 36, '2022-07-27 09:02:47', '2022-05-22 06:12:02', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (94, 15, 33, 26, '2022-04-05 00:50:17', '2022-05-06 08:07:13', 'Oncology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (95, 24, 19, 36, '2022-10-15 17:08:31', '2022-08-14 10:05:04', 'Cardiology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (96, 27, null, 38, '2022-03-03 09:59:15', '2023-01-24 12:48:38', 'Dermatology examination room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (97, 2, 5, 5, '2022-05-11 13:24:46', '2022-02-04 15:00:03', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (98, 29, 16, 4, '2022-09-17 02:37:38', '2022-08-31 01:13:20', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (99, 13, null, 19, '2022-08-31 07:07:04', '2022-10-08 06:04:22', 'Minor procedure room');
insert into Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, End, ExaminationRoom) values (100, 8, 31, 7, '2022-05-05 00:18:45', '2023-01-05 07:40:38', 'Gynecological examination room');


-- inserting 100 Prescribes
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (20, 26, 1, '2022-06-24 03:08:33', 55, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (8, 3, 2, '2022-11-15 21:43:54', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (26, 11, 2, '2022-08-25 02:17:54', 60, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (10, 14, 1, '2022-09-25 04:17:47', 32, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (4, 11, 2, '2022-09-28 13:18:20', 27, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (10, 6, 2, '2022-07-20 19:22:04', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (20, 25, 2, '2022-06-06 23:19:57', 99, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (25, 18, 2, '2022-02-05 10:34:31', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (29, 7, 1, '2022-07-12 17:59:05', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (12, 9, 1, '2022-02-08 14:58:25', 10, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (19, 8, 2, '2023-01-19 22:26:43', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (4, 14, 2, '2023-01-29 07:59:35', 16, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (32, 23, 1, '2022-10-09 01:20:13', 23, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (13, 24, 1, '2022-12-22 20:05:04', 77, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (14, 23, 2, '2022-05-07 09:45:59', 12, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (21, 5, 2, '2022-06-03 17:05:19', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (1, 17, 2, '2022-12-24 18:45:55', 27, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (40, 27, 2, '2022-11-09 18:00:18', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (16, 10, 1, '2022-03-11 20:33:30', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (2, 3, 1, '2022-05-02 09:04:28', 66, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (3, 23, 1, '2023-01-03 00:21:22', 12, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (25, 22, 2, '2022-03-29 03:44:38', 87, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (38, 7, 2, '2022-01-26 06:41:43', 16, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (7, 29, 2, '2022-03-18 15:44:07', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (32, 7, 1, '2022-11-08 19:58:07', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (32, 27, 1, '2022-10-16 14:18:47', 36, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (33, 13, 2, '2022-05-12 15:00:01', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (13, 21, 2, '2022-02-07 04:15:41', 94, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (19, 3, 1, '2022-03-05 07:54:56', 30, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (30, 25, 2, '2022-10-08 22:20:35', 18, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (14, 6, 2, '2022-02-07 07:09:19', 22, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (23, 25, 2, '2022-09-20 11:13:18', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (26, 2, 2, '2022-06-16 23:07:26', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (18, 11, 2, '2022-03-23 13:06:51', 28, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (7, 8, 2, '2022-04-22 00:11:22', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (6, 2, 2, '2022-05-18 02:55:08', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (12, 25, 2, '2022-11-30 13:22:56', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (39, 14, 1, '2022-02-04 01:06:16', 94, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (39, 28, 1, '2022-09-24 08:28:47', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (39, 19, 2, '2022-07-14 07:17:27', 7, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (1, 2, 2, '2023-01-07 14:52:14', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (32, 7, 2, '2022-11-22 12:24:29', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (17, 1, 1, '2022-12-03 03:57:05', 35, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (40, 11, 1, '2022-10-22 16:32:41', 1, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (14, 2, 2, '2022-05-03 05:57:51', 4, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (33, 25, 2, '2022-11-09 14:57:03', 78, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (26, 26, 2, '2022-09-21 19:14:01', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (4, 25, 2, '2022-08-24 16:27:31', 57, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (39, 19, 2, '2022-08-28 01:31:03', 34, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (7, 25, 2, '2022-02-14 15:12:06', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (25, 27, 2, '2022-11-27 12:43:44', 46, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (31, 13, 2, '2022-04-17 01:13:18', 31, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (9, 30, 1, '2022-10-30 12:13:22', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (1, 17, 1, '2022-09-30 05:50:10', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (39, 14, 1, '2023-01-11 19:48:29', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (35, 9, 2, '2022-08-02 14:27:20', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (10, 21, 1, '2022-04-14 09:02:13', 31, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (8, 22, 1, '2022-12-16 10:00:10', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (30, 2, 1, '2022-07-04 22:12:43', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (36, 2, 1, '2022-12-27 20:04:58', 10, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (34, 4, 2, '2022-07-25 14:45:51', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (38, 9, 1, '2022-01-02 02:49:17', 30, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (36, 19, 2, '2022-04-15 00:00:14', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (4, 29, 2, '2022-01-24 23:31:59', 52, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (34, 7, 1, '2022-03-22 06:24:31', 6, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (15, 30, 2, '2022-10-10 21:15:54', 46, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (30, 16, 2, '2022-12-26 00:04:08', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (26, 7, 1, '2022-04-01 17:33:13', 26, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (32, 3, 2, '2022-09-30 14:03:56', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (8, 29, 2, '2022-06-23 22:27:20', 54, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (12, 16, 2, '2022-08-03 07:48:12', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (13, 27, 2, '2022-07-14 05:20:26', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (40, 6, 1, '2022-08-20 12:25:02', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (35, 4, 1, '2022-10-02 05:55:24', 14, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (12, 15, 2, '2022-07-26 10:30:15', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (1, 30, 1, '2022-01-25 03:55:11', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (23, 3, 2, '2022-09-19 20:10:03', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (29, 9, 1, '2022-09-09 16:22:31', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (2, 29, 1, '2022-12-16 17:29:16', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (2, 11, 1, '2022-07-29 19:59:22', 46, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (3, 4, 2, '2023-01-28 03:36:09', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (10, 16, 2, '2022-11-30 07:52:28', 47, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (22, 25, 1, '2022-08-16 04:54:59', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (15, 22, 1, '2022-01-21 12:38:46', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (17, 25, 1, '2022-06-22 22:48:37', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (40, 17, 2, '2022-02-02 16:23:30', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (16, 9, 1, '2022-10-31 09:12:51', 95, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (8, 17, 1, '2023-01-29 23:46:04', 70, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (9, 1, 1, '2022-06-16 19:49:59', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (11, 29, 2, '2022-03-08 06:50:30', null, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (19, 22, 2, '2022-10-08 10:48:49', 53, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (9, 23, 2, '2023-01-17 01:03:17', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (34, 24, 1, '2022-05-15 01:50:15', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (28, 11, 1, '2022-05-05 07:58:48', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (35, 15, 2, '2023-01-10 21:43:06', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (31, 2, 1, '2022-05-03 15:25:42', null, 'Gram (g)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (27, 27, 1, '2023-01-28 08:27:11', 86, 'Microgram (mcg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (7, 14, 2, '2022-05-23 21:04:03', null, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (15, 8, 2, '2022-11-11 04:23:46', 40, 'Milligram (mg)');
insert into Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) values (32, 5, 2, '2022-08-14 08:47:00', 26, 'Gram (g)');


-- QUERIES
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
