CREATE DATABASE Temp;
USE temp;

CREATE TABLE Worker(
	Worker_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    First_Name CHAR(15),
    Last_Name CHAR(15),
    Salary INT(15),
    Joining_Date DATETIME,
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
    Bonus_Date DATETIME,
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
    Affected_From DATETIME,
    FOREIGN KEY (Worker_Ref_ID)
    REFERENCES Worker(Worker_ID)
    ON DELETE CASCADE
);

INSERT INTO Title(Worker_Ref_ID, Work_Title, Affected_From) VALUES
	(1, 'Associate Developer', '03-05-20'),
	(2, 'Manager', '03-05-20'),
	(3, 'Lead of Deev', '03-05-20'),
	(4, 'CFO', '03-05-20');
    
INSERT INTO Title(Worker_Ref_ID, Work_Title, Affected_From) VALUES
	(5, 'Associate Developer', '03-05-20'),
	(6, 'Manager', '03-05-20'),
	(7, 'Lead of Deev', '03-05-20'),
	(8, 'CFO', '03-05-20');


-- @@@@@@@@@@@@@@@@@@@@@@@@@@ MOST IMPORTANT SQL QUESTIONS FOR INTERVIEWS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT First_Name AS Worker_Name FROM Worker;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT UPPER(First_Name) FROM Worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT distinct department from worker;
SELECT department from worker GROUP BY department;

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT substring(first_name, 1, 3) from worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘j’) in the first name column ‘Rajat’ from Worker table.
SELECT instr(first_name, 'j') from worker where first_name = 'Rajat';

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
select RTRIM(first_name) from worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT rtrim(first_name) from worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT distinct department, length(department) from worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT first_name, replace(first_name, 'a', 'A') from worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
SELECT first_name, last_name, concat(first_name, ' ', last_name) AS COMPLETE_NAME from worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM worker order by first_name;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by 
-- FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM worker order by first_name, department DESC;

-- Q-13. Write an SQL query to print details for Workers with the first name as “Rajat” and “Rahul” from Worker table.
SELECT * FROM worker where first_name IN ('Rajat', 'Rahul');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Rajat” and “Rahul” from Worker table.
SELECT * FROM worker where first_name NOT IN ('Rajat', 'Rahul');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin*”.
SELECT * FROM worker where department IN ('Admin');

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM worker where first_name LIKE '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
select * from worker where first_name LIKE '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘t’ and contains five alphabets.
select * from worker where first_name LIKE '____t';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
select * from worker where salary between 100000 AND 500000;

-- Q-20. Write an SQL query to print details of the Workers who have joined in OCT’2001.
SELECT * FROM worker where YEAR(Joining_Date) = 2001 AND MONTH(Joining_Date) = 10;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT department, count(department) as EmployeesAdmin from worker where department = 'Admin';

-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
SELECT CONCAT(First_Name, ' ', Last_Name) AS COMPLETE_NAME FROM worker where
salary between 50000 AND 100000;

-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT department, count(Worker_ID) as EmployeesCount from worker group by department
order by count(Worker_ID) DESC;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT W.*, T.Work_Title FROM worker AS W INNER JOIN Title AS T ON 
(W.Worker_ID = T.Worker_Ref_ID)
WHERE T.Work_Title = 'Manager';

-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
SELECT Work_Title, COUNT(*) FROM Title GROUP BY Work_Title HAVING COUNT(*) > 1;

-- Q-26. Write an SQL query to show only odd rows from a table.
SELECT * FROM worker WHERE mod(Worker_ID, 2) != 0;
SELECT * FROM worker WHERE mod(Worker_ID, 2) <> 0;


-- Q-27. Write an SQL query to show only even rows from a table. 
SELECT * FROM worker WHERE mod(Worker_ID, 2) = 0;

-- Q-28. Write an SQL query to clone a new table from another table.
CREATE TABLE Worker_Clone like worker;
INSERT INTO Worker_Clone select * from worker;
select * from Worker_Clone;

-- Q-29. Write an SQL query to fetch intersecting records of two tables.
select worker.* from worker inner join Worker_Clone using(Worker_ID);

-- Q-30. Write an SQL query to show records from one table that another table does not have.
-- MINUS
select worker.* from worker left join Worker_Clone using(Worker_ID) where Worker_Clone.Worker_ID IS NULL;

-- Q-31. Write an SQL query to show the current date and time.
-- DUAL
SELECT curdate();
select now();

-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
select * from worker order by salary DESC LIMIT 5;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
select * from worker order by salary DESC LIMIT 4,1;

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
select * from worker as w1
where 5 = (select count(distinct (w2.salary)) from worker as w2
where w2.salary >= w1.salary);
 
-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
select w1.First_Name from worker w1, worker w2 where w1.salary = w2.salary and w1.Worker_ID <> w2.Worker_ID;
-- select * from worker where First_Name = 'Rajat'


-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
select max(salary) from worker
where salary NOT IN (select max(salary) from worker);



-- MY KNOWLEDGE 3RD HIGHEST USING SUB QUERY
select max(salary) from worker
where salary NOT IN (select max(salary) from worker
UNION
select max(salary) from worker
where salary NOT IN (select max(salary) from worker));



-- Q-37. Write an SQL query to show one row twice in results from a table.
select * from worker
UNION ALL
select * from worker ORDER BY worker_id;

-- Q-38. Write an SQL query to list worker_id who does not get bonus.
select * from worker where worker_id not in (select Worker_Ref_ID from bonus);

-- Q-39. Write an SQL query to fetch the first 50% records from a table.
select * from worker where worker_id <= (select count(worker_id)/2 from worker);

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
select Department, count(*) as DeptCount from worker group by Department having DeptCount < 4;


-- Q-41. Write an SQL query to show all departments along with the number of people in there.
select Department, count(*) as DeptCount from worker group by Department;


-- Q-42. Write an SQL query to show the last record from a table.
select * from worker LIMIT 7,1;
select * from worker where Worker_ID = (select max(Worker_ID) from worker);


-- Q-43. Write an SQL query to fetch the first row of a table.
select * from worker LIMIT 0,1;
select * from worker where Worker_ID = (select min(Worker_ID) from worker);

-- Q-44. Write an SQL query to fetch the last five records from a table.
select * from worker LIMIT 3,5;
(select * from worker order by Worker_ID DESC LIMIT 5) ORDER BY Worker_ID;

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
select w.First_Name, w.Department, w.Salary from (select Department, max(Salary) as maxsal from worker group by Department) temp
INNER JOIN worker w ON temp.maxsal = w.Salary and temp.Department = w.Department;


-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
select distinct salary from worker w1 where 
3 >= (select count(distinct salary) from worker w2
where w2.salary >= w1.salary) order by w1.salary desc;

-- DRY RUN AFTER REVISING THE CORELATED SUBQUERY CONCEPT FROM LEC-9.
select distinct salary from worker order by salary desc limit 3;

-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
select distinct salary from worker w1 where 
3 >= (select count(distinct salary) from worker w2
where w2.salary <= w1.salary) order by w1.salary desc;

-- Q-48. Write an SQL query to fetch nth max salaries from a table.
select distinct salary from worker w1 where 
2 >= (select count(distinct salary) from worker w2
where w2.salary >= w1.salary) order by w1.salary desc;

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
select Department, sum(Salary) as deptsal from worker group by Department order by deptsal desc;

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
select First_Name, Salary from worker where Salary IN (select max(Salary) from worker);
    
    
    
    
    
    
    
    
    
    
    


