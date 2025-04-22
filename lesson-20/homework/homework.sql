select 2

CREATE TABLE #Sales ( SaleID INT PRIMARY KEY IDENTITY(1,1), CustomerName VARCHAR(100), Product VARCHAR(100), Quantity INT, Price DECIMAL(10,2), SaleDate DATE );
INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES ('Alice', 'Laptop', 1, 1200.00, '2024-01-15'), ('Bob', 'Smartphone', 2, 800.00, '2024-02-10'), ('Charlie', 'Tablet', 1, 500.00, '2024-02-20'), ('David', 'Laptop', 1, 1300.00, '2024-03-05'), ('Eve', 'Smartphone', 3, 750.00, '2024-03-12'), ('Frank', 'Headphones', 2, 100.00, '2024-04-08'), ('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'), ('Hannah', 'Tablet', 2, 480.00, '2024-05-05'), ('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'), ('Jack', 'Smartphone', 1, 820.00, '2024-06-01');



--Find customers who purchased at least one item in March 2024 using EXISTS
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName = s2.CustomerName
      AND MONTH(s2.SaleDate) = 3 AND YEAR(s2.SaleDate) = 2024
);

--Find the product with the highest total sales revenue using a subquery.
SELECT TOP 1 Product
FROM #Sales
GROUP BY Product
ORDER BY SUM(Quantity * Price) DESC;

--Find the second highest sale amount using a subquery
SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) AS SalesAmounts
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price) FROM #Sales
);

--Find the total quantity of products sold per month using a subquery
SELECT SaleMonth, SUM(Quantity) AS TotalQuantity
FROM (
    SELECT MONTH(SaleDate) AS SaleMonth, Quantity
    FROM #Sales
) AS MonthlySales
GROUP BY SaleMonth;

--Find customers who bought same products as another customer using EXISTS */
SELECT DISTINCT f1.CustomerName
FROM #Sales f1
WHERE EXISTS (
    SELECT 1
    FROM #Sales f2
    WHERE f1.Product = f2.Product
      AND f1.CustomerName <> f2.CustomerName
);

--Question 6.

create table Fruits(Name varchar(50), Fruit varchar(50)) insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'), ('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), ('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), ('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), ('Mario', 'Orange') -- Return how many fruits does each person have in individual fruit level

--Expected Output /* Name Apple Orange Banana Francesko 3 2 1 Li 2 1 1 Mario 3 1 2 */
SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

--Question 7. 
create table Family(ParentId int, ChildID int) insert into Family values (1, 2), (2, 3), (3, 4)
--Return older people in the family with younger ones, 1 Oldest person in the family --grandfather --2 Father --3 Son --4 Grandson
/* Expected output 1 2 1 3 1 4 2 3 2 4 3 4 */
WITH Ancestors AS (
    SELECT ParentId, ChildID FROM Family
    UNION ALL
    SELECT a.ParentId, f.ChildID
    FROM Ancestors a
    JOIN Family f ON a.ChildID = f.ParentId
)
SELECT * FROM Ancestors;

--Question 8.

CREATE TABLE #Orders ( CustomerID INTEGER, OrderID INTEGER, DeliveryState VARCHAR(100) NOT NULL, Amount MONEY NOT NULL, PRIMARY KEY (CustomerID, OrderID) ); 

INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES (1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670), (1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650), (3003,7,'CA',830),(4004,8,'TX',120); 
SELECT * FROM #Orders o1
WHERE DeliveryState = 'TX'
  AND EXISTS (
    SELECT 1 FROM #Orders o2
    WHERE o1.CustomerID = o2.CustomerID AND o2.DeliveryState = 'CA'
);


--Question 9. /* Write an SQL statement given the following requirements. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas*/
create table #residents(resid int identity, fullname varchar(50), address varchar(100))
insert into #residents values ('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'), ('Diogo', 'city=Lisboa country=Portugal age=26'), ('Celine', 'city=Marseille country=France name=Celine age=21'), ('Theo', 'city=Milan country=Italy age=28'), ('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')
UPDATE #residents
SET fullname = 
    SUBSTRING(address, CHARINDEX('name=', address) + 5, 
               CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) - CHARINDEX('name=', address) - 5)
WHERE fullname IS NULL;
-- Insert the names of residents if they are missing

--Question 10

CREATE TABLE #Routes ( RouteID INTEGER NOT NULL, DepartureCity VARCHAR(30) NOT NULL, ArrivalCity VARCHAR(30) NOT NULL, Cost MONEY NOT NULL, PRIMARY KEY (DepartureCity, ArrivalCity) ); 

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES (1,'Tashkent','Samarkand',100), (2,'Samarkand','Bukhoro',200), (3,'Bukhoro','Khorezm',300), (4,'Samarkand','Khorezm',400), (5,'Tashkent','Jizzakh',100), (6,'Jizzakh','Samarkand',50); 

--Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest --and the most expensive routes

/* Expected Output Tashkent - Samarkand - Khorezm 500 Tashkent - Samarkand - Bukhoro - Khorezm 600 */
-- Cheapest route
SELECT 'Tashkent - Samarkand - Khorezm' AS Route, 100 + 400 AS TotalCost
UNION
-- Most expensive route
SELECT 'Tashkent - Samarkand - Bukhoro - Khorezm', 100 + 200 + 300;

--Question 11

CREATE TABLE #RankingPuzzle ( ID INT ,Vals VARCHAR(10) ) 

INSERT INTO #RankingPuzzle VALUES (1,'Product'), (2,'a'), (3,'a'), (4,'a'), (5,'a'), (6,'Product'), (7,'b'), (8,'b'), (9,'Product'), (10,'c') 

--Rank products based on their order of insertion.
WITH Ranked AS (
    SELECT ID, Vals,
           SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) OVER (ORDER BY ID) AS ProductGroup
    FROM #RankingPuzzle
)
SELECT * FROM Ranked
WHERE Vals <> 'Product';

--Question 12
CREATE TABLE #Consecutives ( Id VARCHAR(5)
,Vals INT /* Value can be 0 or 1 */ ) 
INSERT INTO #Consecutives VALUES ('a', 1), ('a', 0), ('a', 1), ('a', 1), ('a', 1), ('a', 0), ('b', 1), ('b', 1), ('b', 0), ('b', 1), ('b', 0) 
--You have to return Ids, what number of the letter would be next if inserted, --the maximum length of the consecutive occurence of the same digit
WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) -
           ROW_NUMBER() OVER (PARTITION BY Id, Vals ORDER BY (SELECT NULL)) AS grp
    FROM #Consecutives
),
MaxConsec AS (
    SELECT Id, Vals, COUNT(*) AS Len
    FROM CTE
    GROUP BY Id, Vals, grp
)
SELECT Id,
       (SELECT TOP 1 Vals FROM #Consecutives WHERE Id = mc.Id ORDER BY Id DESC) AS LastVal,
       MAX(Len) AS MaxConsecutiveLength
FROM MaxConsec mc
GROUP BY Id;



--Question 13 
CREATE TABLE #EmployeeSales ( EmployeeID INT PRIMARY KEY IDENTITY(1,1), EmployeeName VARCHAR(100), Department VARCHAR(50), SalesAmount DECIMAL(10,2), SalesMonth INT, SalesYear INT );
INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES ('Alice', 'Electronics', 5000, 1, 2024), ('Bob', 'Electronics', 7000, 1, 2024), ('Charlie', 'Furniture', 3000, 1, 2024), ('David', 'Furniture', 4500, 1, 2024), ('Eve', 'Clothing', 6000, 1, 2024), ('Frank', 'Electronics', 8000, 2, 2024), ('Grace', 'Furniture', 3200, 2, 2024), ('Hannah', 'Clothing', 7200, 2, 2024), ('Isaac', 'Electronics', 9100, 3, 2024), ('Jack', 'Furniture', 5300, 3, 2024), ('Kevin', 'Clothing', 6800, 3, 2024), ('Laura', 'Electronics', 6500, 4, 2024), ('Mia', 'Furniture', 4000, 4, 2024), ('Nathan', 'Clothing', 7800, 4, 2024);
--Find employees whose sales were higher than the average sales in their department
SELECT *
FROM #EmployeeSales e
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);




--14. Find employees who had the highest sales in any given month using EXISTS
SELECT *
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1 FROM #EmployeeSales e2
    WHERE e1.SalesMonth = e2.SalesMonth AND e1.SalesYear = e2.SalesYear
      AND e2.SalesAmount > e1.SalesAmount
);

--15. Find employees who made sales in every month using NOT EXISTS -- Insert Sample Data

CREATE TABLE Products ( ProductID INT PRIMARY KEY, Name VARCHAR(50), Category VARCHAR(50), Price DECIMAL(10,2), Stock INT );

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES (1, 'Laptop', 'Electronics', 1200.00, 15), (2, 'Smartphone', 'Electronics', 800.00, 30), (3, 'Tablet', 'Electronics', 500.00, 25), (4, 'Headphones', 'Accessories', 150.00, 50), (5, 'Keyboard', 'Accessories', 100.00, 40), (6, 'Monitor', 'Electronics', 300.00, 20), (7, 'Mouse', 'Accessories', 50.00, 60), (8, 'Chair', 'Furniture', 200.00, 10), (9, 'Desk', 'Furniture', 400.00, 5), (10, 'Printer', 'Office Supplies', 250.00, 12), (11, 'Scanner', 'Office Supplies', 180.00, 8), (12, 'Notebook', 'Stationery', 10.00, 100), (13, 'Pen', 'Stationery', 2.00, 500), (14, 'Backpack', 'Accessories', 80.00, 30), (15, 'Lamp', 'Furniture', 60.00, 25);
SELECT DISTINCT e1.EmployeeName
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1 FROM (
        SELECT DISTINCT SalesMonth FROM #EmployeeSales
    ) AS m
    WHERE NOT EXISTS (
        SELECT 1 FROM #EmployeeSales e2
        WHERE e1.EmployeeName = e2.EmployeeName AND e2.SalesMonth = m.SalesMonth
    )
);

-- 16. Retrieve the names of products that are more expensive than the average price of all products.
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 17. Find the products that have a stock count lower than the highest stock count.
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

-- 18. Get the names of products that belong to the same category as 'Laptop'.
SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

-- 19. Retrieve products whose price is greater than the lowest price in the Electronics category.
SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);

-- 20. Find the products that have a higher price than the average price of their respective category.

CREATE TABLE Orders ( OrderID INT PRIMARY KEY, ProductID INT, Quantity INT, OrderDate DATE, FOREIGN KEY (ProductID) REFERENCES Products(ProductID) );

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES (1, 1, 2, '2024-03-01'), (2, 3, 5, '2024-03-05'), (3, 2, 3, '2024-03-07'), (4, 5, 4, '2024-03-10'), (5, 8, 1, '2024-03-12'), (6, 10, 2, '2024-03-15'), (7, 12, 10, '2024-03-18'), (8, 7, 6, '2024-03-20'), (9, 6, 2, '2024-03-22'), (10, 4, 3, '2024-03-25'), (11, 9, 2, '2024-03-28'), (12, 11, 1, '2024-03-30'), (13, 14, 4, '2024-04-02'), (14, 15, 5, '2024-04-05'), (15, 13, 20, '2024-04-08');
SELECT Name
FROM Products p
WHERE Price > (
    SELECT AVG(Price) FROM Products
    WHERE Category = p.Category
);

-- 21. Find the products that have been ordered at least once.
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

-- 22. Retrieve the names of products that have been ordered more than the average quantity ordered.
SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(Quantity) FROM Orders
);

-- 23. Find the products that have never been ordered.
SELECT Name
FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM Orders);

-- 24. Retrieve the product with the highest total quantity ordered.
SELECT TOP 1 p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY SUM(o.Quantity) DESC;

-- 25. Find the products that have been ordered more times than the average number of orders placed.

SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING COUNT(o.OrderID) > (
    SELECT AVG(OrderCount)
    FROM (
        SELECT COUNT(*) AS OrderCount
        FROM Orders
        GROUP BY ProductID
    ) AS Sub
);
