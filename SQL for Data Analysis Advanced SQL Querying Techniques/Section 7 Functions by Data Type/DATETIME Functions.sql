-- DATETIME Functions

-- Get the current date and current time
SELECT CURRENT_DATE, CURRENT_TIMESTAMP;

-- Create an event Table
CREATE TABLE my_events(
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(50),
    event_date DATE,
    event_datetime DATETIME,
    event_type VARCHAR(20),
    event_description TEXT
);

--ALTER TABLE my_events ADD COLUMN event_id INT AUTO_INCREMENT PRIMARY KEY;
-- Federal Holidays and other holidays in the U.S. in 2024
INSERT INTO my_events (event_name, event_date, event_datetime, event_type, event_description) VALUES 
('New Year\'s Day', '2024-01-01', '2024-01-01 00:00:00', 'Federal Holiday', 'A celebration marking the start of the year'),
('Martin Luther King Jr. Day', '2024-01-15', '2024-01-15 09:00:00', 'Federal Holiday', 'Honoring civil rights leader Martin Luther King Jr.'),
('Presidents\' Day', '2024-02-19', '2024-02-19 10:00:00', 'Federal Holiday', 'Commemorating U.S. presidents past and present'),
('Memorial Day', '2024-05-27', '2024-05-27 11:00:00', 'Federal Holiday', 'Remembering fallen military service members'),
('Juneteenth National Independence Day', '2024-06-19', '2024-06-19 12:00:00', 'Federal Holiday', 'Celebrating the end of slavery in the U.S.'),
('Independence Day', '2024-07-04', '2024-07-04 21:00:00', 'Federal Holiday', 'Fireworks and festivities marking U.S. independence'),
('Labor Day', '2024-09-02', '2024-09-02 12:00:00', 'Federal Holiday', 'Honoring American workers'),
('Columbus Day', '2024-10-14', '2024-10-14 10:00:00', 'Federal Holiday', 'Commemorating Christopher Columbus\'s arrival'),
('Veterans Day', '2024-11-11', '2024-11-11 11:00:00', 'Federal Holiday', 'Honoring military veterans'),
('Thanksgiving Day', '2024-11-28', '2024-11-28 15:00:00', 'Federal Holiday', 'Family gatherings and gratitude'),
('Christmas Day', '2024-12-25', '2024-12-25 09:00:00', 'Federal Holiday', 'Celebrating the holiday season'),
('Valentine\'s Day', '2024-02-14', '2024-02-14 19:00:00', 'Other Holiday', 'A day of love and affection'),
('St. Patrick\'s Day', '2024-03-17', '2024-03-17 17:00:00', 'Other Holiday', 'Celebrating Irish heritage'),
('Easter Sunday', '2024-03-31', '2024-03-31 10:00:00', 'Other Holiday', 'Christian celebration of resurrection'),
('Cinco de Mayo', '2024-05-05', '2024-05-05 18:00:00', 'Other Holiday', 'Celebrating Mexican heritage'),
('Halloween', '2024-10-31', '2024-10-31 19:00:00', 'Other Holiday', 'Costumes and trick-or-treating'),
('Mother\'s Day', '2024-05-12', '2024-05-12 12:00:00', 'Other Holiday', 'Honoring mothers'),
('Father\'s Day', '2024-06-16', '2024-06-16 13:00:00', 'Other Holiday', 'Honoring fathers'),
('Super Bowl Sunday', '2024-02-11', '2024-02-11 18:30:00', 'Other Holiday', 'Major sporting event and celebration')
;


SELECT *
FROM  my_events;

WITH Name_of_Day_CTE as 
(
SELECT 
        event_name, 
        event_date, 
        event_datetime, 
        YEAR(event_date) as event_year, 
        MONTH(event_date) as event_month,
        DAYOFWEEK(event_date) as event_dow
FROM    my_events
)
SELECT event_name, event_date,
    CASE 
        WHEN DAYOFWEEK(event_date) = 1 THEN 'Sunday'
        WHEN DAYOFWEEK(event_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(event_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(event_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(event_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(event_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(event_date) = 7 THEN 'Saturday'                                                        
    ELSE 'unknown' END AS day_name
FROM Name_of_Day_CTE;

--Interval between 2 DATETIME values
--Looking at last years celebrations and how long its been since
SELECT 
    event_name, event_date,
    DATEDIFF(CURRENT_DATE, event_date) as days_elapsed
FROM my_events;

SELECT 
        event_name, 
        event_date, 
        event_datetime, 
        DATE_ADD(event_datetime, INTERVAL 1 HOUR) AS plus_one_hr
FROM    my_events

select * from products;
SELECT * FROM orders;
