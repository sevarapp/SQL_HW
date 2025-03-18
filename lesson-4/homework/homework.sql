-- ? Easy-Level Tasks (10)

-- 1. Select the top 5 employees from the Employees table.
SELECT TOP 5 * FROM Employees;

-- 2. Select unique ProductName values from the Products table.
SELECT DISTINCT ProductName FROM Products;

-- 3. Filter the Products table to show products with Price > 100.
SELECT * FROM Products WHERE Price > 100;

-- 4. Select all CustomerName values that start with 'A' using LIKE.
SELECT CustomerName FROM Customers WHERE CustomerName LIKE 'A%';

-- 5. Order the results of a Products query by Price in ascending order.
SELECT * FROM Products ORDER BY Price ASC;

-- 6. Filter employees with Salary >= 5000 and Department = 'HR'.
SELECT * FROM Employees WHERE Salary >= 5000 AND Department = 'HR';

-- 7. Use ISNULL to replace NULL values in the Email column with "noemail@example.com".
SELECT EmployeeID, ISNULL(Email, 'noemail@example.com') AS Email FROM Employees;

-- 8. Show all products with Price BETWEEN 50 AND 100.
SELECT * FROM Products WHERE Price BETWEEN 50 AND 100;

-- 9. Select distinct Category and ProductName from the Products table.
SELECT DISTINCT Category, ProductName FROM Products;

-- 10. Order the results by ProductName in descending order.
SELECT * FROM Products ORDER BY ProductName DESC;

--------------------------------------------------------------

-- ? Medium-Level Tasks (10)

-- 11. Select the top 10 products, ordered by Price DESC.
SELECT TOP 10 * FROM Products ORDER BY Price DESC;

-- 12. Return the first non-NULL value from FirstName or LastName in Employees table.
SELECT EmployeeID, COALESCE(FirstName, LastName) AS Name FROM Employees;

-- 13. Select distinct Category and Price from the Products table.
SELECT DISTINCT Category, Price FROM Products;

-- 14. Filter employees whose Age is between 30 and 40 or Department = 'Marketing'.
SELECT * FROM Employees WHERE (Age BETWEEN 30 AND 40) OR Department = 'Marketing';

-- 15. Select rows 11 to 20 from Employees table, ordered by Salary DESC.
SELECT * FROM Employees ORDER BY Salary DESC OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 16. Display all products with Price <= 1000 and Stock > 50, sorted by Stock ASC.
SELECT * FROM Products WHERE Price <= 1000 AND Stock > 50 ORDER BY Stock ASC;

-- 17. Filter the Products table for ProductName values containing the letter 'e'.
SELECT * FROM Products WHERE ProductName LIKE '%e%';

-- 18. Filter employees who work in 'HR', 'IT', or 'Finance' using IN.
SELECT * FROM Employees WHERE Department IN ('HR', 'IT', 'Finance');

-- 19. Find employees who earn more than the average salary using ANY.
SELECT * FROM Employees WHERE Salary > ANY (SELECT AVG(Salary) FROM Employees);

-- 20. Display customers ordered by City (ASC) and PostalCode (DESC).
SELECT * FROM Customers ORDER BY City ASC, PostalCode DESC;

--------------------------------------------------------------

-- ? Hard-Level Tasks (10)

-- 21. Select the top 10 products with the highest sales, ordered by SalesAmount DESC.
SELECT TOP 10 * FROM Products ORDER BY SalesAmount DESC;

-- 22. Combine FirstName and LastName into one column named FullName.
SELECT EmployeeID, COALESCE(FirstName + ' ' + LastName, FirstName, LastName) AS FullName FROM Employees;

-- 23. Select distinct Category, ProductName, and Price for products priced above $50.
SELECT DISTINCT Category, ProductName, Price FROM Products WHERE Price > 50;

-- 24. Select products whose Price is within 10% of the average price.
SELECT * FROM Products WHERE Price BETWEEN (SELECT AVG(Price) * 0.9 FROM Products) AND (SELECT AVG(Price) * 1.1 FROM Products);

-- 25. Filter employees whose Age is less than 30 and who work in 'HR' or 'IT'.
SELECT * FROM Employees WHERE Age < 30 AND Department IN ('HR', 'IT');

-- 26. Select all customers whose Email contains the domain '@gmail.com'.
SELECT * FROM Customers WHERE Email LIKE '%@gmail.com';

-- 27. Find employees whose salary is greater than all employees in the 'Sales' department using ALL.
SELECT * FROM Employees WHERE Salary > ALL (SELECT Salary FROM Employees WHERE Department = 'Sales');

-- 28. Show employees with the highest salaries, displaying 10 employees at a time (pagination).
SELECT * FROM Employees ORDER BY Salary DESC OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- 29. Filter the Orders table for orders placed in the last 30 days.
SELECT * FROM Orders WHERE OrderDate BETWEEN CURRENT_DATE - INTERVAL 30 DAY AND CURRENT_DATE;

-- 30. Select all employees who earn more than the average salary for their department.
SELECT * FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees E WHERE E.Department = Employees.Department);
