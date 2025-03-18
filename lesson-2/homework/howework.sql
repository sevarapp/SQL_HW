select 1
create database HW2
use HW2
--DDL commands that define and manage database
example1: create table homework( taskname int, def varchar(50))
example2: alter table homework
add person_responsible varchar(50)

exec sp_rename 'homework.taskname','Tasknumber', 'Column';
select * from homework

--Data Manipulation Language make changes after objects have been set
example1: insert into homework values (35,'python','sevara'),(37,'sql','sarah')
example2: UPDATE homework
set tasknumber= 80
where def='python'

create table employees (EmpID INT PRIMARY KEY, Name VARCHAR(50), Salary DECIMAL(10,2))
insert into employees VALUES (30,'Alex',1700.45),(40,'bob',1500.5),(35,'daniel',2010.8)

select * from employees
update employees
set salary=5000
where EmpID=35

delete from employees
where EmpID=40

--truncate deletes all the rows keeping the object/table format, table can be reused
--delete gives a choice, what to delete if used with where operation
--drop deletes the object entirely

Alter table  employees alter column  name VARCHAR(100)
alter TABLE employees
add department varchar(50)


--Medium
create table departments (deptid int PRIMARY key, EmpID int ,foreign key (Empid) REFERENCES employees (EmpID) )

INSERT INTO Departments
SELECT salary, EmpID FROM Employees

select * from departments
UPDATE Employees SET Department = 'Management' WHERE Salary > 5000; --however I don't have this kind of column (department)
TRUNCATE TABLE Employees;
--VARCHAR: Stores non-Unicode text (1 byte per character).
--NVARCHAR: Stores Unicode text (2 bytes per character), useful for international characters.

alter table employees
alter column salary float 

alter table employees
drop column department

select into copy.table from departments

drop table departments

