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
-- 1. Separate numbers and characters
SELECT Value,
       LEFT(Value, PATINDEX('%[^0-9]%', Value + 'X') - 1) AS Numbers,
       SUBSTRING(Value, PATINDEX('%[^0-9]%', Value + 'X'), LEN(Value)) AS Characters
FROM SeperateNumbersAndCharcters;

-- 2. Dates with higher temp than previous day
SELECT w1.Id
FROM weather w1
JOIN weather w2 ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;

-- 3. First logged-in device for each player
SELECT player_id, device_id
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn
    FROM Activity
) t
WHERE rn = 1;

-- 4. First login date for each player
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

-- 5. Return third item from comma-separated list
SELECT fruit_list,
       PARSENAME(REPLACE(fruit_list, ',', '.'), 2) AS ThirdItem
FROM fruits;

-- 6. Convert string into rows (1 char per row)
DECLARE @str VARCHAR(100) = 'sdgfhsdgfhs@121313131';
WITH nums AS (
    SELECT TOP (LEN(@str)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
SELECT SUBSTRING(@str, n, 1) AS Character
FROM nums;

-- 7. Replace p1.code=0 with p2.code
SELECT p1.id,
       CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS final_code
FROM p1
JOIN p2 ON p1.id = p2.id;

-- 8. Week-on-week % sales per area
SELECT *,
       CAST((ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) * 100.0 /
           SUM(ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) OVER (PARTITION BY Area, FinancialWeek) AS DECIMAL(5,2)) AS WeekPercentage
FROM WeekPercentagePuzzle;
