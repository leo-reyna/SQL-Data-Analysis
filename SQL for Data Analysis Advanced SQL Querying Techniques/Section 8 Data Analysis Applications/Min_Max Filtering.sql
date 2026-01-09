-- MIN / MAX Filtering
CREATE TABLE sales 
(
id int PRIMARY KEY,
sales_rep VARCHAR(50),
date DATE,
sales INT
);

INSERT INTO sales (id, sales_rep, date, sales) VALUES
(1, 'Emma', '2024-08-01', 6),
(2, 'Emma', '2024-08-02', 17),
(3, 'Jack', '2024-08-02', 14),
(4, 'Emma', '2024-08-04', 20),
(5, 'Jack', '2024-08-05', 5),
(6, 'Emma', '2024-08-07', 1);


-- View Sales Table
SELECT * FROM sales;

-- Goal: Return the most recent sales amount for each sales rep
 -- Group by and Join approach
 WITH rd as (
 SELECT sales_rep,
        MAX(date) as most_recent_date
 FROM sales
 GROUP BY sales_rep
 )
 SELECT     rd.sales_rep, rd.most_recent_date, s.sales
 FROM       rd
 LEFT JOIN sales as s
 ON rd.sales_rep = s.sales_rep AND rd.most_recent_date = s.date;

-- Number of sales on most recent date: window function approach

WITH wf_cte as (
SELECT  sales_rep,
        date,
        sales,
        ROW_NUMBER() OVER (PARTITION BY sales_rep ORDER BY date DESC) as row_num
FROM    sales
)
SELECT sales_rep, date, sales
FROM wf_cte
WHERE row_num = 1;

