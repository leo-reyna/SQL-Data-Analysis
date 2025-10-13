-- Assignment: Self Joins
-- Write a quert to determine which products are within 25 cents of each other in terms
-- of unit price and return a list of all the candy pairs?

use maven_advanced_sql;

SELECT *
FROM products;

SELECT 
	p1.product_name, 
	p1.unit_price, 
	p2.product_name,
	p2.unit_price,
	p1.unit_price - p2.unit_price as price_diff
FROM products as p1
INNER JOIN products as p2
	ON p1.product_id <> p2.product_id
WHERE ABS(p1.unit_price - p2.unit_price) < 0.25
	AND p1.product_name < p2.product_name -- alphabetically listing
ORDER BY price_diff desc;

