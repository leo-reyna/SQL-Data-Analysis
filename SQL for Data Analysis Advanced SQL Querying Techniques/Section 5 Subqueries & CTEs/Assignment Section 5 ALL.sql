
-- ASSIGNMENT SECTION 5
-- Identify products that have a unit price less than the unit price of all products from
-- Wicked Choccy's? please include which factory is currently producing the product.
-- Cols. product_id, product_name, factory, division, unit_price

USE maven_advanced_sql;

SELECT * FROM products;

--VIEW ALL THE PRODUCT FROM wicked choccy's
SELECT * FROM products 
WHERE factory = 'Wicked Choccy''s';

-- PRODUCTS THAT HAVE A UNIT PRICE LESS THAN THE UNIT PRICE OF ALL PRODUCTS FROM wicked choccy's
SELECT *
FROM products
WHERE unit_price < ALL(SELECT unit_price FROM products 
                        WHERE factory = "Wicked Choccy's");



