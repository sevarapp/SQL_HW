
create database hw_19
use hw_19

CREATE TABLE #Employees ( EmployeeID INT PRIMARY KEY, FirstName VARCHAR(50), LastName VARCHAR(50), DepartmentID INT, Salary DECIMAL(10, 2), HireDate DATE );

INSERT INTO #Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate) VALUES (1, 'John', 'Doe', 1, 60000, '2020-01-15'), (2, 'Jane', 'Smith', 2, 70000, '2019-03-22'), (3, 'Emily', 'Johnson', 1, 65000, '2021-05-18'), (4, 'Michael', 'Williams', 3, 80000, '2018-06-30'), (5, 'Chris', 'Jones', 2, 72000, '2022-02-11'), (6, 'Katie', 'Brown', 3, 61000, '2020-12-01'), (7, 'Sarah', 'Davis', 1, 58000, '2023-01-25'), (8, 'David', 'Miller', 2, 75000, '2017-04-17'), (9, 'Laura', 'Wilson', 3, 69000, '2019-08-08'), (10, 'Mark', 'Moore', 1, 62000, '2022-03-05'), (11, 'Lisa', 'Taylor', 2, 73000, '2018-09-10'), (12, 'James', 'Anderson', 3, 72000, '2021-07-15'), (13, 'Nancy', 'Thomas', 1, 64000, '2020-05-30'), (14, 'Robert', 'Jackson', 2, 68000, '2019-11-20'), (15, 'Patricia', 'White', 3, 69000, '2018-10-01'), (16, 'Charles', 'Harris', 1, 55000, '2023-02-28'), (17, 'Jessica', 'Martinez', 2, 70000, '2021-06-20'), (18, 'Daniel', 'Thompson', 3, 67000, '2017-07-14'), (19, 'Matthew', 'Garcia', 1, 64000, '2022-04-25'), (20, 'Danielle', 'Martinez', 2, 71000, '2020-03-12'), (21, 'Paul', 'Robinson', 3, 78000, '2018-05-03'), (22, 'Michelle', 'Clark', 1, 50000, '2023-03-10'), (23, 'Joseph', 'Rodriguez', 2, 74000, '2021-02-09'), (24, 'Angela', 'Lewis', 3, 66000, '2017-08-14'), (25, 'Thomas', 'Lee', 1, 73000, '2022-01-19'), (26, 'Rebecca', 'Walker', 2, 79000, '2019-12-12'), (27, 'Scott', 'Hall', 3, 72000, '2022-06-11'), (28, 'Betty', 'Allen', 1, 52000, '2023-01-28'), (29, 'Andrew', 'Young', 2, 66000, '2021-05-15'), (30, 'Arthur', 'Hernandez', 3, 71000, '2018-09-22'), (31, 'Brittany', 'King', 1, 64000, '2020-10-05'), (32, 'Jacqueline', 'Wright', 2, 70000, '2019-11-29'), (33, 'Kelly', 'Scott', 3, 64000, '2019-08-16'), (34, 'Gary', 'Torres', 1, 68000, '2020-07-13'), (35, 'Sara', 'Nguyen', 2, 71000, '2021-04-24'), (36, 'Albert', 'Hernandez', 3, 75000, '2019-06-20'), (37, 'Samantha', 'Carter', 1, 49000, '2023-01-15'), (38, 'Steve', 'Mitchell', 2, 77000, '2018-12-01'), (39, 'Brandon', 'Perez', 3, 71000, '2020-09-11'), (40, 'Deborah', 'Roberts', 1, 56000, '2019-10-22'), (41, 'Laura', 'Turner', 2, 64000, '2021-05-04'), (42, 'Philip', 'Phillips', 3, 69000, '2018-08-30'), (43, 'Tina', 'Campbell', 1, 62000, '2020-11-07'), (44, 'Greg', 'Parker', 2, 68000, '2022-03-14'), (45, 'Dennis', 'Evans', 3, 71000, '2021-01-01'), (46, 'Rose', 'Edwards', 1, 74000, '2020-09-05'), (47, 'Rachel', 'Collins', 2, 78000, '2018-06-01'), (48, 'Jordan', 'Stewart', 3, 70000, '2021-07-20'), (49, 'Christine', 'Sanchez', 1, 61000, '2019-02-18'), (50, 'Carlos', 'Morris', 2, 90000, '2022-05-27');

CREATE TABLE #Departments ( DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50), Location VARCHAR(50) );

INSERT INTO #Departments (DepartmentID, DepartmentName, Location) VALUES (1, 'Sales', 'New York'), (2, 'Engineering', 'San Francisco'), (3, 'Marketing', 'Chicago'), (4, 'Purchasing', 'Los Angeles'), (5, 'Finance', 'Miami');

select * from #Employees
select * from #Departments
--Retrieve Employees with Salary Greater than Average Salary
SELECT * 
FROM #Employees
WHERE Salary > (SELECT AVG(Salary) FROM #Employees);

--Write a query to check if there are any employees in Department 1 using the EXISTS clause
IF EXISTS (SELECT 1 FROM #Employees WHERE DepartmentID = 1)
    PRINT 'There are employees in Department 1';
ELSE
    PRINT 'No employees in Department 1';

--Write a query to return employees who work at the same department with Rachel Collins
SELECT * 
FROM #Employees 
WHERE DepartmentID = (
    SELECT DepartmentID 
    FROM #Employees 
    WHERE FirstName = 'Rachel' AND LastName = 'Collins'
);

--Retrieve employees who were hired after the last hired person for the department 2
SELECT * 
FROM #Employees 
WHERE HireDate > (
    SELECT MAX(HireDate) 
    FROM #Employees 
    WHERE DepartmentID = 2
);

--Find all employees whose salary is higher than the average salary of their respective department
SELECT * 
FROM #Employees E
WHERE Salary > (
    SELECT AVG(Salary) 
    FROM #Employees 
    WHERE DepartmentID = E.DepartmentID
);

--Write a query to get the count of employees in each department using a subquery. Return the result right after each employee
SELECT E.*, 
    (SELECT COUNT(*) FROM #Employees WHERE DepartmentID = E.DepartmentID) AS DeptEmployeeCount
FROM #Employees E;

--Find the person who gets the minimum salary
SELECT * 
FROM #Employees
WHERE Salary = (SELECT MIN(Salary) FROM #Employees);

--Find all employees who work in departments where the average salary is greater than $65,000
SELECT * 
FROM #Employees E
WHERE E.DepartmentID IN (
    SELECT DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    HAVING AVG(Salary) > 65000
);

--List employees who were hired in the last 3 years from the last hire_date
SELECT * 
FROM #Employees
WHERE DATEDIFF(YEAR, HireDate, (SELECT MAX(HireDate) FROM #Employees)) <= 3;

--If there is anyone earning more than or equal to $80000, return all employees from that department
SELECT * 
FROM #Employees
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM #Employees 
    WHERE Salary >= 80000
);

--Return the employees who earn the most in each department
SELECT * 
FROM #Employees E
WHERE Salary = (
    SELECT MAX(Salary) 
    FROM #Employees 
    WHERE DepartmentID = E.DepartmentID
);

--Get the names of the latest hired employee in each deparmtent. Return Departmentname, Firstname, Lastname, and hire date
SELECT D.DepartmentName, E.FirstName, E.LastName, E.HireDate
FROM #Employees E
JOIN #Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.HireDate = (
    SELECT MAX(HireDate) 
    FROM #Employees 
    WHERE DepartmentID = E.DepartmentID
);

--Find the average salary for employees in each department based on its location. Return the Location, DepartmentName, and AverageSalary
SELECT D.Location, D.DepartmentName, AVG(E.Salary) AS AverageSalary
FROM #Employees E
JOIN #Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.Location, D.DepartmentName;

--Check if there is anyone who gets the same as the average salary. If so, return everyone from that department
SELECT * 
FROM #Employees 
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    HAVING COUNT(*) > 1 AND AVG(Salary) IN (SELECT Salary FROM #Employees)
);

--List all departments that have fewer employees than the overall average number of employees per department.
SELECT D.*
FROM #Departments D
WHERE D.DepartmentID IN (
    SELECT DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    HAVING COUNT(*) < (
        SELECT AVG(CAST(DeptCount AS FLOAT))
        FROM (
            SELECT DepartmentID, COUNT(*) AS DeptCount
            FROM #Employees 
            GROUP BY DepartmentID
        ) AS AvgDept
    )
);

--Retrieve the names of employees who do not work in the department with the highest average salary.
SELECT * 
FROM #Employees
WHERE DepartmentID <> (
    SELECT TOP 1 DepartmentID
    FROM #Employees 
    GROUP BY DepartmentID 
    ORDER BY AVG(Salary) DESC
);

--Create a query that returns the names of departments that do have employees using the EXISTS clause
SELECT * 
FROM #Departments D
WHERE EXISTS (
    SELECT 1 
    FROM #Employees E 
    WHERE E.DepartmentID = D.DepartmentID
);

--Return departments which have more seniors than juniors. Juniors are those who have work experience less than 3 years, seniors more than 3 years. Consider the latest hire_date to calculate the years of experience
-- Step 1: Store the max hire date
DECLARE @MaxHireDate DATE = (SELECT MAX(HireDate) FROM #Employees);

-- Step 2: Use it in the query
SELECT DepartmentID
FROM #Employees
GROUP BY DepartmentID
HAVING SUM(CASE WHEN DATEDIFF(YEAR, HireDate, @MaxHireDate) > 3 THEN 1 ELSE 0 END) >
       SUM(CASE WHEN DATEDIFF(YEAR, HireDate, @MaxHireDate) < 3 THEN 1 ELSE 0 END);

--Return employees of the department with the most number of people
SELECT * 
FROM #Employees
WHERE DepartmentID = (
    SELECT TOP 1 DepartmentID 
    FROM #Employees 
    GROUP BY DepartmentID 
    ORDER BY COUNT(*) DESC
);

--For each department, find the difference between the highest and lowest salaries 

SELECT DepartmentID, MAX(Salary) - MIN(Salary) AS SalaryRange
FROM #Employees
GROUP BY DepartmentID;


CREATE TABLE Projects ( ProjectID INT PRIMARY KEY, ProjectName VARCHAR(100), StartDate DATE, EndDate DATE, Budget DECIMAL(10, 2) );

CREATE TABLE Employees ( EmployeeID INT PRIMARY KEY, FirstName VARCHAR(50), LastName VARCHAR(50), HireDate DATE, Salary DECIMAL(10, 2) );

CREATE TABLE EmployeeProject ( EmployeeProjectID INT PRIMARY KEY, EmployeeID INT, ProjectID INT, Role VARCHAR(50), FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID), FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) );

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, Budget) VALUES (1, 'Project Alpha', '2020-01-01', '2020-12-31', 100000), (2, 'Project Beta', '2021-01-01', '2021-12-31', 150000), (3, 'Project Gamma', '2022-01-01', '2022-12-31', 200000), (4, 'Project Delta', '2021-06-01', '2022-05-31', 250000), (5, 'Project Epsilon', '2023-01-01', '2023-12-31', 300000);

INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate, Salary) VALUES (1, 'John', 'Doe', '2019-01-15', 80000), (2, 'Jane', 'Smith', '2018-03-22', 95000), (3, 'Emily', 'Johnson', '2021-05-18', 70000), (4, 'Michael', 'Williams', '2020-06-30', 60000), (5, 'Chris', 'Jones', '2022-02-11', 85000), (6, 'Sarah', 'Davis', '2020-12-01', 75000), (7, 'David', 'Miller', '2019-04-17', 90000), (8, 'Laura', 'Wilson', '2021-08-08', 70000), (9, 'Robert', 'Clark', '2021-01-01', 72000), (10, 'Michelle', 'Lee', '2022-05-01', 88000);

INSERT INTO EmployeeProject (EmployeeProjectID, EmployeeID, ProjectID, Role) VALUES (1, 1, 1, 'Lead'), (2, 2, 1, 'Member'), (3, 3, 2, 'Lead'), (4, 4, 2, 'Member'), (5, 5, 3, 'Member'), (6, 6, 3, 'Lead'), (7, 7, 4, 'Member'), (8, 8, 4, 'Member'), (9, 9, 5, 'Lead'), (10, 10, 5, 'Member'); 


--Find all project names that have no employees assigned as leads. Return the ProjectName.
SELECT ProjectName
FROM Projects
WHERE ProjectID NOT IN (
    SELECT ProjectID
    FROM EmployeeProject
    WHERE Role = 'Lead'
);

--Retrieve names of employees who earn more than the average salary of all employees involved in the projects they are working on. Return FirstName, LastName, Salary
SELECT e.FirstName, e.LastName, e.Salary
FROM Employees e
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM EmployeeProject ep2
    JOIN Employees e2 ON ep2.EmployeeID = e2.EmployeeID
    WHERE ep2.ProjectID IN (
        SELECT ep.ProjectID
        FROM EmployeeProject ep
        WHERE ep.EmployeeID = e.EmployeeID
    )
);

--List all projects where there is only one member is assigned
SELECT p.ProjectName
FROM Projects p
JOIN EmployeeProject ep ON p.ProjectID = ep.ProjectID
GROUP BY p.ProjectID, p.ProjectName
HAVING COUNT(ep.EmployeeID) = 1;

--Find the project with the highest budget and show the difference of it with other projects
WITH BudgetCTE AS (
    SELECT ProjectID, ProjectName, Budget,
           MAX(Budget) OVER () AS MaxBudget
    FROM Projects
)
SELECT ProjectName,
       MaxBudget - Budget AS BudgetDifference
FROM BudgetCTE
WHERE Budget <> MaxBudget;

--Identify projects where the total salary of employees assigned as leads exceeds the average salary of all lead employees across all projects 
-- Step 1: Calculate average salary of leads
WITH AvgLeadSalary AS (
    SELECT AVG(e.Salary) AS AvgSalary
    FROM EmployeeProject ep
    JOIN Employees e ON ep.EmployeeID = e.EmployeeID
    WHERE ep.Role = 'Lead'
),
LeadSalaries AS (
    SELECT ep.ProjectID, SUM(e.Salary) AS TotalLeadSalary
    FROM EmployeeProject ep
    JOIN Employees e ON ep.EmployeeID = e.EmployeeID
    WHERE ep.Role = 'Lead'
    GROUP BY ep.ProjectID
)
SELECT p.ProjectName
FROM Projects p
JOIN LeadSalaries ls ON p.ProjectID = ls.ProjectID
CROSS JOIN AvgLeadSalary als
WHERE ls.TotalLeadSalary > als.AvgSalary;
