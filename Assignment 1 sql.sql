CREATE DATABASE sale_database;
USE sale_database;
CREATE TABLE SalePeoples (
    Snum INT PRIMARY KEY,
    Sname VARCHAR(50) UNIQUE,
    City VARCHAR(50),
    Comm DECIMAL(5, 2)
);
-- Insert data into SalePeoples table
INSERT INTO SalePeoples (Snum, Sname, City, Comm) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'Sanjose', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rifkin', 'Barcelona', 0.15),
(1003, 'Axelrod', 'Newyork', 0.10);
CREATE TABLE Customer (
    Cnum INT PRIMARY KEY,
    Cname VARCHAR(50),
    City VARCHAR(50) NOT NULL,
    Snum INT,
    FOREIGN KEY (Snum) REFERENCES SalePeoples(Snum)
);
-- Insert data into Customer table
INSERT INTO Customer (Cnum, Cname, City, Snum) VALUES
(2001, 'Hoffman', 'London', 1001),
(2002, 'Giovanni', 'Rome', 1003),
(2003, 'Liu', 'Sanjose', 1002),
(2004, 'Grass', 'Berlin', 1002),
(2006, 'Clemens', 'London', 1001),
(2007, 'Pereira', 'Rome', 1004),
(2008, 'Cisneros', 'Sanjose', 1007);
CREATE TABLE Orders (
    Onum INT PRIMARY KEY,
    Amt DECIMAL(10, 2),
    Odate DATE,
    Cnum INT,
    Snum INT,
    FOREIGN KEY (Cnum) REFERENCES Customer(Cnum),
    FOREIGN KEY (Snum) REFERENCES SalePeoples(Snum)
);
-- Insert data into Orders table
INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum) VALUES
(3001, 18.69, '1990-03-10', 2008, 1007),
(3002, 1900.10, '1990-03-10', 2007, 1004),
(3003, 767.19, '1990-03-10', 2001, 1001),
(3005, 5160.45, '1990-03-10', 2003, 1002),
(3006, 1098.16, '1990-03-10', 2008, 1007),
(3007, 75.75, '1990-04-10', 2004, 1002),
(3008, 4273.00, '1990-05-10', 2006, 1001),
(3009, 1713.23, '1990-04-10', 2002, 1003),
(3010, 1309.95, '1990-06-10', 2004, 1002),
(3011, 9891.88, '1990-06-10', 2006, 1001);

-- Count the number of Salespersons whose names begin with 'a' or 'A':

SELECT COUNT(*) AS NumberOfSalepeoples
FROM SalePeoples
WHERE Sname LIKE 'A%' OR Sname LIKE 'a%';

-- Display all Salespersons whose total order amounts are more than Rs. 2000:

SELECT S.Snum, S.Sname
FROM SalePeoples AS S
JOIN (
    SELECT Snum, SUM(Amt) AS TotalAmount
    FROM Orders
    GROUP BY Snum
    HAVING TotalAmount > 2000
) AS O ON S.Snum = O.Snum;

-- Count the number of Salespeople belonging to New York:

SELECT COUNT(*) AS NumberOfSalepeoplesInNewYork
FROM SalePeoples
WHERE City = 'Newyork';

-- Display the number of Salespeople belonging to London and Paris:

SELECT City, COUNT(*) AS NumberOfSalepeoples
FROM SalePeoples
WHERE City IN ('London', 'Paris')
GROUP BY City;

-- Display the number of orders taken by each Salesperson and their date of orders:

SELECT S.Sname, O.Odate, COUNT(*) AS NumberOfOrders
FROM SalePeoples AS S
JOIN Orders AS O ON S.Snum = O.Snum
GROUP BY S.Sname, O.Odate
ORDER BY S.Sname, O.Odate;





