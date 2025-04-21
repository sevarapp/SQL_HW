select 1
-- EASY TASKS

-- 1. Numbers table using recursion
WITH Numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM Numbers WHERE n < 100
)
SELECT * FROM Numbers;

-- 2. Recursive doubling
WITH Doubles AS (
  SELECT 1 AS val
  UNION ALL
  SELECT val * 2 FROM Doubles WHERE val < 1000
)
SELECT * FROM Doubles;

-- 3. Total sales per employee (derived table)
SELECT e.FirstName, e.LastName, dt.TotalSales
FROM Employees e
JOIN (
  SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
  FROM Sales
  GROUP BY EmployeeID
) dt ON e.EmployeeID = dt.EmployeeID;

-- 4. CTE for average salary
WITH AvgSalary AS (
  SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT * FROM AvgSalary;

-- 5. Highest sales per product (derived table)
SELECT p.ProductName, dt.MaxSale
FROM Products p
JOIN (
  SELECT ProductID, MAX(SalesAmount) AS MaxSale
  FROM Sales
  GROUP BY ProductID
) dt ON p.ProductID = dt.ProductID;

-- 6. Employees with more than 5 sales (CTE)
WITH SaleCounts AS (
  SELECT EmployeeID, COUNT(*) AS SaleCount
  FROM Sales
  GROUP BY EmployeeID
)
SELECT e.FirstName, e.LastName
FROM Employees e
JOIN SaleCounts s ON e.EmployeeID = s.EmployeeID
WHERE s.SaleCount > 5;

-- 7. Products with sales > $500 (CTE)
WITH ProductSales AS (
  SELECT ProductID, SUM(SalesAmount) AS TotalSales
  FROM Sales
  GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;

-- 8. Employees with salary above average (CTE)
WITH AvgSal AS (
  SELECT AVG(Salary) AS AvgSalary FROM Employees
)
SELECT *
FROM Employees e
CROSS JOIN AvgSal a
WHERE e.Salary > a.AvgSalary;

-- 9. Total number of products sold (derived table)
SELECT SUM(dt.ProductCount) AS TotalProductsSold
FROM (
  SELECT COUNT(*) AS ProductCount
  FROM Sales
) dt;

-- 10. Employees who made no sales (CTE)
WITH SalesEmployees AS (
  SELECT DISTINCT EmployeeID FROM Sales
)
SELECT FirstName, LastName
FROM Employees
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM SalesEmployees);

-- MEDIUM TASKS

-- 1. Recursive factorials
WITH Factorial (n, fact) AS (
  SELECT 1, 1
  UNION ALL
  SELECT n + 1, (n + 1) * fact
  FROM Factorial
  WHERE n < 10
)
SELECT * FROM Factorial;

-- 2. Recursive Fibonacci
WITH Fibonacci (n, a, b) AS (
  SELECT 1, 0, 1
  UNION ALL
  SELECT n + 1, b, a + b
  FROM Fibonacci
  WHERE n < 20
)
SELECT n, a AS FibonacciNumber FROM Fibonacci;

-- 3. Split string into characters (Example table)
WITH Split (Id, str, pos) AS (
  SELECT Id, String, 1 FROM Example
  UNION ALL
  SELECT Id, str, pos + 1 FROM Split
  WHERE pos < LEN(str)
)
SELECT Id, SUBSTRING(str, pos, 1) AS Char
FROM Split
ORDER BY Id, pos;

-- 4. Rank employees by total sales (CTE)
WITH EmployeeSales AS (
  SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
  FROM Sales
  GROUP BY EmployeeID
)
SELECT e.FirstName, e.LastName, es.TotalSales,
       RANK() OVER (ORDER BY es.TotalSales DESC) AS Rank
FROM EmployeeSales es
JOIN Employees e ON e.EmployeeID = es.EmployeeID;

-- 5. Top 5 employees by number of orders (derived)
SELECT TOP 5 e.FirstName, e.LastName, dt.OrderCount
FROM (
  SELECT EmployeeID, COUNT(*) AS OrderCount
  FROM Sales
  GROUP BY EmployeeID
) dt
JOIN Employees e ON e.EmployeeID = dt.EmployeeID
ORDER BY dt.OrderCount DESC;

-- 6. Sales difference current vs previous month (CTE)
WITH MonthlySales AS (
  SELECT DATEPART(MONTH, SaleDate) AS Month,
         SUM(SalesAmount) AS TotalSales
  FROM Sales
  GROUP BY DATEPART(MONTH, SaleDate)
),
Diffs AS (
  SELECT Month,
         TotalSales - LAG(TotalSales) OVER (ORDER BY Month) AS SalesDifference
  FROM MonthlySales
)
SELECT * FROM Diffs;

-- 7. Sales per product category (derived)
SELECT pr.CategoryID, SUM(s.SalesAmount) AS TotalSales
FROM Sales s
JOIN Products pr ON pr.ProductID = s.ProductID
GROUP BY pr.CategoryID;

-- 8. Rank products based on total sales last year (CTE)
WITH ProductSales AS (
  SELECT ProductID, SUM(SalesAmount) AS TotalSales
  FROM Sales
  WHERE SaleDate >= DATEADD(YEAR, -1, GETDATE())
  GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales,
       RANK() OVER (ORDER BY ps.TotalSales DESC) AS Rank
FROM ProductSales ps
JOIN Products p ON p.ProductID = ps.ProductID;

-- 9. Employees with sales over $5000 per quarter (derived)
SELECT e.FirstName, e.LastName, dt.Quarter, dt.TotalSales
FROM (
  SELECT EmployeeID,
         DATEPART(QUARTER, SaleDate) AS Quarter,
         SUM(SalesAmount) AS TotalSales
  FROM Sales
  GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
  HAVING SUM(SalesAmount) > 5000
) dt
JOIN Employees e ON e.EmployeeID = dt.EmployeeID;

-- 10. Top 3 employees by total sales last month (derived)
SELECT TOP 3 e.FirstName, e.LastName, dt.TotalSales
FROM (
  SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
  FROM Sales
  WHERE SaleDate >= DATEADD(MONTH, -1, GETDATE())
  GROUP BY EmployeeID
) dt
JOIN Employees e ON e.EmployeeID = dt.EmployeeID
ORDER BY dt.TotalSales DESC;

-- DIFFICULT TASKS

-- 1. Numbers and sequences like 1, 12, 123, ...
WITH NumSeq AS (
  SELECT 1 AS n, CAST('1' AS VARCHAR(MAX)) AS numstr
  UNION ALL
  SELECT n + 1, numstr + CAST(n + 1 AS VARCHAR)
  FROM NumSeq
  WHERE n < 5
)
SELECT * FROM NumSeq;

-- 2. Employees with most sales last 6 months
SELECT e.FirstName, e.LastName, dt.TotalSales
FROM (
  SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
  FROM Sales
  WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
  GROUP BY EmployeeID
) dt
JOIN Employees e ON e.EmployeeID = dt.EmployeeID
WHERE dt.TotalSales = (
  SELECT MAX(TotalSales) FROM (
    SELECT SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
  ) x
);

-- 3. Running total that doesn't exceed 10 or go below 0
WITH CTE AS (
  SELECT Id, StepNumber, [Count], [Count] AS RunningTotal
  FROM Numbers
  WHERE StepNumber = 1
  UNION ALL
  SELECT n.Id, n.StepNumber, n.[Count],
         CASE
           WHEN c.RunningTotal + n.[Count] > 10 THEN 10
           WHEN c.RunningTotal + n.[Count] < 0 THEN 0
           ELSE c.RunningTotal + n.[Count]
         END
  FROM Numbers n
  JOIN CTE c ON n.Id = c.Id AND n.StepNumber = c.StepNumber + 1
)
SELECT * FROM CTE
ORDER BY Id, StepNumber;

-- 4. Merge schedule with activity and fill gaps with "Work"
WITH AllTimes AS (
  SELECT ScheduleID, StartTime, EndTime, ActivityName
  FROM Activity
  UNION
  SELECT s.ScheduleID, s.StartTime, a.StartTime, 'Work'
  FROM Schedule s
  LEFT JOIN Activity a ON s.ScheduleID = a.ScheduleID
  WHERE s.StartTime < a.StartTime
  UNION
  SELECT s.ScheduleID, a.EndTime, s.EndTime, 'Work'
  FROM Schedule s
  LEFT JOIN Activity a ON s.ScheduleID = a.ScheduleID
  WHERE s.EndTime > a.EndTime
)
SELECT * FROM AllTimes
ORDER BY ScheduleID, StartTime;

-- 5. CTE + derived table for sales totals per department and product
WITH DepartmentSales AS (
  SELECT e.DepartmentID, s.ProductID, SUM(s.SalesAmount) AS TotalSales
  FROM Sales s
  JOIN Employees e ON s.EmployeeID = e.EmployeeID
  GROUP BY e.DepartmentID, s.ProductID
)
SELECT d.DepartmentName, p.ProductName, ds.TotalSales
FROM DepartmentSales ds
JOIN Departments d ON ds.DepartmentID = d.DepartmentID
JOIN Products p ON ds.ProductID = p.ProductID;
