USE MathDB
---------------------------------------
--Calculating Mathematical Expressions
---------------------------------------

--Addition 
SELECT 2 + 2 AS Result;

--Subtract
SELECT 20 - 4 AS Result;

--Multiplication
SELECT 30 * 2.50 * 30AS Result;

--Division
SELECT 38 / 5 AS Result;

--Modulo
SELECT 38 % 5 AS Result;

--Exponent Calculates the power of the exponent (y) for the specified base-value (x):
--POWER(X, Y)
SELECT POWER(2, 3) AS Result;

 
-----------------------------------------------------------------------------------------------------------------
--PEMDAS stands for parentheses, exponents, multiplication, division, addition, and subtraction. 
--This term serves as a guideline for the order of operations necessary to solve more complex equations.
--SQL reads them left to right, and then values beginning from the inside to the outside. 
--For this reason, ensure your values within parentheses accurately capture the problem you’re trying to solve.
------------------------------------------------------------------------------------------------------------------
--Placement matters, consider the following the examples below uses the same three values and operators, but with a different parentheses placement, this produces a different result:
 
 SELECT (12 + 41) * 7 AS Result;
--Output 371

 SELECT 12 + (41 * 7) AS Result;
--Output 299


-------------------------------------------
--Analyzing Data with Aggregate Functions
-------------------------------------------

SELECT [product_id]
      ,UPPER([product_name])
      ,CAST([total_inventory] AS decimal (10,1)) AS [Total inventory]
      ,[product_cost]
      ,[product_retail]
      ,[store_units]
      ,[online_units]
      ,[product_type]
FROM [dbo].[product_information]

--SUMs the column named 'inventory'
SELECT 
  SUM(total_inventory) AS [inventory total]
FROM dbo.product_information;

--Max total of inventory
SELECT 
  MAX(product_cost) AS [Max Cost]
FROM dbo.product_information;

--Average Cost and Average Retail price
SELECT 
  AVG(product_cost) AS Cost_Average, 
  AVG(Product_Retail) AS AvgRetail
FROM dbo.product_information;


-- Use the COUNT function with the WHERE statement to query the number of products whose retail value is more than $8.00
SELECT COUNT(product_retail) as Result
FROM product_information 
WHERE product_retail > 8.00;

--Query the number of products from product_cost that were purchased by the store for more than $8.00:
SELECT COUNT(product_cost) as Result
FROM dbo.product_information
WHERE product_retail > 8.00;
  
--average cost of each product
WITH Product_AVG_Cost AS (
  SELECT product_name, CAST(AVG(product_cost) AS decimal (10,2)) AS [Average Cost]
  FROM dbo.product_information
  GROUP BY product_name
)
SELECT *
FROM Product_AVG_Cost;