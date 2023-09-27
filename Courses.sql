USE ORG;
CREATE TABLE Enrolled (
	Student CHAR(100),
    Courses CHAR(100),
    PRIMARY KEY (Student, Courses)
);

INSERT INTO Enrolled VALUES('abc', 'c1');
INSERT INTO Enrolled VALUES('xyz', 'c2');
INSERT INTO Enrolled VALUES('abc', 'c2');
INSERT INTO Enrolled VALUES('pqr', 'c1');

CREATE TABLE Paid (
	Student CHAR(100),
    Amount INT
);

INSERT INTO Paid VALUES('abc', 2000);
INSERT INTO Paid VALUES('xyz', 1000);
INSERT INTO Paid VALUES('rst', 1000);

SELECT Student from Enrolled where Student
IN (SELECT Student from Paid);