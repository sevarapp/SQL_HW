select 1
/*
CREATE TABLE Employee (
    Id INT,
    Name VARCHAR(50),
    Salary INT,
    ManagerId INT
);

INSERT INTO Employee (Id, Name, Salary, ManagerId) VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);

CREATE TABLE weather (
    Id INT,
    RecordDate DATE,
    Temperature INT
);

INSERT INTO weather (Id, RecordDate, Temperature) VALUES
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

CREATE TABLE MultipleVals 
(
     Id INT
    ,[Vals] VARCHAR(100)
)
GO
 
 
Insert Into MultipleVals values
 (1,'a,b,c')
,(2,'x,y,z')
GO

CREATE TABLE fruits (
    fruit_list VARCHAR(100)
);

INSERT INTO fruits (fruit_list)
VALUES ('apple,banana,orange,grape');

CREATE TABLE RemoveLastComma
(
     Id INT
    ,Val VARCHAR(100)
)
GO
 
INSERT INTO RemoveLastComma VALUES
(1,'Pawan'),
(2,'Pawan,Avtaar,'),
(3,','),
(4,'Hello,'),
(5,'a,a,b,c,'),
(6,NULL),
(7,'')
GO
CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
GO
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')
GO

CREATE TABLE Splitter
(
     Id INT
    ,Vals VARCHAR(100)
)
GO
 
INSERT INTO Splitter VALUES
(1,'P.K'),
(2,'a.b'),
(3,'c.d'),
(4,'e.J'),
(5,'t.u.b')
GO

CREATE TABLE testDots
(
     ID INT
    ,Vals VARCHAR(100)
)
GO
 
INSERT INTO testDots VALUES
(1,'0.0'),
(2,'2.3.1.1'),
(3,'4.1.a.3.9'),
(4,'1.1.'),
(5,'a.b.b.b.b.b..b..b'),
(6,'6.')
GO

CREATE TABLE GetIntegers
(
     Id INT
    ,VALS VARCHAR(100)
)
GO
 
INSERT INTO GetIntegers VALUES
 (1,'P1')
,(2,'1 - Hero')
,(3,'2 - Ramesh')
,(4,'3 - KrishnaKANT')
,(5,'21 - Avtaar')
,(6,'5Laila')
,(7,'6  MMT')
,(8,'7#7#')
,(9,'#')
,(10,'8')
,(11,'98')
,(12,'111')
,(13,NULL)
GO

CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
GO
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )
GO

CREATE TABLE TestPercent
(
    Strs VARCHAR(100)
)
GO
 
INSERT INTO TestPercent
SELECT 'Pawan'
UNION ALL
SELECT 'Pawan%'
UNION ALL
SELECT 'Pawan%Kumar'
UNION ALL
SELECT '%'
GO

CREATE TABLE [dbo].[TestMultipleColumns]
 
(
 
[Id] [int] NULL,
 
[Name] [varchar](20) NULL
 
)
 
INSERT INTO [TestMultipleColumns] VALUES
 
(1,    'Pawan,Kumar'),
 
(2,    'Sandeep,Goyal'),
 
(3,    'Isha,Mattoo'),
 
(4,    'Gopal,Ranjan'),
 
(5,    'Neeraj,Garg'),
 
(6,    'Deepak,Sharma'),
 
(7,    ' Mayank,Tripathi')
 
GO

CREATE TABLE CountSpaces
(
texts VARCHAR(100)
)
GO
 
INSERT INTO CountSpaces VALUES
('P Q R S '),
(' L M N O 0 0     '),
('I  am here only '),
(' Welcome to the new world '),
(' Hello world program'),
(' Are u nuts ')

create table p1 (id int, code int)
create table p2 (id int, code int)
insert into p1 select 1,0
insert into p1 select 2,1
insert into p2 select 1,5
insert into p2 select 2,5

CREATE TABLE WeekPercentagePuzzle
(
      Area INT
    , [Date] DATE
    , SalesLocal INT
    , SalesRemote INT
    , [DayName] VARCHAR(4)
    , [DayOfWeek] SMALLINT
    , FinancialWeek TINYINT
    , [MonthName] VARCHAR(15)
    , FinancialYear INT
)
GO
 
INSERT INTO WeekPercentagePuzzle VALUES
(1,    '2015-04-01',  0,                  50,                        'Wed',            4,                       1,                        'April',               2015),
(2,   '2015-04-01',   null,              null   ,                   'Wed',           4  ,                      1    ,                     'April',              2015), 
(3,  '2015-04-01',    100 ,             0      ,                    'Wed',           4   ,                      1  ,                      'April',             2015),
(3,  '2015-04-01',   50  ,               100 ,                        'Wed',            4,                        1,                        'April',               2015),
(3,  '2015-04-04',   50  ,              50  ,                          'Sat',             7,                         1,                        'April',              2015)
GO

CREATE TABLE SeperateNumbersAndCharcters
(
    Value VARCHAR(100)
)
GO
 
INSERT INTO SeperateNumbersAndCharcters
VALUES
('dskfsda1224'),
('123'),
('ABC'),
('23874283bsdjfhsjadkhfas09')
GO
 
 
--

*/
/*
Easy Tasks
1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
3.In this puzzle you will have to split a string based on dot(.).(Splitter)
4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
6.Write a SQL query to count the occurrences of a substring within a string in a given column.(Not table)
7.Write a SQL query to count the spaces present in the string.(CountSpaces)
8.write a SQL query that finds out employees who earn more than their managers.(Employee)

Medium Tasks
1.Write a SQL query to separate the integer values and the character values into two different columns.(SeperateNumbersAndCharcters)
2.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
3.Write a SQL query that reports the device that is first logged in for each player.(Activity)
4.Write an SQL query that reports the first login date for each player.(Activity)
5.Your task is to split the string into a list using a specific separator (such as a space, comma, etc.), and then return the third item from that list.(fruits)
6.Write a SQL query to create a table where each character from the string will be converted into a row, with each row having a single column.(sdgfhsdgfhs@121313131)
7.You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
8.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)

Difficult Tasks
1.In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
2.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
3.Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
4.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
5.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
