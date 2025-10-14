SELECT COUNT(*)
FROM space_missions
WHERE MissionStatus = 'Success'

SELECT MISSIONSTATUS, COUNT(*) AS number_of_missions
FROM space_missions
GROUP BY MISSIONSTATUS

