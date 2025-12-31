USE AdventureWorks2022;

SELECT 
        NationalIDNumber,
        LoginID,
        JobTitle
FROM    HumanResources.Employee;

/*
  1-6. Returning Specific Rows - Problem
 You want to restrict query results to a subset of rows in the table that interest you.
*/
SELECT 
        Title,
        FirstName,
        LastName
FROM    Person.Person
WHERE Title ='Ms.';

SELECT  
        Title,
        FirstName,
        LastName
FROM    Person.Person
WHERE Title = 'Ms.' AND LastName ='Antrim';

/*
  Title	FirstName	LastName
  Ms.	Ramona	Antrim
*/

SELECT  
        Title,
        FirstName,
        LastName
FROM    Person.Person
WHERE Title = 'Ms.' AND ( LastName ='Antrim' OR LastName = 'Galvin' );

/*
  Ms.	Ramona	Antrim
  Ms.	Janice	Galvin
*/


/*
1-7. Listing the Available Tables - Problem
 You want to programmatically list the names of available tables in a schema. You can see the tables from 
Management Studio, but you want them from T-SQL as well.
*/
 SELECT table_name, table_type
 FROM information_schema.tables
 WHERE table_schema = 'HumanResources';
/*
   1-8. Naming the Output Columns - Problem
 You don’t like the column names returned by a query. You wish to change the names for clarity in reporting, 
or to be compatible with an already-written program that is consuming the results from the query.
*/

SELECT
        BusinessEntityID AS "Employee ID",
        VacationHours AS "Vacation",
        SickLeaveHours AS [Sick Time]
FROM    HumanResources.Employee;

/*
  Employee ID	Vacation	Sick Time
            1	    99	    69
            2	    1	    20
*/

/*
   1-9. Providing Shorthand Names for Tables - Problem
 You are writing a complicated WHERE clause, or a SELECT list, mixing column names from many tables, and it 
is becoming tedious to properly qualify each column name with its associated table and schema name.
*/
SELECT
        e.BusinessEntityID AS "Employee ID",
        e.VacationHours AS "Vacation",
        e.SickLeaveHours AS "Sick Time"
FROM    HumanResources.employee AS e
WHERE e.VacationHours > 40
ORDER BY e.VacationHours DESC;

/*
  1-10. Computing New Columns from Existing Data - Problem
 You are querying a table that lacks the precise bit of information you need. However, you are able to write an 
expression to generate the result that you are after. For example, you want to report on total time off available 
to employees. Your database design divides time off into separate buckets for vacation time and sick time. 
You however, wish to report a single value
*/

SELECT
        BusinessEntityID AS "Employee ID",
        VacationHours + SickLeaveHours AS [Available Time Off]
FROM    HumanResources.Employee
ORDER BY [Available Time Off] DESC;

/*
  Employee ID	Available Time Off
    1	        168
    88	        168
*/

/*
   1-11. Negating a Search Condition - Problem
 You are finding it easier to describe those rows that you do 
 not want rather than those that you do want.
*/
SELECT
        Title,
        FirstName,
        LastName
FROM    Person.Person
WHERE NOT Title ='Ms.'
-- WHERE NOT (Title = 'Ms.' OR Title = 'Mr.')
;

/*
  Title	FirstName	LastName
Mr.	Jossef	Goldberg
Mr.	Hung-Fu	Ting
Mr.	Brian	Welcker
*/

/*
    1-12. Keeping the WHERE Clause Unambiguous - Problem
 You are writing several expressions in a WHERE clause that are linked together using AND and OR, 
 and sometimes NOT. You worry that future maintainers of your query will misconstrue your intentions.
*/
SELECT
        Title,
        FirstName,
        LastName
FROM    Person.Person
WHERE   Title = 'Ms.'
        AND ( FirstName = 'Catherine' OR LastName = 'Adams' );
/*
  Title	FirstName	LastName
    Ms.	Catherine	Abel
    Ms.	Carla	Adams
    Ms.	Frances	Adams
    Ms.	Catherine	Whitney
*/

/*
  1-13. Testing for Existence -  Problem
 You want to know whether something is true, but you don’t really care to see the data that proves it.
 For example, you want to know the answer to the following business question: “Are there really employees 
 having more than 80 hours of sick time?”
 */

SELECT  TOP(1) 1
FROM    HumanResources.Employee
WHERE SickLeaveHours > 80;

/*
  (0 row(s) affected)
*/

--  Another approach is to write an EXISTS predicate. For example, and testing for 40 hours this time:
SELECT 1
WHERE EXISTS
(
    SELECT *
    FROM HumanResources.Employee
    WHERE SickLeaveHours > 40
);

/*
  (No column name)
                1

(1 row(s) affected)

 The first solution makes use of T-SQL’s TOP(n) syntax to end the query when the first row is found matching 
the condition. No rows were found in the example. You will find one though, if you lower the hour threshold 
to 40. There are employees having more than 40 hours of sick time, but none that have more than 80 hours.
 The second solution achieves the same result, but through an EXISTS predicate. The outer query returns 
the value 1 as a single row and column to indicate that rows exist for the query listed in the EXISTS predicate. 
Otherwise, the outer query returns no row at all.
 Avoid an ORDER BY clause when testing for existence like this recipe shows
*/

/*
  1-14. Specifying a Range of Values - Problem
 You wish to specify a range of values as a search condition. For example, you are querying a 
 table having a date column. You wish to return rows having dates only in a specified range of interest
*/

-- Inspecting
SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader

SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE ShipDate BETWEEN '2011-07-23 00:00:00.0' AND '2011-07-24 23:59:59.0';

/*
  SalesOrderID	ShipDate
        43993	2011-07-24 00:00:00.000
*/


/*
   1-15. Checking for Null Values - Problem
 Some of the values in a column might be NULL. 
 You wish to identify rows having or not having NULL values.
*/

SELECT  ProductID, Name, Weight
FROM    Production.Product
WHERE   Weight IS NULL;

/*
   1-16. Writing an IN-List
 Problem
 You are searching for matches to a specific list of values. You could write a string of predicates joined by  
OR operators, but you prefer a more easily readable and maintainable solution.
*/

SELECT
      ProductID,
      Name,
      Color
FROM  Production.Product
WHERE Color IN ('Black', 'Silver', 'Red');


 SELECT *
 FROM Production.ProductCategory
 TABLESAMPLE(50 ROWS);

 /*
   1-17. Performing Wildcard Searches
Problem
You don’t have a specific value or list of values to find. What you do have is a general pattern, and you want 
to find all values that match that pattern.
 */

 SELECT producID, Name
 FROM Production.Product;