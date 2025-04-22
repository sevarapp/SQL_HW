create database hw_18
use hw_18

--Find Employees with Minimum Salary
SELECT * 
FROM employees 
WHERE salary = (SELECT MIN(salary) FROM employees);

CREATE TABLE employees ( id INT PRIMARY KEY, name VARCHAR(100), salary DECIMAL(10, 2) );

INSERT INTO employees (id, name, salary) VALUES (1, 'Alice', 50000), (2, 'Bob', 60000), (3, 'Charlie', 50000);

--Find Products Above Average Price
CREATE TABLE products ( id INT PRIMARY KEY, product_name VARCHAR(100), price DECIMAL(10, 2) );

INSERT INTO products (id, product_name, price) VALUES (1, 'Laptop', 1200), (2, 'Tablet', 400), (3, 'Smartphone', 800), (4, 'Monitor', 300);
SELECT * 
FROM products 
WHERE price > (SELECT AVG(price) FROM products);


--Find Employees in Sales Department
CREATE TABLE departments ( id INT PRIMARY KEY, department_name VARCHAR(100) );

CREATE TABLE employees1 ( id INT PRIMARY KEY, name VARCHAR(100), department_id INT, FOREIGN KEY (department_id) REFERENCES departments(id) );

INSERT INTO departments (id, department_name) VALUES (1, 'Sales'), (2, 'HR');

INSERT INTO employees1 (id, name, department_id) VALUES (1, 'David', 1), (2, 'Eve', 2), (3, 'Frank', 1);

SELECT * 
FROM employees1 
WHERE department_id = (
    SELECT id 
    FROM departments 
    WHERE department_name = 'Sales'
);

--Find Customers with No Orders
CREATE TABLE customers ( customer_id INT PRIMARY KEY, name VARCHAR(100) );

CREATE TABLE orders ( order_id INT PRIMARY KEY, customer_id INT, FOREIGN KEY (customer_id) REFERENCES customers(customer_id) );

INSERT INTO customers (customer_id, name) VALUES (1, 'Grace'), (2, 'Heidi'), (3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES (1, 1), (2, 1);
SELECT * 
FROM customers 
WHERE customer_id NOT IN (
    SELECT customer_id 
    FROM orders
);

--Find Products with Max Price in Each Category
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);
INSERT INTO products (id, product_name, price, category_id)
VALUES 
    (1, 'Tablet', 400, 1),
    (2, 'Laptop', 1500, 1),
    (3, 'Headphones', 200, 2),
    (4, 'Speakers', 300, 2);
SELECT p.*
FROM products p
JOIN (
    SELECT category_id, MAX(price) AS max_price
    FROM products
    GROUP BY category_id
) max_prices
ON p.category_id = max_prices.category_id AND p.price = max_prices.max_price;

--Find Employees in Department with Highest Average Salary
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
CREATE TABLE departments1 ( id INT PRIMARY KEY, department_name VARCHAR(100) );

CREATE TABLE employees ( id INT PRIMARY KEY, name VARCHAR(100), salary DECIMAL(10, 2), department_id INT, FOREIGN KEY (department_id) REFERENCES departments1(id) );

INSERT INTO departments1 (id, department_name) VALUES (1, 'IT'), (2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES (1, 'Jack', 80000, 1), (2, 'Karen', 70000, 1), (3, 'Leo', 60000, 2);

SELECT * 
FROM employees 
WHERE department_id = (
    SELECT Top 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

--Find Employees Earning Above Department Average
CREATE TABLE employees2 ( id INT PRIMARY KEY, name VARCHAR(100), salary DECIMAL(10, 2), department_id INT );

INSERT INTO employees2 (id, name, salary, department_id) VALUES (1, 'Mike', 50000, 1), (2, 'Nina', 75000, 1), (3, 'Olivia', 40000, 2), (4, 'Paul', 55000, 2);
SELECT * 
FROM employees e
WHERE salary > (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department_id = e.department_id
);

--Find Students with Highest Grade per Course
CREATE TABLE students ( student_id INT PRIMARY KEY, name VARCHAR(100) );

CREATE TABLE grades ( student_id INT, course_id INT, grade DECIMAL(4, 2), FOREIGN KEY (student_id) REFERENCES students(student_id) );

INSERT INTO students (student_id, name) VALUES (1, 'Sarah'), (2, 'Tom'), (3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES (1, 101, 95), (2, 101, 85), (3, 102, 90), (1, 102, 80);

select * from students
select * from grades
SELECT * 
FROM students s
WHERE EXISTS (
    SELECT 1 
    FROM grades g
    WHERE g.student_id = s.student_id 
    AND g.grade = (
        SELECT MAX(grade) 
        FROM grades 
        WHERE course_id = g.course_id
    )
);

--Find Third-Highest Price per Category
CREATE TABLE products3 ( id INT PRIMARY KEY, product_name VARCHAR(100), price DECIMAL(10, 2), category_id INT );

INSERT INTO products3 (id, product_name, price, category_id) VALUES (1, 'Phone', 800, 1), (2, 'Laptop', 1500, 1), (3, 'Tablet', 600, 1), (4, 'Smartwatch', 300, 1), (5, 'Headphones', 200, 2), (6, 'Speakers', 300, 2), (7, 'Earbuds', 100, 2);
SELECT id, product_name, price, category_id
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rank_in_category
    FROM products
) ranked_products
WHERE rank_in_category = 3;

--Find Employees Between Company Average and Department Max Salary
CREATE TABLE employees4 ( id INT PRIMARY KEY, name VARCHAR(100), salary DECIMAL(10, 2), department_id INT );

INSERT INTO employees4 (id, name, salary, department_id) VALUES (1, 'Alex', 70000, 1), (2, 'Blake', 90000, 1), (3, 'Casey', 50000, 2), (4, 'Dana', 60000, 2), (5, 'Evan', 75000, 1);


SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary) FROM employees
)
AND salary < (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);

