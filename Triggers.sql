-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ TRIGGER OPERATIONS IN SQL @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ EXECUTED IN ORACLE SQL @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

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
create or replace trigger t1
before delete on main
for each row
begin
	insert into Backup values(:old.EmpID, :old.EmpName, :old.EmpRole, :old.EmpSalary);
end;


-- @@@@@@@@@@@@@@@ TRIGGERS DRY RUN @@@@@@@@@@@@@@@@@@@
-- ALL table details will be shown but we will delete 1st empid
select * from main;
delete from main where EmpID = 1;

-- Empid 1 will get deleted from main
select * from main;

-- But empid 1 will get stored in the backup table
select * from Backup;

-- INSERTING SOME MORE ROWS
INSERT INTO Main values (3,'C','Manager',25000);
INSERT INTO Main values (4,'D','Salesman',20000);
INSERT INTO Main values (5,'E','Engineer',10000);

-- NOW WE CAN EMPIDS FROM 2 to 4 as 1 is already deleted
select * from main;

-- And in Backup table we have empid 1 saved
select * from Backup;

-- UNION TO GET ALL THE VALUES
select * from Backup
UNION
select * from main;


create or replace trigger t2
before insert on Main
for each row
when(new.EmpID>0)
declare
sal_diff INT;
BEGIN
sal_diff := :new.EmpSalary - :old.EmpSalary;
dbms_output.put_line('Salary Difference: ' || sal_diff);
END;