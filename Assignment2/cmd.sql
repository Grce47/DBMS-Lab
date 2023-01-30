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

CREATE TABLE Trained_in(
    Physician INT NOT NULL,
    Treatment INT NOT NULL,
    CertificationDate DATETIME NOT NULL,
    CertificationExpires DATETIME NOT NULL,
    PRIMARY KEY ( Physician, Treatment),
    FOREIGN KEY (Physician) REFERENCES Physician(EmployeeID),
    FOREIGN KEY (Treatment) REFERENCES `Procedure`(Code)
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

