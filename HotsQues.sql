-- HOTS QUESTIONS FOR SQL

CREATE TABLE Pairs(
	A INT,
    B INT
);

INSERT INTO Pairs values (1,2),(2,4),(2,1),(3,2),(4,2),(5,6),(6,5),(7,8);
select * from pairs;

-- WE DO NOT HAVE TO SHOW THE REVERSED VALUES
-- METHOD 1: JOINS 
SELECT lt.* from  pairs lt LEFT JOIN pairs rt on lt.A = rt.B and lt.B = rt.A
WHERE lt.A < rt.A OR rt.A IS NULL;

-- METHOD 1: CORRELATED SUB QUERIES
SELECT * FROM pairs p1 where not exists
(select * from pairs p2 where p1.A = p2.B AND p2.A = p1.B AND p1.A > p2.A);