/* RL 031223 
GROUP BY CLAUSE - ADD MIN AVG
Create Date: 
Description: grouping in SQL. What is the average invoice totals by city?
Average invoice amount by BillingCity
Use wsda_music.db
*/


SELECT 
	BillingCity AS [Billing City],
	ROUND(AVG(Total),2) AS [Average Sale]
FROM 
	Invoice
GROUP BY 
	BillingCity -- always use the non-aggregate field here!!.
ORDER BY
	BillingCity;