
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;


SELECT s.StudentName, c.ClassName
FROM Students s
LEFT JOIN Classes c ON s.ClassID = c.ClassID;


SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

--Task 4: FULL OUTER JOIN

SELECT p.ProductName, s.Quantity
FROM Products p
FULL OUTER JOIN Sales s ON p.ProductID = s.ProductID;


--  Task 5: SELF JOIN

SELECT e.Name AS EmployeeName, m.Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;


--  Task 6: CROSS JOIN

SELECT c.ColorName, s.SizeName
FROM Colors c
CROSS JOIN Sizes s;


--  Task 7: Join with WHERE Clause

SELECT m.Title, a.Name AS ActorName
FROM Movies m
INNER JOIN Actors a ON m.MovieID = a.MovieID
WHERE m.ReleaseYear > 2015;


-- 8
SELECT o.OrderDate, c.CustomerName, od.ProductID
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID;

-- 9
SELECT p.ProductName, SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales s
INNER JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;
