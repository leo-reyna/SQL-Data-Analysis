/* 
RL March 2023
Description: Creatign a Mailing List of Customer
Connecting Strings
use wsda_music
*/

SELECT
FirstName,
LastName,
Address,
FirstName ||' '|| LastName ||' '|| Address ||', '|| City ||' '|| State || ' ' || PostalCode AS [Mailing Address]
FROM
Customer
WHERE Country ='USA';