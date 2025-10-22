/* RL 031223 
GROUP BY CLAUSE - ADD MIN AVG
Create Date: 

Description: grouping in SQL. What is the average invoice totals 
FOR ONLY CITIES WHERE THE CITY Starts with "b" AND "l". and greater
than $5 dollars
Average invoice amount by BillingCity
Use wsda_music.db
*/


SELECT 
	BillingCity AS [Billing City],
	ROUND(AVG(Total),2) AS [Average Sale]
FROM 
	Invoice
WHERE 
	BillingCity LIKE 'b%'
GROUP BY 
	BillingCity -- always use the non-aggregate field here!!.
HAVING
	AVG(Total) > 5 -- where you can use aggregate fields here!!.
ORDER BY
	BillingCity;