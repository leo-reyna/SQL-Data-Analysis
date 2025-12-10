-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql

SELECT * FROM orders

-- assignment 7: numeric functions
-- How many customers have spent $0 - $10, $10 - $20 and so on
-- for every $10 range. Generate a table for management

SELECT
    o.customer_id,
    o.product_id,
    o.units,
    p.product_id,
    p.unit_price,
    o.units * p.unit_price as total
FROM orders as o
LEFT JOIN products as p
    On o.product_id = p.product_id


SELECT
    o.customer_id,
    SUM ( o.units * p.unit_price ) as total_spent
FROM orders as o
LEFT JOIN products as p
    On o.product_id = p.product_id
GROUP BY o.customer_id;

-- put the spent into bins of $0 - $10, $10 -$20 etc
SELECT
    o.customer_id,
    SUM ( o.units * p.unit_price ) as total_spent,
    FLOOR(SUM (o.units * p.unit_price) / 10 ) * 10 as total_spent_bin
FROM orders as o
LEFT JOIN products as p
    On o.product_id = p.product_id
GROUP BY o.customer_id;

-- Number of customer in each spend bin
-- final query
WITH cte_bin as (
                SELECT
                    o.customer_id,
                    SUM ( o.units * p.unit_price ) as total_spent,
                    FLOOR(SUM (o.units * p.unit_price) / 10 ) * 10 as total_spent_bin
                FROM orders as o
                LEFT JOIN products as p
                    On o.product_id = p.product_id
                GROUP BY o.customer_id
)
SELECT 
            total_spent_bin,
            count(customer_id) as num_customers
FROM        cte_bin
GROUP BY    total_spent_bin
ORDER BY    total_spent_bin;



select * from products;
SELECT * FROM orders

-- i needed more rows in orders and products tables to get Q2 (the original dataset only had q1 data)
INSERT INTO products (
    product_id, product_name, factory, division, unit_price
) VALUES
('CHO-CRU-12583', 'Choco Crunch Reactor - Ultra-crisp chocolate fusion bar', 'Sugar Shack', 'Chocolate', 7.99),
('CAK-SWI-94201', 'Swirl Tower Cake - Triple-spiral fluffy delight', 'Secret Factory', 'Cakes', 11.49),
('OTH-GUM-33482', 'Gummy Nova Burst - Chewy fruit explosion clusters', 'Wicked Choccy''s', 'Other', 3.79),
('CUP-SMO-55012', 'Smores Cupcake Core - Campfire-infused marshmallow center', 'Lot''s O''Nuts', 'Cupcakes', 4.59),
('BRE-HON-77421', 'Honey Melt Loaf - Soft sweet bread infused with golden honey', 'Sugar Shack', 'Bread', 5.89),
('CHO-GAL-88214', 'Galaxy Melt Bar - Milky cosmic swirl chocolate', 'Secret Factory', 'Chocolate', 9.49),
('CAK-LAV-22130', 'Lavender Cloud Cake - Floral sweet fluffy dream', 'Wicked Choccy\'s', 'Cakes', 10.29),
('OTH-POW-99831', 'Powder Puff Drops - Sugar-dust coated mini spheres', 'Lot''s O''Nuts', 'Other', 2.99),
('CUP-FIZ-34015', 'Fizzy Berry Cupcake - Pop-rocks infused berry frosting', 'Sugar Shack', 'Cupcakes', 3.49),
('BRE-CIN-43002', 'CinnaTwirl Brioche - Sweet cinnamon ribbon loaf', 'Secret Factory', 'Bread', 6.79),
('CHO-NUT-65301', 'Nutty Blast Brick - Chunky nut-packed chocolate block', 'Lot''s O''Nuts', 'Chocolate', 8.29),
('CAK-DRE-55742', 'DreamSlice Cake - Soft slice with vanilla cloud layers', 'Wicked Choccy\'s', 'Cakes', 9.89),
('OTH-FLO-19954', 'Flossy Sugar Strings - Cotton candy rope twists', 'Sugar Shack', 'Other', 2.19),
('CUP-MAG-88711', 'Magic Sprinkle Cupcake - Glittery rainbow sugar top', 'Secret Factory', 'Cupcakes', 3.99),
('BRE-BUT-44092', 'ButterCookie Loaf - Cookie-flavored soft sweet bread', 'Lot''s O''Nuts', 'Bread', 7.39),
('CHO-MOO-99220', 'Moonlight Chocolate Brick - Dark silky lunar blend', 'Wicked Choccy\'s', 'Chocolate', 10.99),
('CAK-FRO-11682', 'FrostBurst Cake - Cool vanilla-mint freezer slice', 'Secret Factory', 'Cakes', 8.59),
('OTH-SPA-77410', 'Sparkle Crunch Gems - Crystal sugar candy bites', 'Lot''s O''Nuts', 'Other', 1.99),
('CUP-BOO-21597', 'BoomBerry Cupcake - Berry burst center surprise', 'Wicked Choccy\'s', 'Cupcakes', 4.29),
('BRE-CHO-66008', 'ChocoSwirl Loaf - Marble chocolate sweet bread', 'Sugar Shack', 'Bread', 6.49);


INSERT INTO orders (transaction_id, customer_id, order_id, order_date, product_id, units) VALUES
('T0101', 21240,'US-2021-137681-44252','2021-03-01','CHO-FUD-51001',34),
('T0102', 18127,'US-2021-137682-44253','2021-03-02','CAK-SPR-32011',12),
('T0103', 25041,'US-2021-137683-44254','2021-03-05','OTH-ZIP-88212',5),
('T0104', 28581,'US-2021-137684-44255','2021-03-07','CUP-CRL-12903',18),
('T0105', 27174,'US-2021-137685-44256','2021-03-09','BRE-CRN-77410',9),
('T0106', 19751,'US-2021-137686-44257','2021-03-12','CHO-MNT-66221',27),
('T0107', 22446,'US-2021-137687-44258','2021-03-14','CAK-BRY-43810',37),
('T0108', 32361,'US-2021-137688-44259','2021-03-18','OTH-GUM-90112',21),
('T0109', 34083,'US-2021-137689-44260','2021-03-20','CUP-CRN-25591',11),
('T0110', 40162,'US-2021-137690-44261','2021-03-21','BRE-HNY-52210',6),

('T0111', 34442,'US-2021-137691-44262','2021-04-02','CHO-POP-51044',25),
('T0112', 31999,'US-2021-137692-44263','2021-04-04','CAK-DRM-32088',14),
('T0113', 15894,'US-2021-137693-44264','2021-04-06','OTH-BLT-88290',3),
('T0114', 17936,'US-2021-137694-44265','2021-04-07','CUP-MLT-12955',32),
('T0115', 26623,'US-2021-137695-44266','2021-04-10','BRE-BRY-77492',29),
('T0116', 26413,'US-2021-137696-44267','2021-04-12','CHO-CRN-66285',8),
('T0117', 43046,'US-2021-137697-44268','2021-04-15','CAK-FIZ-43877',19),
('T0118', 29591,'US-2021-137698-44269','2021-04-17','OTH-STR-90144',4),
('T0119', 12245,'US-2021-137699-44270','2021-04-20','CUP-FUD-25540',33),
('T0120', 15794,'US-2021-137700-44271','2021-04-22','BRE-MAP-52287',15),

('T0121', 28079,'US-2021-137701-44272','2021-05-01','CHO-FUD-51001',7),
('T0122', 42948,'US-2021-137702-44273','2021-05-03','CAK-SPR-32011',16),
('T0123', 26420,'US-2021-137703-44274','2021-05-04','OTH-ZIP-88212',40),
('T0124', 18526,'US-2021-137704-44275','2021-05-07','CUP-CRL-12903',24),
('T0125', 43240,'US-2021-137705-44276','2021-05-09','BRE-CRN-77410',31),
('T0126', 34097,'US-2021-137706-44277','2021-05-12','CHO-MNT-66221',22),
('T0127', 14144,'US-2021-137707-44278','2021-05-14','CAK-BRY-43810',6),
('T0128', 15360,'US-2021-137708-44279','2021-05-15','OTH-GUM-90112',10),
('T0129', 27965,'US-2021-137709-44280','2021-05-18','CUP-CRN-25591',35),
('T0130', 13276,'US-2021-137710-44281','2021-05-21','BRE-HNY-52210',13),

('T0131', 17469,'US-2021-137711-44282','2021-06-01','CHO-POP-51044',20),
('T0132', 22362,'US-2021-137712-44283','2021-06-02','CAK-DRM-32088',4),
('T0133', 15199,'US-2021-137713-44284','2021-06-03','OTH-BLT-88290',28),
('T0134', 43751,'US-2021-137714-44285','2021-06-04','CUP-MLT-12955',39),
('T0135', 35051,'US-2021-137715-44286','2021-06-05','BRE-BRY-77492',12),
('T0136', 39623,'US-2021-137716-44287','2021-06-06','CHO-CRN-66285',38),
('T0137', 44955,'US-2021-137717-44288','2021-06-07','CAK-FIZ-43877',9),
('T0138', 40531,'US-2021-137718-44289','2021-06-08','OTH-STR-90144',17),
('T0139', 22206,'US-2021-137719-44290','2021-06-10','CUP-FUD-25540',40),
('T0140', 19350,'US-2021-137720-44291','2021-06-12','BRE-MAP-52287',26);

/*
  ADD SHIPPING DATES FOR Q2 ORDER DATE
  ------------------------------------
  The market research team wants to do a deep dive on the 
  Q1 2021 orders data we currently have.
  Can you pull that data for them?>
  In addtion, they also requested that we include a ship_date
  column for them that is 2 days after order_date
*/ 


SELECT 
        order_id, 
        order_date,
        DATE_ADD(order_date, INTERVAL 2 DAY) AS ship_datE
FROM orders
WHERE QUARTER(order_date) = 2

-- OR SOL. 2

SELECT 
    order_id,
    order_date,
    DATE_ADD(order_date, INTERVAL 2 DAY) AS Ship_Date
FROM orders
WHERE Year(order_date) = 2021 AND MONTH(order_date) BETWEEN 4 AND 6;
    
SELECT * from products;
SELECT * FROM orders

SELECT 
        factory,
        product_id,
        REPLACE(REPLACE(factory, "'", "")," ","-") as cleaned_factory_name
FROM products
ORDER BY factory, product_id;

-- Create anew id column called factory_product_id
WITH clean_fac_CTE as 
(
        SELECT 
            factory,
            product_id,
            REPLACE(REPLACE(factory, "'", "")," ","-") as cleaned_factory_name
        FROM    products
        ORDER BY factory, product_id
)
SELECT  factory, 
        product_id,
        CONCAT(product_id, "-", cleaned_factory_name) as combo
FROM clean_fac_CTE;

/*
  PATTERN MATCHING
  ------------------------------------
  Remove the word Wonka Bar from the product 
*/ 
-- Look at the product table
SELECT product_name
FROM products
ORDER BY product_name DESC;

-- Replacing
SELECT product_name,
    REPLACE( product_name, 'Wonka Bar - ', '' ) as new_product_name
FROM products
ORDER BY product_name DESC;

-- ALTERNATIVE USING SUBSTRINGS
SELECT product_name,
    INSTR( product_name, '-') as hyphen_location,
    TRIM(SUBSTR( product_name,  INSTR( product_name, '-') + 1 )) as new_product_name
FROM products
ORDER BY product_name DESC;

SELECT 
        product_name,
        CASE WHEN INSTR( product_name, '-') = 0 THEN product_name
        INSTR( product_name, '-') + 1 )) END as new_product_name
FROM products
ORDER BY product_name DESC;


/*
 FILL IN NULL vALUES
Sugar shack and the other factory just added two new products that don't have divisions assigned to them.
For simplicity's sake, could you update those null values to have a value of other.
Here's an extra challenge for you.
Instead of updating them to other, could you update them to be the same division as the most common
division within their respective factories?
*/

SELECT * FROM products


SELECT  
        product_name,
        factory,
        division
FROM    products;

SELECT  
        product_name,
        factory,
        division,
        COALESCE(division, 'Other') AS division_other
FROM    products
ORDER BY factory, division;

-- the most common division for each factory
SELECT  
        factory,
        division,
        COUNT( product_name) AS num_products
FROM    products
WHERE division IS NOT NULL
GROUP BY factory, division
ORDER BY factory, division;

WITH np_cte as 
(
    SELECT  
        factory,
        division,
        COUNT( product_name) AS num_products
        FROM    products
        WHERE division IS NOT NULL
        GROUP BY factory, division
        ORDER BY factory, division
),
    np_rank as 
(       
        SELECT  factory,
        division,
        ROW_NUMBER() OVER(PARTITION BY factory ORDER BY num_products DESC) AS np_rank
        FROM np_cte
),
    top_division AS
(
        SELECT *
        FROM np_rank
        where np_rank = 1
)
SELECT      
            p.product_name, p.factory, p.division,
            COALESCE(p.factory, 'Other') AS division_other,
            COALESCE(p.division, td.division) as division_top
FROM        products as p
LEFT JOIN   top_division as td
ON p.division = td.division
ORDER BY p.factory, p.division;

SELECT FLOOR(27 /10) * 10 AS floored,
(27/10) * 10 AS normal 