-- Restore .tar file db name = Bookings
SELECT * FROM cd.bookings;
SELECT * FROM cd.facilities;
SELECT * FROM cd.members;
/*
  How can you produce a list of facilities that charge a fee to members?
Expected Results should have just 5 rows:

*/
SELECT 
        facid,
        name, 
        membercost,
        guestcost,
        initialoutlay,
        monthlymaintenance
FROM cd.facilities
WHERE membercost > 0;

/*
  How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost?
   Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.
Result is just two rows:
*/
SELECT
        facid,
        name,
        membercost,
        monthlymaintenance
FROM cd.facilities
WHERE membercost > 0
    AND membercost < (monthlymaintenance / 50.0);
/*
  How can you produce a list of all facilities with the word 'Tennis' in their name?
Expected Result is 3 rows

*/
SELECT
        facid,
        name,
        membercost,
        guestcost,
        initialoutlay,
        monthlymaintenance
FROM cd.facilities
WHERE NAME LIKE '%Tennis%';

/*
  How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
Expected Result is 2 rows
*/

SELECT
        facid,
        name,
        membercost,
        guestcost,
        initialoutlay,
        monthlymaintenance
FROM cd.facilities
WHERE facid IN (1,5);

/*
  How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question.
Expected Result is 10 rows (not all are shown below)
*/

SELECT * FROM cd.members;

SELECT
        memid,
        surname,
        firstname,
        joindate
FROM cd.members
WHERE joindate >= '2012-09-01';

/*
  How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates.
Expected Result should be 10 rows if you include GUEST as a last name

*/
SELECT
     DISTINCT surname
FROM cd.members
ORDER BY surname ASC
LIMIT 10;

/*
  You'd like to get the signup date of your last member. How can you retrieve this information?
  Expected Result
2012-09-26 18:08:45
*/

SELECT MAX(joindate) AS latest_joindate FROM cd.members;

/*
  Produce a count of the number of facilities that have a cost to guests of 10 or more.
Expected Result 6
*/

SELECT * FROM cd.facilities;

SELECT count(name)
FROM cd.facilities
WHERE guestcost >= 10;

/*
  
Produce a list of the total number of slots booked per facility in the month of September 2012. 
Produce an output table consisting of facility id and slots, sorted by the number of slots.
Expected Result is 9 rows
*/

SELECT * FROM cd.bookings;

SELECT 
    b.facid,
    f.name,
    sum(slots)
FROM cd.bookings AS b
LEFT JOIN cd.facilities as f
    on b.facid = f.facid
WHERE b.starttime >= '2012-09-01'
  AND b.starttime <  '2012-09-30'
GROUP BY b.facid, f.name
ORDER BY sum(slots);

/*
  Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id and total slots, sorted by facility id.
Expected Result is 5 rows

*/

SELECT 
    b.facid,
    f.name,
    sum(slots)
FROM cd.bookings AS b
LEFT JOIN cd.facilities as f
    on b.facid = f.facid
GROUP BY b.facid, f.name
HAVING SUM(slots) > 1000
ORDER BY b.facid, sum(slots);
sdfa

/*
  How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? 
  Return a list of start time and facility name pairings, ordered by the time.
*/

SELECT * FROM cd.bookings;
SELECT * FROM cd.facilities;

SELECT 
    b.facid,
    b.starttime,
    f.name
FROM cd.bookings AS b
LEFT JOIN cd.facilities as f
    on b.facid = f.facid
WHERE b.facid IN (0,1) AND b.starttime >= '2012-09-21'
GROUP BY b.facid, f.name, b.starttime
ORDER BY b.starttime;

/*
  How can you produce a list of the start times for bookings by members named 'David Farrell'?
Expected result is 34 rows of timestamps
*/

SELECT * FROM cd.bookings;
SELECT * FROM cd.members;
SELECT 
    m.firstname,
    m.surname,
    b.starttime
FROM cd.bookings AS b
LEFT JOIN cd.members as m
ON b.memid = m.memid 
WHERE m.firstname = 'David' AND m.surname = 'Farrell';
