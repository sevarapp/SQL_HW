select 1
create database hw22
use hw22
--Lesson 22: Aggregated Window Functions
-- Compute Running Total Sales per Customer
SELECT 
  customer_id,
  customer_name,
  order_date,
  total_amount,
  SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;


-- Count the Number of Orders per Product Category
SELECT 
  product_category,
  COUNT(*) OVER (PARTITION BY product_category) AS order_count,
  sale_id
FROM sales_data;

-- Find the Maximum Total Amount per Product Category
SELECT 
  product_category,
  total_amount,
  MAX(total_amount) OVER (PARTITION BY product_category) AS max_total_amount
FROM sales_data;

-- Find the Minimum Price of Products per Product Category
SELECT 
  product_category,
  product_name,
  unit_price,
  MIN(unit_price) OVER (PARTITION BY product_category) AS min_price
FROM sales_data;

-- Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
SELECT 
  order_date,
  customer_id,
  total_amount,
  AVG(total_amount) OVER (
    ORDER BY order_date 
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
  ) AS moving_avg_3_days
FROM sales_data;

-- Find the Total Sales per Region
SELECT 
  region,
  total_amount,
  SUM(total_amount) OVER (PARTITION BY region) AS total_sales_region
FROM sales_data;

-- Compute the Rank of Customers Based on Their Total Purchase Amount
WITH customer_totals AS (
    SELECT 
        customer_id,
        customer_name,
        SUM(total_amount) OVER (PARTITION BY customer_id) AS total_spent
    FROM sales_data
)
SELECT DISTINCT 
    customer_id,
    customer_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM customer_totals;


-- Calculate the Difference Between Current and Previous Sale Amount per Customer
SELECT 
  customer_id,
  order_date,
  total_amount,
  total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS diff_from_prev
FROM sales_data;

-- Find the Top 3 Most Expensive Products in Each Category
SELECT *
FROM (
  SELECT *,
    RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS price_rank
  FROM sales_data
) ranked
WHERE price_rank <= 3;

-- Compute the Cumulative Sum of Sales Per Region by Order Date

SELECT 
  region,
  order_date,
  total_amount,
  SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data;


--Compute Cumulative Revenue per Product Category
SELECT 
  product_category,
  order_date,
  total_amount,
  SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS cumulative_revenue
FROM sales_data;

--Sum of Previous Values (Running Total Example)
CREATE TABLE ID_Table (ID INT);
INSERT INTO ID_Table VALUES (1), (2), (3), (4), (5);


---Sum of Previous Value to Current Value Puzzle
CREATE TABLE OneColumn (Value SMALLINT);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);
SELECT 
  Value,
  SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;


--Odd Row Numbering Per Partition
CREATE TABLE Row_Nums (Id INT, Vals VARCHAR(10));
SELECT 
  Id,
  Vals,
  ROW_NUMBER() OVER (ORDER BY Id) * 2 - 1 AS RowNumber
FROM Row_Nums;


-- Find customers who purchased from more than one product category
SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;


-- Find Customers with Above-Average Spending in Their Region
SELECT *
FROM (
  SELECT *,
         AVG(total_amount) OVER (PARTITION BY region) AS avg_region_spending
  FROM sales_data
) AS sub
WHERE total_amount > avg_region_spending;

-- Dense Rank Customers by Total Spending per Region
WITH CustomerTotals AS (
    SELECT 
        region,
        customer_id,
        customer_name,
        SUM(total_amount) AS total_spent
    FROM sales_data
    GROUP BY region, customer_id, customer_name
)
SELECT 
    region,
    customer_id,
    customer_name,
    total_spent,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY total_spent DESC) AS rank_in_region
FROM CustomerTotals;


-- Running Total of Total Amount by Customer and Order Date
SELECT 
  customer_id,
  order_date,
  total_amount,
  SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;

-- Sales Growth Rate for Each Month Compared to Previous Month
WITH MonthlySales AS (
    SELECT 
        CAST(YEAR(order_date) AS VARCHAR) + '-' + RIGHT('0' + CAST(MONTH(order_date) AS VARCHAR), 2) AS sale_month,
        SUM(total_amount) AS total_month_sales
    FROM sales_data
    GROUP BY 
        YEAR(order_date), 
        MONTH(order_date)
)
SELECT 
    sale_month,
    total_month_sales,
    LAG(total_month_sales) OVER (ORDER BY sale_month) AS prev_month_sales,
    (1.0 * total_month_sales - LAG(total_month_sales) OVER (ORDER BY sale_month)) 
        / NULLIF(LAG(total_month_sales) OVER (ORDER BY sale_month), 0) AS growth_rate
FROM MonthlySales;

-- Customers with Higher Current Total Amount than Their Previous Order
WITH OrderedSales AS (
    SELECT 
        customer_id,
        order_date,
        total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_amount
    FROM sales_data
)
SELECT *
FROM OrderedSales
WHERE total_amount > ISNULL(previous_amount, 0);


-- Products Priced Above Average
SELECT 
    product_category,
    product_name,
    unit_price
FROM sales_data
WHERE unit_price > (
    SELECT AVG(unit_price)
    FROM sales_data AS avg_data
    WHERE avg_data.product_category = sales_data.product_category
);

-- Sum of val1 and val2 for Each Group at Start Row Only
CREATE TABLE MyData (Id INT, Grp INT, Val1 INT, Val2 INT);
WITH WithRow AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) AS rn
    FROM MyData
)
SELECT 
    Id,
    Grp,
    Val1,
    Val2,
    CASE WHEN rn = 1 THEN Val1 + Val2 + Val1 + Val2 ELSE NULL END AS Tot
FROM WithRow;
-- Sum Cost and Quantity (with merging logic)
-- Assuming structure: product_name, cost, quantity, id

WITH product_ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY product_name ORDER BY sale_id) AS rn
    FROM sales_data
)
SELECT 
    sale_id,
    product_name,
    quantity_sold,
    unit_price,
    CASE WHEN rn = 1 THEN quantity_sold + unit_price ELSE NULL END AS merged_sum
FROM product_ranked;

-- Sum TyZe per 'Z' Row with Logic Column
-- Assume: MyTable(id, grp, tyze, logic_col)
CREATE TABLE MyTable (
    Id INT,
    Grp INT,
    TyZe INT,
    Logic_Col CHAR(1)
);

INSERT INTO MyTable VALUES
(1, 1, 10, 'Z'),
(2, 1, 5, 'X'),
(3, 1, 15, 'Z'),
(4, 2, 20, 'Y'),
(5, 2, 25, 'Z');

WITH ZSum AS (
    SELECT grp, SUM(tyze) AS total_tyze
    FROM MyTable
    WHERE logic_col = 'Z'
    GROUP BY grp
)
SELECT 
    t.*,
    CASE 
        WHEN logic_col = 'Z' THEN z.total_tyze 
        ELSE NULL 
    END AS sum_tyze_for_z
FROM MyTable t
LEFT JOIN ZSum z ON t.grp = z.grp;

-- Even Row Number Start Per Partition
WITH base AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY product_name) AS rn
    FROM sales_data
)
SELECT 
    *,
    rn * 2 AS even_row_number
FROM base;








CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);


INSERT INTO sales_data VALUES
(1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
(2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),

(25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East');
