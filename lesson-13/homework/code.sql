
-- 1️⃣ **Extract a Substring** → Extract the first **4** characters from **'DATABASE'**.  
select substring('DATABASE',1,4)
-- 2️⃣ **Find Position of a Word** → Find position of **'SQL'** in **'I love SQL Server'**.  
select CHARINDEX('SQL','I love SQL Server')
-- 3️⃣ **Replace a Word** → Replace **'World'** with **'SQL'** in **'Hello World'**.  
select replace('Hello World','World','SQL')
-- 4️⃣ **Find String Length** → Find length of **'Microsoft SQL Server'**.  
select len('Microsoft SQL Server')
-- 5️⃣ **Extract Last 3 Characters** → Get last **3** characters from **'Database'**.  
select(RIGHT('Database',3))
-- 6️⃣ **Count a Character** → Count occurrences of **'a'** in **'apple', 'banana', 'grape'**.  
SELECT word,LEN(word) - LEN(REPLACE(word, 'a', '')) AS A_Count
FROM (VALUES ('apple'),('banana'),('grape')) AS Words(word);
-- 7️⃣ **Remove Part of a String** → Remove first **5** characters from **'abcdefg'**.  
SELECT SUBSTRING('abcdefg', 6, LEN('abcdefg')) AS Result;
-- 8️⃣ **Extract a Word** → Extract second word from **'SQL is powerful', 'I love databases'**.  
SELECT sentence, SUBSTRING(sentence, CHARINDEX(' ', sentence) + 1,CHARINDEX(' ', sentence + ' ', 
CHARINDEX(' ', sentence) + 1) - CHARINDEX(' ', sentence) - 1) AS SecondWord
FROM (VALUES ('SQL is powerful'),('I love databases')) AS Sentences(sentence);

-- 9️⃣ **Round a Number** → Round **15.6789** to **2 decimal places**.
select ROUND(15.6789,2)  
-- 🔟 **Absolute Value** → Find absolute value of **-345.67**.  
select abs (-345.67)
-- ---  

-- ## 🏆 Intermediate Level (10 Puzzles)  
-- 1️⃣1️⃣ **Find Middle Characters** → Extract middle **3** characters from **'ABCDEFGHI'**.  
SELECT SUBSTRING('ABCDEFGHI', (LEN('ABCDEFGHI') / 2), 3) AS Middle3;

-- 1️⃣2️⃣ **Replace Part of String** → Replace first **3** chars of **'Microsoft'** with **'XXX'**.  
SELECT replicate('X',3)+ right('Microsoft',len('Microsoft')-3)
-- 1️⃣3️⃣ **Find First Space** → Find position of first **space** in **'SQL Server 2025'**.  
select charindex(' ', 'SQL Server 2025')

-- 1️⃣4️⃣ **Concatenate Names** → Join **FirstName** & **LastName** with **', '**.  
select CONCAT('Firstname',',' ,'Lastname')
-- 1️⃣5️⃣ **Find Nth Word** → Extract **third word** from **'The database is very efficient'**.  
WITH SplitWords AS (
    SELECT 
        value AS Word,
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS WordPosition
    FROM STRING_SPLIT('The database is very efficient', ' ')
)
SELECT Word
FROM SplitWords
WHERE WordPosition = 3;

-- 1️⃣6️⃣ **Extract Only Numbers** → Get numeric part from **'INV1234', 'ORD5678'**.  
SELECT SUBSTRING(code, 4, LEN(code)) AS OnlyNumbers
FROM (VALUES ('INV1234'), ('ORD5678') ) AS Orders(code);

-- 1️⃣7️⃣ **Round to Nearest Integer** → Round **99.5** to the nearest integer.  
SELECT ROUND(99.5, 0) AS RoundedResult;


-- 1️⃣8️⃣ **Find Day Difference** → Days between **'2025-01-01'** & **'2025-03-15'**.  
select datediff(day,'2025-01-01','2025-03-15')
-- 1️⃣9️⃣ **Find Month Name** → Retrieve month name from **'2025-06-10'**.  
select datename(month,'2025-06-10')
-- 2️⃣0️⃣ **Calculate Week Number** → Week number for **'2025-04-22'**.  
select DATEPART(week,'2025-04-2')
-- ---  

-- ## 🚀 Advanced Level (10 Puzzles)  
-- 2️⃣1️⃣ **Extract After '@'** → Extract domain from **'user1@gmail.com', 'admin@company.org'**.  
SELECT 
    Email,
    SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS Domain
FROM (VALUES 
    ('user1@gmail.com'), 
    ('admin@company.org')
) AS Emails(Email);

-- 2️⃣2️⃣ **Find Last Occurrence** → Last **'e'** in **'experience'**.  
SELECT 
    LEN('experience') - CHARINDEX('e', REVERSE('experience')) + 1 AS LastEPosition;

-- 2️⃣3️⃣ **Generate Random Number** → Random number **between 100-500**.  
SELECT FLOOR(RAND() * (500 - 100 + 1)) + 100 AS RandomNumber;

-- 2️⃣4️⃣ **Format with Commas** → Format **9876543** as **"9,876,543"**.  
SELECT FORMAT(9876543, 'N0')
-- 2️⃣5️⃣ **Extract First Name** → Get first name from **CREATE TABLE Customers (FullName VARCHAR(100)); INSERT INTO Customers VALUES ('John Doe'), ('Jane Smith')**. 
SELECT 
    FullName,
    SUBSTRING(FullName, 1, CHARINDEX(' ', FullName) - 1) AS FirstName
FROM (VALUES 
    ('John Doe'), 
    ('Jane Smith')
) AS Customers(FullName); 
-- 2️⃣6️⃣ **Replace Spaces with Dashes** → Change **'SQL Server is great'** → **'SQL-Server-is-great'**.  
SELECT REPLACE('SQL Server is great', ' ', '-') 
-- 2️⃣7️⃣ **Pad with Zeros** → Convert **42** to **'00042'** (5-digit).  
SELECT RIGHT('00000' + CAST(42 AS VARCHAR), 5) AS ZeroPadded;
-- 2️⃣8️⃣ **Find Longest Word Length** → Longest word in **'SQL is fast and efficient'**.  
SELECT MAX(LEN(value)) AS LongestLength
FROM STRING_SPLIT('SQL is fast and efficient', ' ');
-- 2️⃣9️⃣ **Remove First Word** → Remove first word from **'Error: Connection failed'**. Output: **: Connection failed'** 
SELECT 
    SUBSTRING(msg, CHARINDEX(' ', msg), LEN(msg)) AS RemovedFirstWord
FROM (VALUES ('Error: Connection failed')) AS Messages(msg);
-- 3️⃣0️⃣ **Find Time Difference** → Minutes between **'08:15:00'** & **'09:45:00'**.  
SELECT DATEDIFF(MINUTE, '08:15:00', '09:45:00') AS MinutesDifference;

