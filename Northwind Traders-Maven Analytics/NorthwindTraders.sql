-- Maven Analytics Northwind Traders Challenge
-- Top Level Analysis
-- June 2023 /
-- Leo Reyna //

USE [Northwind Traders]

/* SALES 
Count of Orders
There are a total of 830 Products
*/
SELECT 
    COUNT(OrderID) as [Order Count]
FROM dbo.orders;

/* YTD Total Revenue 
YTD Total Sales were $1,354,458.59 Million
*/
SELECT 
    FORMAT(sum(quantity * unitPrice),'C') AS [YTD Total Sales]
FROM dbo.order_details;

/* YTD Net Revenue  - includes discount
YTD Total Sales were $1,265,793.04 Million
*/
SELECT 
    FORMAT(sum(quantity * unitPrice *(1- discount)),'C') AS [YTD Net Sales]
FROM dbo.order_details;

/* Cost of Freight 
Total Cost YTD $64K 
*/
SELECT 
    FORMAT(CAST(SUM(freight) AS decimal (10,2)), 'C') AS [Cost of Freight]
FROM dbo.orders;

/* Count of Customers 
There are 91 Customers*/
SELECT  
    COUNT(DISTINCT(customerID)) AS [Count of Customer]
FROM
    Customers;

/* Count of Products 
There are 77 Products*/

SELECT
    COUNT(DISTINCT(productID)) AS [Products Count]
FROM
    dbo.products;

/* Count of Countries
There are 21 Countries*/

SELECT
    COUNT(DISTINCT(country)) AS [Count of Countries]
FROM 
    dbo.customers;


/* TOP 5 PRODUCTS 
Product Name	Qty Sold
Camembert Pierrot	1,577
Raclette Courdavault	1,496
Gorgonzola Telino	1,397
Gnocchi di nonna Alice	1,263
Pavlova	1,158
*/
SELECT TOP 5
    prd.productName AS [Product Name],
    FORMAT(CAST(SUM(ord.quantity) AS decimal (10,1)), '0,0') AS [Qty Sold]
FROM dbo.order_details AS ord
INNER JOIN dbo.products AS prd
    ON ord.productID = prd.productID
GROUP BY prd.productName
ORDER BY SUM(ord.quantity) DESC;

/*
TOP 5 Customer based on Net Sales:
The top 3 customers account for 24% of total sales
CustomerName	NetSales	OrderCount	SalesPercentage
QUICK-Stop	$110,277.31	86	8.71%
Ernst Handel	$104,874.98	102	8.29%
Save-a-lot Markets	$104,361.95	116	8.24%
Rattlesnake Canyon Grocery	$51,097.80	71	4.04%
Hungry Owl All-Night Grocers	$49,979.91	55	3.95%
*/

SELECT
    cus.companyName AS CustomerName,
    FORMAT(SUM(ode.quantity * ode.unitPrice * (1 - ode.discount)), 'C') AS NetSales,
    COUNT(ode.orderID) AS OrderCount,
    FORMAT(SUM(ode.quantity * ode.unitPrice * (1 - ode.discount)) / 
        (SELECT 
        SUM(ode.quantity * ode.unitPrice * (1 - ode.discount)) FROM dbo.order_details ode), 'P') AS SalesPercentage  
FROM dbo.customers AS cus
INNER JOIN dbo.orders AS ord 
    ON cus.customerID = ord.customerID
INNER JOIN dbo.order_details AS ode 
    ON ord.OrderID = ode.orderID
GROUP BY cus.companyName
ORDER BY SUM(ode.quantity * ode.unitPrice * (1 - ode.discount)) DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

/* Lowest Net Sale Month and Year 
May of 2015
Year	Month	NetSales
2015	5	$18,333.63
*/
SELECT top 1 with ties	
	DATEPART(YEAR, ord.orderDate) AS Year,
	DATEPART(MONTH, ord.orderDate) AS Month,
	FORMAT(sum(ode.quantity * ode.unitPrice  * (1 - ode.discount)),'C') AS NetSales
FROM dbo.order_details AS ode 
INNER JOIN dbo.orders AS ord 
    ON ode.orderID = ord.orderID
GROUP BY
	DATEPART(YEAR, ord.orderDate),
	DATEPART(MONTH, ord.orderDate)
ORDER BY SUM(ode.quantity * ode.unitPrice * (1 - ode.discount))

-- Order Count by Year, Month
SELECT 
    DATENAME(MONTH, orderDate) AS MonthName,
    DATEPART(YEAR, orderDate) AS Year,
    COUNT (distinct(orderID)) as SalesCount
FROM dbo.orders
GROUP by 
    DATEPART(MONTH, orderDate),
    DATEPART(YEAR, orderDate),
    DATENAME(MONTH, orderDate)
ORDER BY Year

-- Order Count per Year

SELECT
    COUNT(orderID) as OrderCount,
    DATEPART(YEAR, orderDate) AS Year
FROM dbo.orders
GROUP BY
    DATEPART(YEAR, orderDate)
--
SELECT 
    CONCAT(DATENAME(MONTH, orderDate), ' ', DATEPART(YEAR, orderDate)) AS Year,
    COUNT (distinct(orderID)) as SalesCount
FROM dbo.orders
GROUP by 
    DATEPART(MONTH, orderDate),
    DATEPART(YEAR, orderDate),
    DATENAME(MONTH, orderDate)
ORDER BY Year
