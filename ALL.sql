CREATE DATABASE Temp;
USE temp;

CREATE TABLE Worker(
	Worker_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    First_Name CHAR(15),
    Last_Name CHAR(15),
    Salary INT(15),
    Joining_Date DATE,
    Department CHAR(25)
);

INSERT INTO Worker VALUES(1, 'Rajat', 'Rai', 15000, '30-09-20', 'IT');
INSERT INTO Worker VALUES(2, 'Rahul', 'Rai', 55000, '30-01-20', 'HR');
INSERT INTO Worker VALUES(3, 'Rishabh', 'Rai', 15000, '31-08-20', 'IT');
INSERT INTO Worker VALUES(4, 'Rohit', 'Rai', 15000, '01-10-20', 'IT');
INSERT INTO Worker VALUES(5, 'Rohini', 'Rai', NULL, '01-10-20', 'IT');
INSERT INTO Worker VALUES(6, 'Abhilasha', 'Rai', 125000, '01-11-20', 'HR');
INSERT INTO Worker VALUES(7, 'OP', 'Rai', 2500000, '01-12-20', 'Admin');
INSERT INTO Worker VALUES(8, 'JP', 'Rai', 3500000, '01-04-20', 'Admin');



SELECT * FROM Worker;
DROP TABLE Worker;


CREATE TABLE Bonus(
	Worker_Ref_ID INT,
    Bonus_Amount INT(25),
    Bonus_Date DATE,
    FOREIGN KEY (Worker_Ref_ID)
    REFERENCES Worker(Worker_ID)
    ON DELETE CASCADE
);

INSERT INTO Bonus(Worker_Ref_ID, Bonus_Amount, Bonus_Date) VALUES
	(1, 5000, '03-05-20'),
	(2, 5000, '03-05-20'),
	(3, 5000, '03-05-20'),
	(2, 5000, '03-05-20');
    
INSERT INTO Bonus(Worker_Ref_ID, Bonus_Amount, Bonus_Date) VALUES
	(4, 50000, '03-07-20');


CREATE TABLE Title(
	Worker_Ref_ID INT,
    Work_Title CHAR(25),
    Affected_From DATE,
    FOREIGN KEY (Worker_Ref_ID)
    REFERENCES Worker(Worker_ID)
    ON DELETE CASCADE
);

INSERT INTO Title(Worker_Ref_ID, Work_Title, Affected_From) VALUES
	(1, 'Associate Developer', '03-05-20'),
	(2, 'Manager', '03-05-20'),
	(3, 'Lead of Deev', '03-05-20'),
	(4, 'CFO', '03-05-20');
    
SELECT * FROM title;

-- NOT IN EXAMPLE
SELECT * FROM Worker WHERE Department NOT IN ('HR');

-- IN EXAMPLE 
SELECT * FROM Worker WHERE Department IN (IT);

-- IS NULL EXAMPLE
SELECT * FROM Worker WHERE Salary IS NULL;

-- PATTERN SEARCHING
SELECT * FROM Worker WHERE First_Name LIKE '_a%';
SELECT * FROM Worker WHERE First_Name LIKE 'Ra%';
SELECT * FROM Worker WHERE First_Name LIKE 'Ro___';
SELECT * FROM Worker WHERE First_Name LIKE '%sh%';
SELECT * FROM Worker WHERE First_Name LIKE '%t';

-- SORTING AND ORDER BY
SELECT * FROM Worker
WHERE Salary >= 200
ORDER BY Salary DESC;

-- DISTINCT MEANS UNIQUE KITNE HAI
SELECT DISTINCT Department FROM Worker;

-- GROUP BY EXAMPLE WITH COUNT
SELECT Department, COUNT(Department) AS DepartmentCount FROM Worker
GROUP BY Department;

-- GROUP BY EXAMPLE WITH TOTAL SALARY FOR EACH DEPT
SELECT Department, COUNT(Department) AS DepartmentCount, SUM(Salary) AS EachDeptSalary FROM Worker
GROUP BY Department;

-- GROUP BY EXAMPLE WITH AVERGAE SALARY FOR EACH DEPT
SELECT Department, COUNT(Department) AS DeptCount, AVG(Salary) AS AverageDeptSalary FROM Worker
GROUP BY Department;

-- GROUP BY EXAMPLE WITH MIN SALARY FOR EACH DEPT
SELECT Department, COUNT(Department) AS DeptCount, MIN(Salary) AS MinimumDeptSalary FROM Worker
GROUP BY Department;

-- GROUP BY EXAMPLE WITH MIN SALARY FOR EACH DEPT
SELECT Department, COUNT(Department) AS DeptCount, MAX(Salary) AS MaximumDeptSalary FROM Worker
GROUP BY Department;

-- GROUP BY HAVING CLAUSE 
SELECT Department, COUNT(Department) AS DepartmentCount FROM Worker
GROUP BY Department
HAVING DepartmentCount > 2;

-- SUBQUERY TIMEPASSSSS
SELECT Worker_ID, First_Name, Salary FROM Worker
WHERE Worker_ID IN (SELECT Worker_Ref_ID FROM Bonus WHERE Bonus_Amount > 5000);




    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


