 -- 1. Split Name and Surname
SELECT Id,
       LTRIM(RTRIM(LEFT(Name, CHARINDEX(',', Name) - 1))) AS FirstName,
       LTRIM(RTRIM(RIGHT(Name, LEN(Name) - CHARINDEX(',', Name)))) AS LastName
FROM TestMultipleColumns;

-- 2. Find strings containing %
SELECT * FROM TestPercent
WHERE Strs LIKE '%[%]%';

-- 3. Split string based on dot (first and second part)
SELECT Id,
       LEFT(Vals, CHARINDEX('.', Vals) - 1) AS FirstPart,
       RIGHT(Vals, LEN(Vals) - CHARINDEX('.', Vals)) AS SecondPart
FROM Splitter;

-- 4. Replace all digits with 'X'
SELECT TRANSLATE('1234ABC123456XYZ1234567890ADS', '0123456789', REPLICATE('X', 10)) AS Replaced;

-- 5. Rows with more than 2 dots
SELECT * FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

-- 6. Count occurrences of a substring in a column
-- Example for substring 'ab'
SELECT 'abcabcabc' AS sample,
       (LEN('abcabcabc') - LEN(REPLACE('abcabcabc', 'ab', ''))) / LEN('ab') AS CountOfSubstring;

-- 7. Count spaces in a string
SELECT texts,
       LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

-- 8. Employees earning more than their managers
SELECT e.Name
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;
