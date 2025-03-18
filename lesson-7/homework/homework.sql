select 1
-- 1. Minimum price of a product
SELECT MIN(Price) AS MinPrice FROM Products;

-- 2. Maximum Salary from Employees table
SELECT MAX(Salary) AS MaxSalary FROM Employees;

-- 3. Count the number of rows in Customers table
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- 4. Count distinct product categories from Products table
SELECT COUNT(DISTINCT Category) AS TotalCategories FROM Products;

-- 5. Total sales for a particular product in Sales table
SELECT SUM(SalesAmount) AS TotalSales FROM Sales WHERE ProductID = 101;  -- Assuming ProductID 101 is the example

-- 6. Average age of employees
SELECT AVG(Age) AS AverageAge FROM Employees;

-- 7. Count the number of employees in each department
SELECT Department, COUNT(*) AS TotalEmployees FROM Employees GROUP BY Department;

-- 8. Minimum and maximum price of products grouped by category
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice FROM Products GROUP BY Category;

-- 9. Total sales per Region in Sales table
SELECT Region, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY Region;

-- 10. Filter departments with more than 5 employees
SELECT Department, COUNT(*) AS EmployeeCount FROM Employees GROUP BY Department HAVING COUNT(*) > 5;
-- 11. Total and average sales for each product category
SELECT Category, SUM(SalesAmount) AS TotalSales, AVG(SalesAmount) AS AverageSales FROM Sales GROUP BY Category;

-- 12. Count the number of employees with a specific JobTitle
SELECT JobTitle, COUNT(*) AS EmployeeCount FROM Employees WHERE JobTitle = 'Manager' GROUP BY JobTitle;

-- 13. Highest and lowest Salary by department
SELECT Department, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary FROM Employees GROUP BY Department;

-- 14. Average salary per Department
SELECT Department, AVG(Salary) AS AvgSalary FROM Employees GROUP BY Department;

-- 15. Average salary and count of employees per department
SELECT Department, AVG(Salary) AS AvgSalary, COUNT(*) AS EmployeeCount FROM Employees GROUP BY Department;

-- 16. Filter products with average price greater than 100
SELECT ProductID, AVG(Price) AS AvgPrice FROM Products GROUP BY ProductID HAVING AVG(Price) > 100;

-- 17. Count how many products have sales above 100 units
SELECT COUNT(DISTINCT ProductID) AS ProductsAbove100Units FROM Sales WHERE Quantity > 100;

-- 18. Total sales per year
SELECT YEAR(OrderDate) AS Year, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY YEAR(OrderDate);

-- 19. Number of customers who placed orders in each region
SELECT Region, COUNT(DISTINCT CustomerID) AS CustomersInRegion FROM Orders GROUP BY Region;

-- 20. Filter departments with total salary expenses greater than 100,000
SELECT Department, SUM(Salary) AS TotalSalary FROM Employees GROUP BY Department HAVING SUM(Salary) > 100000;
-- 21. Average sales for each product category with HAVING filter
SELECT Category, AVG(SalesAmount) AS AvgSales FROM Sales GROUP BY Category HAVING AVG(SalesAmount) > 200;

-- 22. Total sales for each employee with HAVING filter
SELECT EmployeeID, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY EmployeeID HAVING SUM(SalesAmount) > 5000;

-- 23. Total and average salary of employees grouped by department, filter by avg salary > 6000
SELECT Department, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary FROM Employees GROUP BY Department HAVING AVG(Salary) > 6000;

-- 24. Max and Min order value for each customer, exclude order value < 50
SELECT CustomerID, MAX(OrderValue) AS MaxOrderValue, MIN(OrderValue) AS MinOrderValue FROM Orders GROUP BY CustomerID HAVING MIN(OrderValue) >= 50;

-- 25. Total sales and count distinct products sold in each Region, filter regions with more than 10 products sold
SELECT Region, SUM(SalesAmount) AS TotalSales, COUNT(DISTINCT ProductID) AS DistinctProductsSold
FROM Sales GROUP BY Region HAVING COUNT(DISTINCT ProductID) > 10;

-- 26. Min and Max order quantity per product, grouped by ProductCategory
SELECT ProductCategory, MIN(OrderQuantity) AS MinQuantity, MAX(OrderQuantity) AS MaxQuantity
FROM Orders GROUP BY ProductCategory;

-- 27. Pivot the Sales table by Year and sum of SalesAmount for each Region
SELECT * FROM (
  SELECT Region, YEAR(OrderDate) AS Year, SalesAmount
  FROM Sales
) AS SourceTable
PIVOT (
  SUM(SalesAmount) FOR Year IN ([2020], [2021], [2022], [2023])
) AS PivotTable;

-- 28. Unpivot the Sales table, converting Q1, Q2, Q3, Q4 columns into rows
SELECT Region, Quarter, SalesAmount
FROM (
  SELECT Region, Q1, Q2, Q3, Q4
  FROM Sales
) AS SourceTable
UNPIVOT (
  SalesAmount FOR Quarter IN (Q1, Q2, Q3, Q4)
) AS UnpivotedTable;

-- 29. Count the number of orders per product, filter with HAVING for more than 50 orders, and group by ProductCategory
SELECT ProductCategory, ProductID, COUNT(*) AS OrderCount
FROM Orders GROUP BY ProductCategory, ProductID HAVING COUNT(*) > 50;

-- 30. Pivot the EmployeeSales table, displaying total sales per employee for each quarter (Q1, Q2, Q3, Q4)
SELECT * FROM (
  SELECT EmployeeID, Quarter, SalesAmount
  FROM EmployeeSales
) AS SourceTable
PIVOT (
  SUM(SalesAmount) FOR Quarter IN ([Q1], [Q2], [Q3], [Q4])
) AS PivotedEmployeeSales;
