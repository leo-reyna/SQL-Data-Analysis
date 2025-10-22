/*
Created by: RL
Date Created: Feb 20, 2023
Description: This query display all customers information:
first, last name and email addresses.
It is also a best practice example. The way it is indented
*/

SELECT 
	FirstName AS [Customer First Name], 
	LastName AS "Customer Last Name",
	Email AS EMAIL
FROM 
	Customer
ORDER BY
	FirstName ASC,
	LastName DESC
LIMIT 20