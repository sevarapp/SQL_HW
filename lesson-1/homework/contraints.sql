create DATABASE HomeworkDB
create table Students (StudentID int,FullName varchar(50) ,Age int, GPA decimal(3,2))
Alter table Students
add Email varchar(50)
EXEC sp_rename 'Students.FullName', 'Name', 'COLUMN';
Alter table Students
drop column age
truncate table students
select * from Students
