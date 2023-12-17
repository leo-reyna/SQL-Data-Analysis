/* SQL Queries: AdventureWorks Part-I
LR December 2023

*/

USE AdventureWorks2022

/* 1
Sample table: HumanResources.Employee
From the following table write a query in SQL to retrieve all rows and columns 
from the employee table in the Adventureworks database. Sort the result set in 
ascending order on jobtitle. Sample table: HumanResources.Employee
*/

SELECT *  
FROM humanresources.employee  
ORDER BY jobtitle;

/* 2
Sample table: Person.Person
From the following table write a query in SQL to retrieve all rows and columns 
from the employee table using table aliasing in the Adventureworks database. 
Sort the output in ascending order on lastname.  
*/

SELECT *
FROM Person.Person
ORDER BY LastName ASC;

/* 3
Sample table: Person.Person
From the following table write a query in SQL to return all rows and a subset of 
the columns (FirstName, LastName, businessentityid) from the person table 
in the AdventureWorks database. The third column heading is renamed to Employee_id. 
Arranged the output in ascending order by lastname. 
*/

SELECT FirstName, LastName, BusinessEntityID as Employee_id
FROM Person.Person
ORDER BY LastName ASC;

/* 4
Sample table: production.Product
From the following table write a query in SQL to return only the rows for product 
that have a sellstartdate that is not NULL and a productline of 'T'. 
Return productid, productnumber, and name. Arranged the output in ascending order on name.
*/

SELECT ProductID, ProductNumber, name
FROM Production.Product
WHERE SellStartDate IS NOT NULL AND ProductLine = 'T'
ORDER BY Name ASC;

/* 5
Sample table: sales.salesorderheader
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
ORDER BY subtotal;