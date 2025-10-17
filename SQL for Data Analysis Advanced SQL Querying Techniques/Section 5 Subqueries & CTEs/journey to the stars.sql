-- Active: 1745290413437@@127.0.0.1@3306@journey_to_space
USE journey_to_the_space;

SELECT COUNT(*)
FROM space_missions
WHERE MissionStatus = 'Success'

SELECT MISSIONSTATUS, COUNT(*) AS number_of_missions
FROM space_missions
GROUP BY MISSIONSTATUS

