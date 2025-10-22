/* RL 031223 
Multiple Filters
Create Date: 
Description: grouping in SQL. What are the average invoice totals
by BillingCountry and BillingCity

Use wsda_music.db

*/


SELECT 
	BillingCountry AS [Billing Country],
	BillingCity AS [Billing City],
	ROUND(AVG(Total),2) AS [Average Invoice Amt]
FROM 
	Invoice
GROUP BY	
	BillingCity,
	BillingCountry
ORDER BY
	BillingCountry;