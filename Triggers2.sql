-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ TRIGGER OPERATIONS IN SQL @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ EXECUTED IN  MYSQL @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-- 1 TRIGGER TO VERIFY THE AGE BEFORE INSERTION IN EMPLOYEES TABLE
CREATE TABLE Employees(
	EmpID INT,
    EmpName CHAR(25),
    EmpRole CHAR(25),
    EmpSalary INT,
    EmpAge INT
);

-- TRIGGER
DELIMITER //
CREATE TRIGGER AgeVerify
BEFORE INSERT ON Employees
FOR EACH ROW
if new.EmpAge < 0 then set new.EmpAge = 0;
END if;
//

-- @@@@@@@@@@@@@@@ TRIGGERS DRY RUN @@@@@@@@@@@@@@@@@@@
-- FIRST WE ARE INSERTING THE DATA 
-- BEFORE INSERTION TRIGGER WILL FIRE, THOSE AGES < 0, THIER AGES WILL BECOME 0
INSERT INTO Employees values (1,'A','Engineer',52000,25),(2,'B','Salesman',45000,-4),(3,'C','Manager',25000,20),
(4,'D','Salesman',20000,-2),(5,'E','Engineer',10000,25);

-- WE CAN EVEN CHECK HERE AS WELL
select * from Employees;

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- 2 AFTER INSERTION TRIGGER
CREATE TABLE Customers(
	CusId int auto_increment primary key,
    CusName VARCHAR(50) NOT NULL,
    CusEmail VARCHAR(100),
    CusDob DATE
);
SELECT * FROM Customers

CREATE TABLE Message(
	Id INT AUTO_INCREMENT,
    MessageId INT,
    MessageText VARCHAR(250) NOT NULL,
    PRIMARY KEY(Id, MessageId)
);

-- THE TRIGGER WILL WORK AFTER WE INSERT BIRTHDATE AND IT WILL CHECK WHETHER BIRTHDATE IS NULL OR NOT 
DELIMITER //
CREATE TRIGGER Check_Dob_Null
AFTER INSERT ON Customers
FOR EACH ROW
BEGIN
IF new.CusDob IS NULL THEN
INSERT INTO Message(MessageId, MessageText)
VALUES (new.CusId, concat('Hi', new.CusName, 'Please update your DOB'));
END IF;
END //
DELIMITER ;

DROP TRIGGER Check_Dob_Null;

-- PASSING SOME VALUES
INSERT INTO Customers (CusName, CusEmail, CusDob)
VALUES ('A', 'a@mail.com', NULL),
		('B', 'b@mail.com', '03-05-30'),
        ('C', 'c@mail.com', NULL),
        ('D', 'c@mail.com', '02-05-30');

-- AFTER INSERT WILL TRIGGER AND IT WILL CHECK NULL VALUES AND PUT ID, MSG IN MSG TABLE 
 SELECT * FROM Message;
 
 
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- 3 BEFORE UPDATE TRIGGER
CREATE TABLE Team(
	EmpID INT,
    EmpName CHAR(25),
    EmpSalary INT
);

INSERT INTO Team
VALUES (101, 'A', 50000),
		(102, 'B', 25000),
        (103, 'C', 30000),
        (104, 'D', 14000),
        (105, 'E', 9000),
        (106, 'F', 60000);
        
-- THE TRIGGER
DELIMITER //
CREATE TRIGGER SalCheck
BEFORE UPDATE ON Team
FOR EACH ROW
BEGIN
IF new.EmpSalary = 9000 THEN
SET new.EmpSalary = 25000;
ELSEIF new.EmpSalary > 25000 THEN
SET new.EmpSalary = 20000;
END IF;
END //
DELIMITER ;

UPDATE Team
SET EmpSalary = 50000;

SELECT * FROM Team;


-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- 4 AFTER UPDATE TRIGGER
-- JAB SALARY UPDATE HOGI TAB EMPLOYEE KO MESSAGE JAAYEGA
CREATE TABLE Team(
	EmpID INT,
    EmpName CHAR(25),
    EmpSalary INT
);

INSERT INTO Team
VALUES (101, 'A', 50000),
		(102, 'B', 25000),
        (103, 'C', 30000),
        (104, 'D', 14000),
        (105, 'E', 9000),
        (106, 'F', 60000);

-- YEH TABLE HELP KARGEA BATANE MEI KI AFTER UDPATE KISKI SALARY UPDATE HUI HAI 
CREATE TABLE SalaryUpdater(
	UpdateId INT auto_increment PRIMARY KEY,
    UpdateMessage VARCHAR(250)
);
        
-- THE TRIGGER
DELIMITER //
CREATE TRIGGER AfterUpdateSal
AFTER UPDATE ON Team
FOR EACH ROW
BEGIN
	IF new.EmpSalary != old.EmpSalary THEN
    INSERT INTO SalaryUpdater (UpdateId, UpdateMessage)
    VALUES (new.EmpID, concat('Hurray!!', new.EmpName, 'Congtas sal updated'));
    END IF;
END
//
DELIMITER ;

SELECT * FROM Team;

-- YEH BANDE KI SAL UPDATE HUI TOH SALARY UPDATER MEI ISKA INFO JAAYEGA
UPDATE Team
SET EmpSalary = 19000 WHERE EmpID = 105;

SELECT * FROM Team;

-- ONLY EMPID = E WILL GET MESSAGE 
SELECT * from SalaryUpdater;


-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- AFTER DELETE TRIGGER MAIN TABLE SE -> BACKUP TABLE MEI JAAYEGA AFTER DELETE
CREATE TABLE Main(
	EmpID INT,
    EmpName CHAR(25),
    EmpRole CHAR(25),
    EmpSalary INT
);

INSERT INTO Main values (1,'A','Engineer',52000),(2,'B','Salesman',45000),(3,'C','Manager',25000),
(4,'D','Salesman',20000),(5,'E','Engineer',10000);

CREATE TABLE Backup(
	EmpID INT,
    EmpName CHAR(25),
    EmpRole CHAR(25),
	EmpSalary INT
);

-- TRIGGER TO SAVE THE DATA IN BACKUP WHEN DATA GETS DELETD FROM THE MAIN TABLE
DELIMITER //
CREATE TRIGGER SaveData
AFTER DELETE ON Main
FOR EACH ROW
BEGIN
INSERT INTO Backup VALUES (old.EmpID, old.EmpName, old.EmpRole, old.EmpSalary);
END
//
DELIMITER ;


-- @@@@@@@@@@@@@@@ TRIGGERS DRY RUN @@@@@@@@@@@@@@@@@@@
-- ALL table details will be shown but we will delete 1st empid
select * from main;
delete from main where EmpID = 2;

-- Empid 1 will get deleted from main
select * from main;

-- But empid 1 will get stored in the backup table
select * from Backup;

-- INSERTING SOME MORE ROWS
INSERT INTO Main values (6,'F','Manager',25000);

-- NOW WE CAN SEE EMPIDS FROM 2 to 4 as 1 is already deleted
select * from main;

-- And in Backup table we have empid 1 saved
select * from Backup;

-- UNION TO GET ALL THE VALUES
select * from Backup
UNION
select * from main;


-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- BEFORE DELETE TRIGGER DELETE HONE SE PEHLE KUCH CONDITIONS CHECK HONGE
 CREATE TABLE Main(
	EmpID INT,
    EmpName CHAR(25),
    EmpRole CHAR(25),
    EmpSalary INT
);

INSERT INTO Main values (1,'A','Engineer',52000),(2,'B','Salesman',45000),(3,'C','Manager',25000),
(4,'D','Salesman',20000),(5,'E','Engineer',9000);

CREATE TABLE Backup(
	EmpID INT,
    EmpName CHAR(25),
    EmpRole CHAR(25),
	EmpSalary INT
);

-- TRIGGER TO SAVE THE DATA IN BACKUP WHEN DATA GETS DELETD FROM THE MAIN TABLE
DELIMITER //
CREATE TRIGGER BeforeSaveData
BEFORE DELETE ON Main
FOR EACH ROW
BEGIN
IF old.EmpSalary < 10000 THEN
INSERT INTO Backup VALUES (old.EmpID, old.EmpName, old.EmpRole, old.EmpSalary);
END IF;
END //
DELIMITER ;


-- @@@@@@@@@@@@@@@ TRIGGERS DRY RUN @@@@@@@@@@@@@@@@@@@
-- ALL table details will be shown but we will delete Employee jiski salary kam hai
-- Hum uski salary Backup mei daal denge kyu KI main table mei sirf empsal > 10000
-- baaki sab backup mei jaayenge
-- SO BEFORE DELETE IT WILL CHECK AND FIRE TRIGGER
select * from main;
delete from main where EmpSalary < 10000;

-- AB HUME SAARE PREMIUM EMPLOYEES DIKHENGE JINKI SAL > 10000 HAI
select * from main;

-- AND JINKI SAL < 10000 HAI WOH SAB IN THE BACKUP TABLE
select * from Backup;

-- UNION TO GET SAARE EMPLOYEES
select * from Backup
UNION
select * from main;