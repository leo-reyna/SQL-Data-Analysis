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