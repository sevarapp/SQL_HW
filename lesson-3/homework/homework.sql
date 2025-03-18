-- Create table with various constraints
CREATE TABLE students (
    id INT IDENTITY(100, 10) PRIMARY KEY,
    name VARCHAR(15) NOT NULL UNIQUE,
    age INT CHECK (age >= 18),
    course_id INT,
    enrollment_date DATE DEFAULT GETDATE(),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Insert sample data
INSERT INTO students (name, age, course_id) VALUES ('Alex', 20, 1);
INSERT INTO students (name, age, course_id) VALUES ('Bob', 22, 2);
INSERT INTO students (name, age, course_id) VALUES ('Charlie', 19, 3);

-- View data
SELECT * FROM students;

-- Delete a specific row
DELETE FROM students WHERE name = 'Bob';
SELECT * FROM students; -- Observe that ID sequence is not reset

-- Truncate table
TRUNCATE TABLE students;
SELECT * FROM students; -- Observe that all data is removed

-- Insert new data after truncation
INSERT INTO students (name, age, course_id) VALUES ('David', 21, 1);
SELECT * FROM students; -- Observe if the identity sequence is reset or not

-- Drop table
DROP TABLE students;
