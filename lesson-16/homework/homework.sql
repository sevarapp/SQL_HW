create database home
use home

DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil',3),('Eraser',4),('Notebook',2);

select * from Grouped

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < 10
),
Expanded AS (
    SELECT g.Product, 1 AS Quantity
    FROM Grouped g
    JOIN Numbers n ON n.n <= g.Quantity
)
SELECT Product, Quantity
FROM Expanded
ORDER BY Product
OPTION (MAXRECURSION 0);

DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales
(
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10),
('South','ACE',67),
('East','ACE',54),
('North','ACME',65),
('South','ACME',9),
('East','ACME',1),
('West','ACME',7),
('North','Direct Parts',8),
('South','Direct Parts',7),
('West','Direct Parts',12);
GO


SELECT 
  r.Region, 
  d.Distributor,
  COALESCE(rs.Sales, 0) AS Sales
FROM 
  (SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN 
  (SELECT DISTINCT Distributor FROM #RegionSales) d
LEFT JOIN 
  #RegionSales rs
  ON r.Region = rs.Region AND d.Distributor = rs.Distributor
ORDER BY 
 d.Distributor;


CREATE TABLE Employee (
  id INT,
  name VARCHAR(255),
  department VARCHAR(255),
  managerId INT
);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);

select * from Employee
SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;

CREATE TABLE Products (
  product_id INT,
  product_name VARCHAR(40),
  product_category VARCHAR(40)
);
CREATE TABLE Orders (
  product_id INT,
  order_date DATE,
  unit INT
);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1, '2020-02-05', 60),
(1, '2020-02-10', 70),
(2, '2020-01-18', 30),
(2, '2020-02-11', 80),
(3, '2020-02-17', 2),
(3, '2020-02-24', 3),
(4, '2020-03-01', 20),
(4, '2020-03-04', 30),
(4, '2020-03-04', 60),
(5, '2020-02-25', 50),
(5, '2020-02-27', 50),
(5, '2020-03-01', 50);

select * from Products
Select * from Orders

select distinct p.product_name
from Products p
join Orders o
ON p.product_id=o.product_id
where o.order_date between '2020-02-01' and '2020-02-29' 
group by p.product_name
HAVING SUM(o.unit) >= 100
order by p.product_name

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID     INT PRIMARY KEY,
  CustomerID  INT NOT NULL,
  [Count]     MONEY NOT NULL,
  Vendor      VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1, 1001, 12, 'Direct Parts'),
(2, 1001, 54, 'Direct Parts'),
(3, 1001, 32, 'ACME'),
(4, 2002, 7, 'ACME'),
(5, 2002, 16, 'ACME'),
(6, 2002, 5, 'Direct Parts');

select * from Orders
WITH VCounts AS (
  SELECT 
    CustomerID, 
    Vendor, 
    COUNT(*) AS OrderCount,
    ROW_NUMBER() OVER (
      PARTITION BY CustomerID 
      ORDER BY COUNT(*) DESC
    ) AS rn
  FROM Orders
  GROUP BY CustomerID, Vendor
)
SELECT CustomerID, Vendor
FROM VCounts
WHERE rn = 1;


DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;

WHILE @i < @Check_Prime
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i = @i + 1;
END

IF @isPrime = 1
    PRINT 'Prime';
ELSE
    PRINT 'Not Prime';




CREATE TABLE Device (
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12, 'Bangalore'),
(12, 'Bangalore'),
(12, 'Bangalore'),
(12, 'Bangalore'),
(12, 'Hosur'),
(12, 'Hosur'),
(13, 'Hyderabad'),
(13, 'Hyderabad'),
(13, 'Secunderabad'),
(13, 'Secunderabad'),
(13, 'Secunderabad');




WITH SignalCount AS (
  SELECT Device_id, Locations, COUNT(*) AS signal_count
  FROM Device
  GROUP BY Device_id, Locations
),
MaxLoc AS (
  SELECT Device_id, Locations AS max_signal_location
  FROM (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY signal_count DESC) AS rn
    FROM SignalCount
  ) t
  WHERE rn = 1
)
SELECT 
  d.Device_id,
  COUNT(DISTINCT d.Locations) AS no_of_location,
  m.max_signal_location,
  COUNT(*) AS no_of_signals
FROM Device d
JOIN MaxLoc m ON d.Device_id = m.Device_id
GROUP BY d.Device_id, m.max_signal_location;

WITH DeptAvg AS (
  SELECT DeptID, AVG(Salary) AS avg_salary
  FROM Employee
  GROUP BY DeptID
)
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN DeptAvg d ON e.DeptID = d.DeptID
WHERE e.Salary > d.avg_salary;

SELECT 
  COUNT(*) * 10 AS Total_Winning
FROM Tickets t
JOIN WinningNumbers w
  ON t.Number = w.Number;
-- Base CTEs
WITH MobileUsers AS (
  SELECT Spend_date, User_id, SUM(Amount) AS Amount
  FROM Spending
  WHERE Platform = 'Mobile'
  GROUP BY Spend_date, User_id
),
DesktopUsers AS (
  SELECT Spend_date, User_id, SUM(Amount) AS Amount
  FROM Spending
  WHERE Platform = 'Desktop'
  GROUP BY Spend_date, User_id
),
BothUsers AS (
  SELECT m.Spend_date, m.User_id
  FROM MobileUsers m
  JOIN DesktopUsers d ON m.Spend_date = d.Spend_date AND m.User_id = d.User_id
)

-- Final Union
SELECT Spend_date, 'Mobile' AS Platform, SUM(Amount) AS Total_Amount, COUNT(DISTINCT User_id) AS Total_users
FROM MobileUsers
GROUP BY Spend_date

UNION ALL

SELECT Spend_date, 'Desktop' AS Platform, SUM(Amount), COUNT(DISTINCT User_id)
FROM DesktopUsers
GROUP BY Spend_date

UNION ALL

SELECT b.Spend_date, 'Both', 0, 0
FROM BothUsers b
GROUP BY b.Spend_date;
