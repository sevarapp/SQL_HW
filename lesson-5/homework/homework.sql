-- 🟢 Easy-Level Tasks  

-- 1. Rename ProductName as Name in Products  
SELECT ProductName AS Name FROM Products;

-- 2. Rename Customers table as Client  
SELECT * FROM Customers AS Client;

-- 3. UNION ProductName from Products and Products_Discontinued  
SELECT ProductName FROM Products  
UNION  
SELECT ProductName FROM Products_Discontinued;

-- 4. INTERSECT Products and Products_Discontinued  
SELECT ProductName FROM Products  
INTERSECT  
SELECT ProductName FROM Products_Discontinued;

-- 5. UNION ALL Products and Orders  
SELECT ProductID, ProductName FROM Products  
UNION ALL  
SELECT ProductID, OrderName FROM Orders;

-- 6. Select distinct customer names and country  
SELECT DISTINCT CustomerName, Country FROM Customers;

-- 7. CASE for PriceCategory  
SELECT ProductName, Price,  
       CASE WHEN Price > 100 THEN 'High' ELSE 'Low' END AS PriceCategory  
FROM Products;

-- 8. Group Employees by Country and Department  
SELECT Country, Department, COUNT(*) AS EmployeeCount  
FROM Employees  
GROUP BY Country, Department;

-- 9. Count products per category  
SELECT CategoryID, COUNT(ProductID) AS ProductCount  
FROM Products  
GROUP BY CategoryID;

-- 10. IIF for Stock status  
SELECT ProductName, Stock, IIF(Stock > 100, 'Yes', 'No') AS InStock  
FROM Products;


-- 🟠 Medium-Level Tasks  

-- 11. INNER JOIN Orders and Customers, alias CustomerName as ClientName  
SELECT O.OrderID, C.CustomerName AS ClientName  
FROM Orders O  
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;

-- 12. UNION ProductName from Products and OutOfStock  
SELECT ProductName FROM Products  
UNION  
SELECT ProductName FROM OutOfStock;

-- 13. EXCEPT Products and DiscontinuedProducts  
SELECT ProductName FROM Products  
EXCEPT  
SELECT ProductName FROM DiscontinuedProducts;

-- 14. CASE for Customer Order Status  
SELECT CustomerID, COUNT(OrderID) AS OrderCount,  
       CASE WHEN COUNT(OrderID) > 5 THEN 'Eligible' ELSE 'Not Eligible' END AS Status  
FROM Orders  
GROUP BY CustomerID;

-- 15. IIF for price category  
SELECT ProductName, Price, IIF(Price > 100, 'Expensive', 'Affordable') AS PriceCategory  
FROM Products;

-- 16. Count orders per CustomerID  
SELECT CustomerID, COUNT(OrderID) AS OrderCount  
FROM Orders  
GROUP BY CustomerID;

-- 17. Find Employees Age < 25 OR Salary > 6000  
SELECT * FROM Employees  
WHERE Age < 25 OR Salary > 6000;

-- 18. Total sales per region  
SELECT Region, SUM(SalesAmount) AS TotalSales  
FROM Sales  
GROUP BY Region;

-- 19. LEFT JOIN Customers and Orders, alias OrderDate  
SELECT C.CustomerID, C.CustomerName, O.OrderDate AS DateOrdered  
FROM Customers C  
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID;

-- 20. IF to update salary for HR  
UPDATE Employees  
SET Salary = Salary * 1.1  
WHERE Department = 'HR';


-- 🔴 Hard-Level Tasks  

-- 21. UNION ALL Sales and Returns, calculate total  
SELECT ProductID, SUM(SalesAmount) AS TotalAmount, 'Sales' AS Type  
FROM Sales  
GROUP BY ProductID  
UNION ALL  
SELECT ProductID, SUM(ReturnAmount) AS TotalAmount, 'Returns' AS Type  
FROM Returns  
GROUP BY ProductID;

-- 22. INTERSECT Products and DiscontinuedProducts  
SELECT ProductName FROM Products  
INTERSECT  
SELECT ProductName FROM DiscontinuedProducts;

-- 23. CASE for Customer Tier  
SELECT CustomerID, TotalSales,  
       CASE  
           WHEN TotalSales > 10000 THEN 'Top Tier'  
           WHEN TotalSales BETWEEN 5000 AND 10000 THEN 'Mid Tier'  
           ELSE 'Low Tier'  
       END AS CustomerCategory  
FROM Customers;

-- 24. WHILE loop for salary updates (More Efficient)  
DECLARE @EmployeeID INT;  
SET @EmployeeID = (SELECT MIN(EmployeeID) FROM Employees);  
WHILE @EmployeeID IS NOT NULL  
BEGIN  
    UPDATE Employees  
    SET Salary = Salary * 1.1  
    WHERE EmployeeID = @EmployeeID;  

    SET @EmployeeID = (SELECT MIN(EmployeeID) FROM Employees WHERE EmployeeID > @EmployeeID);  
END;

-- 25. EXCEPT Customers who placed orders but are not in Invoices  
SELECT DISTINCT CustomerID FROM Orders  
EXCEPT  
SELECT DISTINCT CustomerID FROM Invoices;

-- 26. GROUP BY CustomerID, ProductID, Region for Total Sales  
SELECT CustomerID, ProductID, Region, SUM(SalesAmount) AS TotalSales  
FROM Sales  
GROUP BY CustomerID, ProductID, Region;

-- 27. CASE for Discount based on Quantity  
SELECT ProductID, Quantity,  
       CASE  
           WHEN Quantity >= 100 THEN '30% Discount'  
           WHEN Quantity BETWEEN 50 AND 99 THEN '20% Discount'  
           WHEN Quantity BETWEEN 10 AND 49 THEN '10% Discount'  
           ELSE 'No Discount'  
       END AS Discount  
FROM Orders;

-- 28. UNION and INNER JOIN for stock status  
SELECT P.ProductID, P.ProductName, 'Available' AS Status  
FROM Products P  
INNER JOIN Stock S ON P.ProductID = S.ProductID  
UNION  
SELECT DP.ProductID, DP.ProductName, 'Discontinued' AS Status  
FROM DiscontinuedProducts DP;

-- 29. IIF for Stock Status  
SELECT ProductID, ProductName,  
       IIF(Stock > 0, 'Available', 'Out of Stock') AS StockStatus  
FROM Products;

-- 30. EXCEPT for non-VIP Customers  
SELECT CustomerID FROM Customers  
EXCEPT  
SELECT CustomerID FROM VIP_Customers;
