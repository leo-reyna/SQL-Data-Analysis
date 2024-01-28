/* SQL Queries: AdventureWorks Part-I
LR December 2023
*/

USE AdventureWorks2022

/* 1 Sample table: HumanResources.Employee
From the following table write a query in SQL to retrieve all rows and columns 
from the employee table in the Adventureworks database. Sort the result set in 
ascending order on jobtitle. Sample table: HumanResources.Employee
*/

SELECT *  
FROM humanresources.employee  
ORDER BY jobtitle;

/* 2 Sample table: Person.Person
From the following table write a query in SQL to retrieve all rows and columns 
from the employee table using table aliasing in the Adventureworks database. 
Sort the output in ascending order on lastname.  
*/

SELECT *
FROM Person.Person
ORDER BY LastName ASC;

/* 3 Sample table: Person.Person
From the following table write a query in SQL to return all rows and a subset of 
the columns (FirstName, LastName, businessentityid) from the person table 
in the AdventureWorks database. The third column heading is renamed to Employee_id. 
Arranged the output in ascending order by lastname. 
*/

SELECT FirstName, LastName, BusinessEntityID as Employee_id
FROM Person.Person
ORDER BY LastName ASC;

/* 4 Sample table: production.Product
From the following table write a query in SQL to return only the rows for product 
that have a sellstartdate that is not NULL and a productline of 'T'. 
Return productid, productnumber, and name. Arranged the output in ascending order on name.
*/

SELECT ProductID, ProductNumber, name
FROM Production.Product
WHERE SellStartDate IS NOT NULL AND ProductLine = 'T'
ORDER BY Name ASC;

/* 5 Sample table: sales.salesorderheader
From the following table write a query in SQL to return all rows from the salesorderheader table in
Adventureworks database and calculate the percentage of tax on the subtotal have decided. 
Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. 
Arranged the result set in ascending order on subtotal.
*/

SELECT 
    SalesOrderID, 
    customerid,
    orderDate, 
    subtotal, 
     (taxAmt*100) as Tax_Percentage
FROM sales.salesorderheader
ORDER BY subtotal ASC;

/* 6 Sample table: HumanResources.Employee. From the following table write a query in SQL to create a list of unique jobtitles 
in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order.
*/

SELECT DISTINCT(JobTitle)
FROM humanresources.Employee
ORDER BY JobTitle;

/* 7 Sample table: sales.salesorderheader. From the following table write a query in SQL to calculate
 the total freight paid by each customer. Return customerid and total freight. Sort the output in
 ascending order on customerid.
*/

SELECT CustomerID, FORMAT(SUM(Freight),'C', 'EN-US') AS TotalFreight
FROM SALES.salesorderheader
GROUP BY CustomerID
ORDER BY CustomerID ASC;

/* 8 Sample table: sales.salesorderheader 
From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. 
Return customerid, average and sum of the subtotal. 
Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
*/

SELECT 
    CustomerId, 
    SalesPersonid, 
    AVG(SubTotal) AS avg_SubTotal,
    SUM(SubTotal) as sum_SubTotal
FROM SALES.salesorderheader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC;

/* 9 From the Sample table: production.productinventory write a query in SQL to retrieve 
total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. 
Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. 
Sort the results according to the productid in ascending order.
*/

SELECT 
    ProductID, 
    SUM(Quantity) AS TotalQty
FROM Production.productinventory
WHERE Shelf in ('A', 'B', 'H')
GROUP BY ProductID
HAVING SUM(Quantity) > 500
ORDER BY ProductID ASC;

/* 10. From the Sample table: production.productinventory  write a query in 
SQL to find the total quantity for a group of locationid multiplied by 10 */

SELECT SUM(Quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY (LocationID * 10);

/* 11. From the Sample table: Person.PersonPhone write a 
query in SQL to find the persons whose last name starts with letter 'L'. 
Return BusinessEntityID, FirstName, LastName, and PhoneNumber. 
Sort the result on lastname and firstname
*/
SELECT pph.BusinessEntityID, ppe.FirstName, ppe.LastName, pph.PhoneNumber
FROM  Person.Person AS ppe
LEFT JOIN Person.PersonPhone as pph
ON ppe.BusinessEntityID = pph.BusinessEntityID
WHERE ppe.LastName like 'L%'
ORDER BY ppe.LastName, ppe.FirstName

/* 12. From  sales.salesorderheader write a query in SQL to find the sum of subtotal column. 
Group the sum on distinct salespersonid and customerid. Rolls up the results into 
subtotal and running total. Return salespersonid, customerid and sum of subtotal 
column i.e. sum_subtotal 
*/
SELECT 
    SalesPersonID, 
    CustomerID,       
    SUM(SubTotal) AS sum_SubTotal,
    SUM(SUM(SubTotal)) OVER (ORDER BY SalesPersonID, CustomerID) AS Running_Total
FROM sales.salesorderheader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, CustomerID

/*
13. From production.productinventory write a query in SQL to find the sum of the 
quantity of all combination of group of distinct locationid and shelf column. 
Return locationid, shelf and sum of quantity as TotalQuantity
 */
SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY CUBE (locationid, shelf);
SELECT locationid, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY GROUPING SETS ( locationid, () );

/*
14. You are querying a table that lacks the precise bit of information you need. However, you are able to write an 
expression to generate the result that you are after. For example, you want to report on total time off available 
to employees. Your database design divides time off into separate buckets for vacation time and sick time. 
You however, wish to report a single value.
*/

SELECT BusinessEntityID, VacationHours + SickLeaveHours as AvailableTime
FROM HumanResources.Employee;

-- 14a. Creating a function for employee's available time. Display the full name. Display lowest available time
-- First, check if the function already exists, drop it if it does

IF OBJECT_ID('dbo.ufnCalculateAvailableTime') IS NOT NULL
    DROP FUNCTION HumanResources.fn_CalculateAvailableTime;
GO

-- Creating the Function
CREATE FUNCTION dbo.ufnCalculateAvailableTime (@VacationHours INT, @SickLeaveHours INT)
RETURNS INT
AS
BEGIN
DECLARE @AvailableTime INT;
   SET @AvailableTime = ISNULL(@VacationHours, 0)  + ISNULL(@SickLeaveHours, 0)
   RETURN @AvailableTime
END;

-- Using the function
SELECT 
    per.BusinessEntityID as EmployeeID,
    per.firstname + ' ' + per.LastName as FullName, 
    dbo.ufnCalculateAvailableTime(VacationHours, SickLeaveHours) AS AvailableTime
FROM HumanResources.Employee as emp
left JOIN Person.Person as per 
ON EMP.BusinessEntityID = PER.BusinessEntityID
ORDER BY AvailableTime;

/* 
15. Locate all December 2013 Work Orders produced on that month.
It should have no Scrapped units. Sort results so the work orders
with highest amount of scapped units appear at the top
Table: Production.Workorder
*/

SELECT 
	WorkOrderID as 'Work Order Id',
	ScrappedQty as 'Scrapped Qty',
	StartDate as 'Start Date',
	EndDate as 'End Date'
FROM Production.Workorder
WHERE StartDate  >= '2013-12-01' AND  EndDate <= '2013-12-31'  and ScrappedQty > 0 
ORDER BY ScrappedQty DESC

/* 
15a. Distinct Cities, check for StateProviceID 
*/

SELECT DISTINCT City , StateProvinceID -- Using this ID column to weed out dups
FROM Person.Address
ORDER BY City;