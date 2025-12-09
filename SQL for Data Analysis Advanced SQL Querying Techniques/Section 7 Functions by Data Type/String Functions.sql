-- Active: 1745290413437@@127.0.0.1@3306@maven_advanced_sql
-- String Functions
-- Changing the case
SELECT 
        event_name,
        UPPER(event_name),
        LOWER(event_name)
FROM my_events;

-- Combione the type and description columns
SELECT 
        event_name,
        event_type,
        TRIM(REPLACE(event_type, '!', '')) as cleaned_type_event,
        event_description,
        LENGTH(event_description) as desc_len
FROM my_events;
WITH my_events_cleaned AS
(
    SELECT 
        event_name,
        event_type,
        TRIM(REPLACE(event_type, '!', '')) as cleaned_type_event,
        event_description,
        LENGTH(event_description) as desc_len
    FROM my_events
)
SELECT  event_name,
        CONCAT(cleaned_type_event, ' » ', event_description) as new_desc
        FROM  my_events_cleaned;

-- String Functions Pattern Matching


SELECT  *
FROM    my_events;
-- Return the first word of each event thru the 3rd char
SELECT  event_name,
        SUBSTR( event_name, 1,3 )
FROM    my_events;

SELECT  event_name,
        INSTR( event_name, ' ') -- Find a especial character -- sees it in the x position
FROM    my_events;

SELECT  event_name,
        SUBSTR( event_name, 1, INSTR( event_name, ' ' ) -1 ) as first_word -- "-1" to remove the extra space.
FROM    my_events;

-- Update to handle single word events
SELECT  event_name,
        CASE WHEN INSTR(event_name,  ' ') = 0 then event_name
        ELSE SUBSTR( event_name, 1, INSTR( event_name, ' ' ) -1 ) END AS first_word -- "-1" to remove the extra space.
FROM    my_events;

-- Return descriptions that contain the word 'family'
SELECT * 
FROM    my_events
where event_description LIKE '%family%';

-- Return descriptions that tarts wit the letter 'A'
SELECT * 
FROM    my_events
where event_description LIKE 'A %';

-- Return STUDENTS with 3 letter first names '
SELECT * 
FROM students
WHERE student_name LIKE '___ %';

-- Note any celebration word in the sentence
SELECT * 
FROM    my_events

-- Or using REGEXP
SELECT  event_description,
REGEXP_SUBSTR(event_description, 'celebration|festival|holiday') AS celebration_word
FROM    my_events
WHERE   event_description LIKE '%celebration%' 
        OR event_description LIKE '%festival%'
        OR event_description LIKE '%holiday%';

-- Return words with hypehn in them
-- If you want any hyphenated word (not requiring the single capital + space)
SELECT  event_description,
        REGEXP_SUBSTR(event_description, '[A-Za-z]+(-[A-Za-z]+)+') AS hyphen_word
FROM    my_events
