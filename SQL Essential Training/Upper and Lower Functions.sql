/* 
RL March 2023
Description: Creatign a Mailing List of Customer
using Lengt, substr functions
use wsda_music
*/

SELECT
FirstName,
LastName,
Address,
FirstName ||' '|| LastName ||' '|| Address ||', '|| City ||' '|| State || ' ' || PostalCode AS [Mailing Address], 
LENGTH(PostalCode), 
SUBSTR(PostalCode, 1,5) AS [5-Digit Postal Code], --only want to keep  digits - first digit to the fifth 
UPPER(LastName) AS [All Caps Last Name],
LOWER(FirstName) AS [All Caps First Name]
FROM
Customer
WHERE Country ='USA';

