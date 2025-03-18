select 1
-- 1. Join Customers and Orders using INNER JOIN to get CustomerName and OrderDate
SELECT c.CustomerName, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 2. Demonstrate One to One relationship between EmployeeDetails and Employees using INNER JOIN
SELECT e.EmployeeName, ed.EmployeeDetails
FROM Employees e
INNER JOIN EmployeeDetails ed ON e.EmployeeID = ed.EmployeeID;

-- 3. Join Products and Categories to show ProductName and CategoryName using INNER JOIN
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;

-- 4. Show all Customers and corresponding OrderDate using LEFT JOIN between Customers and Orders
SELECT c.CustomerName, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 5. Demonstrate Many to Many relationship between Orders and Products using OrderDetails as an intermediate table
SELECT o.OrderID, p.ProductName
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID;

-- 6. Perform CROSS JOIN between Products and Categories, showing all combinations
SELECT p.ProductName, c.CategoryName
FROM Products p
CROSS JOIN Categories c;

-- 7. Demonstrate One to Many relationship between Customers and Orders using INNER JOIN
SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

-- 8. Filter a CROSS JOIN result where OrderAmount > 500
SELECT p.ProductName, o.OrderID
FROM Products p
CROSS JOIN Orders o
WHERE o.OrderAmount > 500;

-- 9. Use INNER JOIN to join Employees and Departments, showing employee names and department names
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 10. Use ON clause with <> operator to join two tables and return rows where values in columns are not equal
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID <> d.DepartmentID;
-- 11. Demonstrate One to Many relationship by joining Customers and Orders, showing CustomerName and total number of orders
SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

-- 12. Demonstrate Many to Many relationship between Students and Courses, using StudentCourses as intermediate table
SELECT s.StudentName, c.CourseName
FROM Students s
INNER JOIN StudentCourses sc ON s.StudentID = sc.StudentID
INNER JOIN Courses c ON sc.CourseID = c.CourseID;

-- 13. Use CROSS JOIN between Employees and Departments, filter results where Salary > 5000 using WHERE clause
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.Salary > 5000;

-- 14. Demonstrate One to One relationship between Employee and EmployeeDetails, showing employee name and their details
SELECT e.EmployeeName, ed.EmployeeDetails
FROM Employees e
INNER JOIN EmployeeDetails ed ON e.EmployeeID = ed.EmployeeID;

-- 15. Perform INNER JOIN between Products and Suppliers, filter by Supplier 'Supplier A'
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Supplier A';

-- 16. Perform LEFT JOIN between Products and Sales, display all products with their sales quantity
SELECT p.ProductName, COALESCE(s.SalesQuantity, 0) AS SalesQuantity
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID;

-- 17. Join Employees and Departments using WHERE clause, showing employees with salary > 4000 in 'HR' department
SELECT e.EmployeeName, e.Salary, d.DepartmentName
FROM Employees e, Departments d
WHERE e.DepartmentID = d.DepartmentID
AND e.Salary > 4000
AND d.DepartmentName = 'HR';

-- 18. Use >= operator in the ON clause to join two tables and return rows where values meet the condition
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.Salary >= 4000 AND e.DepartmentID = d.DepartmentID;

-- 19. Demonstrate INNER JOIN and use >= operator to find products with price >= 50 and their suppliers
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.Price >= 50;

-- 20. Perform CROSS JOIN between Sales and Regions, filter by sales > 1000
SELECT s.SalesAmount, r.RegionName
FROM Sales s
CROSS JOIN Regions r
WHERE s.SalesAmount > 1000;
-- 21. Demonstrate Many to Many relationship between Authors and Books using AuthorBooks table
SELECT a.AuthorName, b.BookTitle
FROM Authors a
INNER JOIN AuthorBooks ab ON a.AuthorID = ab.AuthorID
INNER JOIN Books b ON ab.BookID = b.BookID;

-- 22. Join Products and Categories using INNER JOIN, and filter for products where CategoryName is not 'Electronics'
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName <> 'Electronics';

-- 23. Perform CROSS JOIN between Orders and Products, filter by quantity > 100
SELECT o.OrderID, p.ProductName
FROM Orders o
CROSS JOIN Products p
WHERE o.Quantity > 100;

-- 24. Join Employees and Departments, use logical operator in the ON clause to return employees who have been with the company for over 5 years
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 25. Show the difference between INNER JOIN and LEFT JOIN for Employees and Departments
-- INNER JOIN: Returns employees with matching departments
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- LEFT JOIN: Returns all employees, including those without departments
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 26. Perform CROSS JOIN between Products and Suppliers, and filter by products in 'Category A'
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s
WHERE p.CategoryName = 'Category A';

-- 27. Demonstrate One to Many relationship using INNER JOIN between Orders and Customers, apply >= operator for customers with at least 10 orders
SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(o.OrderID) >= 10;

-- 28. Demonstrate Many to Many relationship between Courses and Students, showing the count of students per course
SELECT c.CourseName, COUNT(sc.StudentID) AS TotalStudents
FROM Courses c
INNER JOIN StudentCourses sc ON c.CourseID = sc.CourseID
GROUP BY c.CourseName;

-- 29. Use LEFT JOIN between Employees and Departments, filter by 'Marketing' department
SELECT e.EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Marketing';

-- 30. Use ON clause with <= operator to join two tables and return rows where values meet the condition
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.Salary <= 5000 AND e.DepartmentID = d.DepartmentID;
