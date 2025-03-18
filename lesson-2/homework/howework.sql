-- Create the database
CREATE DATABASE HW2;
USE HW2;

-- DDL commands (Data Definition Language) define and manage the database structure
-- Example 1: Create a table
CREATE TABLE homework (
    TaskNumber INT, 
    Def VARCHAR(50)
);

-- Example 2: Alter table to add a new column
ALTER TABLE homework
ADD person_responsible VARCHAR(50);

-- Rename a column
EXEC sp_rename 'homework.TaskNumber', 'TaskID', 'COLUMN';

-- DML commands (Data Manipulation Language) modify data after objects have been created
-- Example 1: Insert data into the table
INSERT INTO homework (TaskID, Def, person_responsible) 
VALUES (35, 'python', 'Sevara'), (37, 'sql', 'Sarah');

-- Example 2: Update a specific record
UPDATE homework
SET TaskID = 80
WHERE Def = 'python';

-- Create Employees table
CREATE TABLE employees (
    EmpID INT PRIMARY KEY, 
    Name VARCHAR(50), 
    Salary DECIMAL(10,2)
);

-- Insert data into Employees table
INSERT INTO employees (EmpID, Name, Salary) 
VALUES (30, 'Alex', 1700.45), (40, 'Bob', 1500.5), (35, 'Daniel', 2010.8);

-- Select all records from Employees table
SELECT * FROM employees;

-- Update a specific employee's salary
UPDATE employees
SET Salary = 5000
WHERE EmpID = 35;

-- Delete a specific employee record
DELETE FROM employees
WHERE EmpID = 40;

-- Explanation of DELETE, TRUNCATE, and DROP:
-- 1. DELETE removes specific records but keeps the table.
-- 2. TRUNCATE removes all records but keeps the table structure.
-- 3. DROP removes the entire table structure permanently.

-- Modify column Name to have a larger size
ALTER TABLE employees 
ALTER COLUMN Name VARCHAR(100);

-- Add a new column Department
ALTER TABLE employees
ADD Department VARCHAR(50);


-- MEDIUM LEVEL TASKS

-- Create Departments table with a foreign key
CREATE TABLE departments (
    DeptID INT PRIMARY KEY, 
    EmpID INT, 
    FOREIGN KEY (EmpID) REFERENCES employees(EmpID)
);

-- Insert data into Departments table using INSERT INTO SELECT
INSERT INTO departments (DeptID, EmpID)
SELECT EmpID, EmpID FROM employees;  -- Ensure DeptID values are unique (modify as needed)

-- Select all records from Departments table
SELECT * FROM departments;

-- Update Department for employees earning more than 5000
UPDATE employees 
SET Department = 'Management' 
WHERE Salary > 5000;  -- The Department column should exist

-- Remove all records from Employees table without deleting its structure
TRUNCATE TABLE employees;

-- VARCHAR vs NVARCHAR explanation:
-- VARCHAR: Stores non-Unicode text (1 byte per character).
-- NVARCHAR: Stores Unicode text (2 bytes per character), useful for international characters.

-- Modify Salary column data type to FLOAT
ALTER TABLE employees 
ALTER COLUMN Salary FLOAT;

-- Drop the Department column from Employees table
ALTER TABLE employees 
DROP COLUMN Department;

-- Copy data from Departments table into a new table
SELECT * INTO copy_table FROM departments;

-- Drop the Departments table
DROP TABLE departments;

