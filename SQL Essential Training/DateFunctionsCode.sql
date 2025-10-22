/* RL 031223 
STRIFE Function Example
Create Date: 
Description - Calculate the ages of all employees
Use wsda_music
*/

SELECT 
LastName,
FirstName,
BirthDate,
strftime('%Y-%m-%d', Birthdate) AS [Birthday No TimeCode],
strftime('%Y-%m-%d','now') - strftime('%Y-%m-%d', BirthDate) AS [Age] -- "now" to introduce today's date minus the BirthDate
FROM 
Employee
