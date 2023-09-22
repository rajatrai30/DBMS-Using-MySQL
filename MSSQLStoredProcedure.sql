-- ALL THESE ARE THE SYNTAX OF THE MS SQL SERVER 
CREATE PROCEDURE spGetEmployees
AS
BEGIN
select EmpID, EmpName from main;
END;

-- SHORT
CREATE PROC spGetEmployees
AS
BEGIN
select EmpID, EmpName from main;
END;

-- JUST EXECUTE BY CALLING NAME
 spGetEmployees
 Exec spGetEmployees
 Execute spGetEmployees
 
 -- PARAMETERIZED STORED PROCEDURE
CREATE PROC spGetEmployeesByParameter
@EmpRole CHAR(25),
AS 
BEGIN
	select EmpName, EmpRole from main 
	where EmpRole = @EmpRole
END


-- 3 SP WITH ENCRYPT
DELIMITER //
CREATE PROCEDURE  test(IN EmpParam INT, IN EmpParam2 CHAR(25))
WITH ENCRYPTION
BEGIN
	SELECT EmpID, EmpName, EmpRole FROM main WHERE EmpID = EmpParam AND EmpRole = EmpParam2;
END;
//
DELIMITER ;
CALL test(1,'engineer');