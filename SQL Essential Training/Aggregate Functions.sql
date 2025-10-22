/* RL 031223 
AGGREGATE() Function
Create Date: 
Description - Calculate grand total from invoice table
Use wsda_music.db
*/


SELECT 
SUM(Total) AS [Total Sales], 
ROUND(AVG(Total),2) AS [Average Sales], -- round to two decimal points // average sales
MAX(Total) AS [Maximum Sale], -- maximum sale
MIN(Total) AS [Min Sale], --minimum sale
COUNT(*) AS [Sales Count] --total count of sales
FROM Invoice
