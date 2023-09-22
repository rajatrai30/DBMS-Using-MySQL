-- STORED PROCEDURE EXAMPLE 
DELIMITER //
CREATE PROCEDURE spGetEmployeesShort()
BEGIN
    SELECT EmpID, EmpName FROM main;
END;
//
DELIMITER ;
CALL spGetEmployeesShort();



-- PARAMETERIZED STORED PROCEDURE
-- 1 WITH SINGLE 
DELIMITER //
CREATE PROCEDURE  spGetEmployeesParameterized(IN EmpParam CHAR(25))
BEGIN
	SELECT EmpID, EmpName, EmpRole FROM main WHERE EmpRole = EmpParam;
END;
//
DELIMITER ;
CALL spGetEmployeesParameterized('manager');


-- 1 DOUBLE PARAMS
DELIMITER //
CREATE PROCEDURE  spGetEmployeesDoubleParameterized(IN EmpParam CHAR(25), IN EmpParam2 CHAR(25))
BEGIN
	SELECT EmpID, EmpName, EmpRole FROM main WHERE EmpRole = EmpParam OR EmpRole = EmpParam2;
END;
//
DELIMITER ;
CALL spGetEmployeesDoubleParameterized('Salesman', 'Engineer');

-- 2 INT AND CHAR
DELIMITER //
CREATE PROCEDURE  spGetEmployeesDoubleParamIntChar(IN EmpParam INT, IN EmpParam2 CHAR(25))
BEGIN
	SELECT EmpID, EmpName, EmpRole FROM main WHERE EmpID = EmpParam AND EmpRole = EmpParam2;
END;
//
DELIMITER ;
CALL spGetEmployeesDoubleParamIntChar(1,'engineer');