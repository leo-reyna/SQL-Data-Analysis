-- Correlated Queries Example

SELECT *
from inflation_rates

-- Returns happiness scores for countries that exist in the inflation rates table
SELECT  *
FROM    happiness_scores AS h
WHERE EXISTS (SELECT i.country_name
        FROM inflation_rates AS i
        WHERE i.country_name = h.country
        );

-- ALTERNATIVE TO EXISTS: INNER JOIN -- only returns matches for countries that exist in both tables
SELECT  *
FROM    happiness_scores AS h  
        INNER JOIN inflation_rates AS i
        ON i.country_name = h.country
        AND h.year = i.year; 