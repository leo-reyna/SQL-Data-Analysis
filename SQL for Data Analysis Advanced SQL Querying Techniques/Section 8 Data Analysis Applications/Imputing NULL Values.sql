-- Imputing NULL values

-- Create stock price tables
CREATE TABLE IF not EXISTS stock_prices
(
    date DATE PRIMARY KEY,
    price DECIMAL (10,2)
);



INSERT INTO stock_prices (date, price) VALUES
('2024-11-01', 678.27),
('2024-11-03', 688.83),
('2024-11-04', 645.40),
('2024-11-06', 591.01);

SELECT * FROM stock_prices;

-- Recursive CTE:
-- Example of a recursive CTE generating a date range and then joining it to the stock table
WITH RECURSIVE my_dates(dt) as ( --- It has one column, called dt.
                                    SELECT '2024-11-01' -- - This is the anchor row, the starting point of the recursion.
                                    UNION ALL
                                    SELECT dt + INTERVAL 1 DAY -- it takes the previous value of dt and adds 1 day.
                                    FROM my_dates
                                    WHERE dt < '2024-11-06'
                                )
SELECT md.dt, sp.price
FROM my_dates as md
LEFT JOIN stock_prices as sp
ON md.dt = sp.date;

-- Let's replace the NULL values in the price column 4 different ways (aka imputation)
-- 1. With a hard coded value
-- 2. With a subquery
-- 3. With one window function
-- 4. With two window functions 


-- The last coalesce line is called smoothing and it's recommended.
--- It has one column, called dt.
WITH RECURSIVE my_dates(dt) AS ( -- it has one column named dt
                                    SELECT '2024-11-01' -- - This is the anchor row, the starting point of the recursion.
                                    UNION ALL
                                    SELECT dt + INTERVAL 1 DAY -- it takes the previous value of dt and adds 1 day.
                                    FROM my_dates
                                    WHERE dt < '2024-11-06' --stops if date is less than the 11-06-2024
                                ),
                        sp  AS (
                                    SELECT md.dt, sp.price
                                    FROM my_dates as md
                                    LEFT JOIN stock_prices as sp
                                    ON md.dt = sp.date                                    
                                )
SELECT 
        dt,
        COALESCE(price, 600) as updated_price_600,
        COALESCE(price, ROUND((SELECT AVG(price) FROM sp), 2)) as updated_price_avg,
        COALESCE(price, LAG(price) over()) as updated_price_prior_row,
        COALESCE(price, ROUND((LAG(price) over() + LEAD(price) OVER ())/2, 2)) as updated_price_prior_row -- this gives us the average of the prior and next row values it will also give us the approach
FROM sp;