-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ SET OPERATIONS IN SQL @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 

CREATE TABLE Dept1(
	EmpID INT,
    EmpName CHAR(25),
    EmpRole CHAR(25),
    EmpSalary INT
);

INSERT INTO Dept1 values (1,'A','Engineer',52000),(2,'B','Salesman',45000),(3,'C','Manager',25000),
(4,'D','Salesman',20000),(5,'E','Engineer',10000);

CREATE TABLE Dept2(
	EmpID INT,
    EmpName CHAR(25),
    EmpRole CHAR(25)
);

INSERT INTO Dept2 values (3,'C','Manager'),(6,'F','Marketing'),(7,'G','Salesman');

-- SET OPERATIONS
-- 1 LIST out all the employees in the company  
select * from Dept1
UNION
select * from Dept2;

-- 2LIST out all the employees in all the depts who works as a salesman
-- UNION OPERATIONS 
select * from Dept1 where EmpRole = 'Salesman'
UNION
select * from Dept2 where EmpRole = 'Salesman';

-- 3 LIST out all the employees who work in all the departments ()
-- INTERSECT 
 select dept1.* from Dept1 inner join Dept2 using(EmpID);
 
 -- 4 LIST out all the employees working in dept1 but not in dept2
 -- MINUS 
select Dept1.* from Dept1 left join Dept2 using(EmpID)
where dept2.EmpID is null;


-- MAX SALARY FINDING@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- WRITE A QUERY TO FIND THE NTH MAX SALARY OF AN EMPLOYEE
select * from Dept1 d1
where 1 = (select count(distinct d2.EmpSalary) from Dept1 d2
where d2.EmpSalary >= d1.EmpSalary);


-- WRITE A QUERY TO FIND THE NTH MIN SALARY OF AN EMPLOYEE
select * from Dept1 d1
where 1 = (select count(distinct d2.EmpSalary) from Dept1 d2
where d2.EmpSalary <= d1.EmpSalary);