-- ▒▒ SECTION 4: Multi-Table Analysis ▒▒
-- ASSIGNMENT 1: Basic Joins
-- Looking at the orders and products tables, which products exist in one table, but not the other?

-- Access MySQL Database
USE maven_advanced_sql;

-- View the orders and products tables
SELECT * FROM orders;
SELECT * FROM Products;

SELECT count(distinct product_id) FROM orders; -- There are 15 Products
SELECT count(distinct product_id) FROM products;  -- There are 18 products


-- Join the tables using various join types & note the number of rows in the output
SELECT count(*)
FROM orders AS od
LEFT JOIN products as pr
	ON od.product_id = pr.product_id; -- There are 8549 lines

SELECT count(*)
FROM orders AS od
RIGHT JOIN products AS pr
	ON od.product_id = pr.product_id; -- There are 8552 lines 
        
-- View the products that exist in one table, but not the other
SELECT *
FROM orders AS od
LEFT JOIN products AS pr
	ON od.product_id = pr.product_id 
WHERE pr.product_id IS NULL; -- There are ZERO 

SELECT *
FROM orders AS od
RIGHT JOIN products AS pr
	ON od.product_id = pr.product_id
WHERE od.product_id IS NULL;  -- THERE 3 PRODUCST IN THE ORDER TABLE BUT NOT IN THE PRODUCT TABLE

-- Use a LEFT JOIN to join products and orders
SELECT pr.product_id, pr.product_name, od.product_id as product_id_in_orders
FROM products AS pr
LEFT JOIN orders AS od
	ON pr.product_id = od.product_id
WHERE od.product_id IS NULL; -- There are 3 products that have not been ordered, there were in the products table but not in the orders table. 
-- The products are: Loopy Lollipops, Tropical Nerds, Pixy Stix