-- Easy Questions

-- 1. Ascii value of 'A'
SELECT ASCII('A');

-- 2. Length of 'Hello World'
SELECT LEN('Hello World');

-- 3. Reverse 'OpenAI'
SELECT REVERSE('OpenAI');

-- 4. Add 5 spaces before 'SQL'
SELECT CONCAT('     ', 'SQL');

-- 5. Remove leading spaces from ' SQL Server'
SELECT LTRIM(' SQL Server');

-- 6. Convert 'sql' to uppercase
SELECT UPPER('sql');

-- 7. First 3 characters of 'Database'
SELECT LEFT('Database', 3);

-- 8. Last 4 characters of 'Technology'
SELECT RIGHT('Technology', 4);

-- 9. Substring from position 3 to 6 in 'Programming'
SELECT SUBSTRING('Programming', 3, 4);

-- 10. Concatenate 'SQL' and 'Server'
SELECT CONCAT('SQL', 'Server');

-- 11. Replace 'apple' with 'orange' in 'apple pie'
SELECT REPLACE('apple pie', 'apple', 'orange');

-- 12. Position of 'learn' in 'Learn SQL with LearnSQL'
SELECT CHARINDEX('learn', 'Learn SQL with LearnSQL');

-- 13. Check if 'Server' contains 'er'
SELECT CHARINDEX('er', 'Server');

-- 14. Split 'apple,orange,banana' into words
SELECT value FROM STRING_SPLIT('apple,orange,banana', ',');

-- 15. Power of 2 raised to 3
SELECT POWER(2, 3);

-- 16. Square root of 16
SELECT SQRT(16);

-- 17. Current date and time
SELECT GETDATE();

-- 18. Current UTC date and time
SELECT GETUTCDATE();

-- 19. Day of the month for '2025-02-03'
SELECT DAY('2025-02-03');

-- 20. Add 10 days to '2025-02-03'
SELECT DATEADD(DAY, 10, '2025-02-03');


-- Medium Questions

-- 1. Convert ASCII value 65 to character
SELECT CHAR(65);

-- 2. Difference between LTRIM() and RTRIM()
-- LTRIM removes leading spaces, RTRIM removes trailing spaces.

-- 3. Find position of 'SQL' in 'Learn SQL basics'
SELECT CHARINDEX('SQL', 'Learn SQL basics');

-- 4. Concatenate 'SQL' and 'Server' with a comma
SELECT CONCAT_WS(',', 'SQL', 'Server');

-- 5. Replace 'test' with 'exam' using Stuff()
SELECT STUFF('This is a test.', 11, 4, 'exam');

-- 6. Square of 7 using Power()
SELECT POWER(7, 2);

-- 7. First 5 characters of 'International'
SELECT LEFT('International', 5);

-- 8. Last 2 characters of 'Database'
SELECT RIGHT('Database', 2);

-- 9. Result of Patindex('%n%', 'Learn SQL')
SELECT PATINDEX('%n%', 'Learn SQL');

-- 10. Days difference between '2025-01-01' and '2025-02-03'
SELECT DATEDIFF(DAY, '2025-01-01', '2025-02-03');

-- 11. Month of '2025-02-03'
SELECT MONTH('2025-02-03');

-- 12. Extract year from '2025-02-03' using DatePart()
SELECT DATEPART(YEAR, '2025-02-03');

-- 13. Get current time without date
SELECT CONVERT(TIME, GETDATE());

-- 14. Sysdatetime() returns current date and time with higher precision
SELECT SYSDATETIME();

-- 15. Find next Wednesday from today's date
SELECT DATEADD(DAY, (7 + 3 - DATEPART(WEEKDAY, GETDATE())) % 7, GETDATE());

-- 16. Difference between Getdate() and Getutcdate()
-- GETDATE() returns local time, GETUTCDATE() returns UTC time.

-- 17. Absolute value of -15
SELECT ABS(-15);

-- 18. Round 4.57 to nearest whole number using Ceiling()
SELECT CEILING(4.57);

-- 19. Current time using Current_Timestamp
SELECT CURRENT_TIMESTAMP;

-- 20. Day name for '2025-02-03'
SELECT DATENAME(WEEKDAY, '2025-02-03');


-- Difficult Questions

-- 1. Reverse 'SQL Server' and remove spaces
SELECT REPLACE(REVERSE('SQL Server'), ' ', '');

-- 2. Concatenate 'City' values using String_agg()
SELECT STRING_AGG(City, ', ') FROM Cities;

-- 3. Check if 'SQL' and 'Server' are in string
SELECT CASE 
            WHEN CHARINDEX('SQL', 'Learn SQL Server') > 0 AND CHARINDEX('Server', 'Learn SQL Server') > 0 
            THEN 'Both found'
            ELSE 'Not found'
          END;

-- 4. Cube of 5 using Power()
SELECT POWER(5, 3);

-- 5. Split 'apple;orange;banana' by semicolon
SELECT value FROM STRING_SPLIT('apple;orange;banana', ';');

-- 6. Trim leading and trailing spaces from ' SQL '
SELECT TRIM(' SQL ');

-- 7. Difference in hours between two timestamps
SELECT DATEDIFF(HOUR, '2025-01-01 10:00:00', '2025-01-01 15:00:00');

-- 8. Number of months between '2023-05-01' and '2025-02-03'
SELECT DATEDIFF(MONTH, '2023-05-01', '2025-02-03');

-- 9. Find position of 'SQL' from end of 'Learn SQL Server'
SELECT CHARINDEX('SQL', REVERSE('Learn SQL Server'));

-- 10. Split 'apple,orange,banana' by comma
SELECT value FROM STRING_SPLIT('apple,orange,banana', ',');

-- 11. Days from '2025-01-01' to today
SELECT DATEDIFF(DAY, '2025-01-01', GETDATE());

-- 12. First 4 characters of 'Data Science'
SELECT LEFT('Data Science', 4);

-- 13. Square root of 225, rounded using Ceiling()
SELECT CEILING(SQRT(225));

-- 14. Concatenate with '|' separator using Concat_ws()
SELECT CONCAT_WS('|', 'SQL', 'Server');

-- 15. Position of first digit in 'abc123xyz'
SELECT PATINDEX('%[0-9]%', 'abc123xyz');

-- 16. Find second occurrence of 'SQL' in 'SQL Server SQL'
SELECT CHARINDEX('SQL', 'SQL Server SQL', CHARINDEX('SQL', 'SQL Server SQL') + 1);

-- 17. Extract year from current date using DatePart()
SELECT DATEPART(YEAR, GETDATE());

-- 18. Subtract 100 days from the current date
SELECT DATEADD(DAY, -100, GETDATE());

-- 19. Day of the week for '2025-02-03'
SELECT DATENAME(WEEKDAY, '2025-02-03');

-- 20. Square of a number using Power() function
SELECT POWER(5, 2);
