-- Assignment 5 - Multiple CTEs     
-- List the company's factories along with the names of the products they produce and the numbers
-- of product they produced

-- Converting from this query, using multiple CTEs
SELECT 
	fp.factory,
	fp.product_name,
	fn.num_products
FROM
(SELECT factory, product_name 
FROM products) as fp -- final products
LEFT JOIN
(SELECT factory, COUNT(product_id) as num_products
FROM products
GROUP BY factory) as fn -- final numbers
on fp.factory = fn.factory
order by fp.factory, fp.product_name;


WITH fp AS (SELECT factory, product_name FROM products),
     fn AS (SELECT factory, COUNT(product_name) as num_products 
            FROM products GROUP BY factory)
SELECT 
    fp.factory, 
    fp.product_name, 
    fn.num_products
FROM fp
    LEFT JOIN fn
    ON fp.factory = fn.factory
ORDER By fp.factory, fp.product_name;