/*
RL March 2023
use wsda_music
*/

SELECT
e.FirstName,
e.LastName,
e.EmployeeId,
c.FirstName,
c.LastName,
c.SupportRepId,
i.CustomerId,
i.total
FROM 
Invoice AS i
INNER JOIN Customer AS c
ON
i.CustomerId = c.CustomerId
INNER JOIN Employee as e
ON
c.SupportRepId = e.EmployeeId
ORDER BY
i.total DESC
LIMIT 10;

