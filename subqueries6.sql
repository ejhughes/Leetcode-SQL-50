/*
Problem:
Table: Insurance

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
 

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.
*/

/* Solution */
WITH sameTiv AS
(
    SELECT 
        i.pid st_pid
        , i.tiv_2016
    FROM Insurance i
    JOIN Insurance j
        ON i.pid!=j.pid 
    WHERE i.tiv_2015=j.tiv_2015
    GROUP BY i.pid
)
,
sameCity AS
(
    SELECT 
        i.pid sc_pid
    FROM Insurance i
    JOIN Insurance j
        ON i.pid!=j.pid 
    WHERE CONCAT('(',i.lat,',',i.lon,')') = CONCAT('(',j.lat,',',j.lon,')')
    GROUP BY i.pid
)

SELECT
    ROUND(SUM(tiv_2016),2) tiv_2016
FROM sameTiv st
WHERE st_pid NOT IN (SELECT sc_pid FROM sameCity)

/* Alternative - much neater, using COUNT rather than JOIN to identify uniqueness of a value against other rows - similar performance overall
SELECT 
    ROUND(SUM(tiv_2016), 2) AS tiv_2016 
FROM 
    Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015 
    FROM Insurance
    GROUP BY tiv_2015 
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon 
    FROM Insurance
    GROUP BY lat, lon 
    HAVING COUNT(*) = 1
);
*/
