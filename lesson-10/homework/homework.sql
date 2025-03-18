

-- 1. INNER JOIN between Orders and Customers, filtering orders placed after 2022
SELECT o.OrderID, c.CustomerName, o.OrderDate
FROM Orders o
INNER JOIN Customers c 
    ON o.CustomerID = c.CustomerID AND o.OrderDate > '2022-01-01';

-- 2. Join Employees and Departments using OR in the ON clause
SELECT e.EmployeeID, e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID AND (d.DepartmentName = 'Sales' OR d.DepartmentName = 'Marketing');

-- 3. Join a derived table (high-priced products) with Orders
SELECT p.ProductName, o.OrderID, o.OrderDate
FROM (SELECT * FROM Products WHERE Price > 100) p
JOIN Orders o ON p.ProductID = o.ProductID;

-- 4. Join a Temp table (Temp_Orders) and Orders to find common orders
SELECT t.OrderID, o.OrderDate
FROM Temp_Orders t
INNER JOIN Orders o ON t.OrderID = o.OrderID;

-- 5. CROSS APPLY to show top 5 sales in each department
SELECT e.EmployeeID, e.EmployeeName, d.DepartmentName, s.SaleAmount
FROM Employees e
CROSS APPLY (
    SELECT TOP 5 SaleAmount 
    FROM Sales s 
    WHERE s.EmployeeID = e.EmployeeID 
    ORDER BY SaleAmount DESC
) s
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 6. Join Customers and Orders using AND to filter Gold customers with 2023 orders
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM Customers c
INNER JOIN Orders o 
    ON c.CustomerID = o.CustomerID AND o.OrderDate >= '2023-01-01' AND c.LoyaltyStatus = 'Gold';

-- 7. Join a derived table (Orders per Customer) with Customers
SELECT c.CustomerName, order_count.TotalOrders
FROM Customers c
JOIN (
    SELECT CustomerID, COUNT(*) AS TotalOrders 
    FROM Orders 
    GROUP BY CustomerID
) order_count 
    ON c.CustomerID = order_count.CustomerID;

-- 8. Join Products and Suppliers using OR in the ON clause
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID AND (s.SupplierName = 'Supplier A' OR s.SupplierName = 'Supplier B');

-- 9. OUTER APPLY to get each employee’s most recent order
SELECT e.EmployeeID, e.EmployeeName, recent_order.OrderDate
FROM Employees e
OUTER APPLY (
    SELECT TOP 1 o.OrderDate 
    FROM Orders o 
    WHERE o.EmployeeID = e.EmployeeID 
    ORDER BY o.OrderDate DESC
) recent_order;

-- 10. CROSS APPLY with a table-valued function to get employees per department
SELECT d.DepartmentName, emp.EmployeeName
FROM Departments d
CROSS APPLY dbo.GetEmployeesByDepartment(d.DepartmentID) emp;

-- 11. Find customers who placed orders > 5000
SELECT o.OrderID, c.CustomerName, o.TotalAmount
FROM Orders o
JOIN Customers c 
    ON o.CustomerID = c.CustomerID AND o.TotalAmount > 5000;

-- 12. Join Products and Sales filtering sales in 2022 or discount > 20%
SELECT p.ProductName, s.SaleDate, s.Discount
FROM Products p
JOIN Sales s 
    ON p.ProductID = s.ProductID AND (s.SaleDate >= '2022-01-01' OR s.Discount > 20);

-- 13. Join total sales per product with Products
SELECT p.ProductName, sales_summary.TotalSales
FROM Products p
JOIN (
    SELECT ProductID, SUM(Amount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) sales_summary
ON p.ProductID = sales_summary.ProductID;

-- 14. Join a Temp table (Temp_Products) and Products for discontinued products
SELECT t.ProductID, p.ProductName
FROM Temp_Products t
JOIN Products p
ON t.ProductID = p.ProductID AND p.Discontinued = 1;

-- 15. CROSS APPLY for employee sales performance
SELECT e.EmployeeName, sales.PerformanceRating
FROM Employees e
CROSS APPLY dbo.GetSalesPerformance(e.EmployeeID) sales;

-- 16. Join Employees and Departments filtering HR employees with salary > 5000
SELECT e.EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID AND d.DepartmentName = 'HR' AND e.Salary > 5000;

-- 17. Join Orders and Payments showing fully or partially paid orders
SELECT o.OrderID, p.PaymentStatus
FROM Orders o
JOIN Payments p 
    ON o.OrderID = p.OrderID AND (p.PaymentStatus = 'Full' OR p.PaymentStatus = 'Partial');

-- 18. OUTER APPLY to get customers with their latest order
SELECT c.CustomerID, c.CustomerName, latest_order.OrderID
FROM Customers c
OUTER APPLY (
    SELECT TOP 1 o.OrderID 
    FROM Orders o 
    WHERE o.CustomerID = c.CustomerID 
    ORDER BY o.OrderDate DESC
) latest_order;

-- 19. Join Products and Sales filtering products sold in 2023 with rating > 4
SELECT p.ProductName, s.SaleDate, p.Rating
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID AND s.SaleDate >= '2023-01-01' AND p.Rating > 4;

-- 20. Join Employees and Departments using OR in the ON clause
SELECT e.EmployeeID, e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d 
ON e.DepartmentID = d.DepartmentID AND (d.DepartmentName = 'Sales' OR e.JobTitle LIKE '%Manager%');

-- 21. Orders from New York customers with more than 10 orders
SELECT o.OrderID, c.CustomerName, c.City, order_count.TotalOrders
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID AND c.City = 'New York'
JOIN (
    SELECT CustomerID, COUNT(*) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(*) > 10
) order_count ON c.CustomerID = order_count.CustomerID;

-- 22. Products in 'Electronics' or discount > 15%
SELECT p.ProductName, s.Discount, p.Category
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID AND (p.Category = 'Electronics' OR s.Discount > 15);

-- 23. Count of products per category
SELECT c.CategoryName, prod_count.TotalProducts
FROM Categories c
JOIN (
    SELECT CategoryID, COUNT(*) AS TotalProducts
    FROM Products
    GROUP BY CategoryID
) prod_count ON c.CategoryID = prod_count.CategoryID;

-- 24. Temp_Employees join with complex conditions
SELECT e.EmployeeID, e.EmployeeName, e.Salary, d.DepartmentName
FROM Temp_Employees t
JOIN Employees e ON t.EmployeeID = e.EmployeeID AND e.Salary > 4000
JOIN Departments d ON e.DepartmentID = d.DepartmentID AND d.DepartmentName = 'IT';

-- 25. CROSS APPLY for employee count per department
SELECT d.DepartmentName, emp_count.EmployeeCount
FROM Departments d
CROSS APPLY dbo.GetEmployeeCountByDepartment(d.DepartmentID) emp_count;

-- 26. Orders from California with amount > 1000
SELECT o.OrderID, c.CustomerName, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID AND c.State = 'California' AND o.TotalAmount > 1000;

-- 27. Employees in HR/Finance or Executives
SELECT e.EmployeeName, d.DepartmentName, e.JobTitle
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID AND (d.DepartmentName IN ('HR', 'Finance') OR e.JobTitle LIKE '%Executive%');

-- 28. OUTER APPLY to get all orders per customer (including those with no orders)
SELECT c.CustomerName, orders.OrderID, orders.OrderDate
FROM Customers c
OUTER APPLY (
    SELECT o.OrderID, o.OrderDate
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
) orders;

-- 29. Products with sales quantity > 100 and price > 50
SELECT p.ProductName, s.Quantity, p.Price
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID AND s.Quantity > 100 AND p.Price > 50;

-- 30. Employees in Sales/Marketing with salary > 6000
SELECT e.EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID AND (d.DepartmentName IN ('Sales', 'Marketing') AND e.Salary > 6000);

