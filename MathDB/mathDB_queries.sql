USE MathDB
/* 
Uses set of instructions
*/
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
  SUM(total_inventory) AS [invetory_total]
FROM dbo.product_information;

--Max total of inventory
SELECT 
  MAX(product_cost) AS CostMax
FROM dbo.product_information;

SELECT 
  AVG(product_cost) AS Cost_Average, 
  AVG(Product_Retail) AS AvgRetail
FROM dbo.product_information;

SELECT 
  COUNT(product_retail)
FROM dbo.product_information
WHERE product_retail > 8.00;
  
--average cost of each product
WITH Product_AVG_Cost AS (
  SELECT product_name, AVG(product_cost) AS average_cost
  FROM dbo.product_information
  GROUP BY product_name
)

SELECT *
FROM Product_AVG_Cost;
