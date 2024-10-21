/*
Problem:
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
*/

/* Solution */
SELECT w.id
FROM Weather w /* current day table */
LEFT JOIN Weather v /* previous day table */
    ON w.id = v.id + 1
WHERE w.temperature - v.temperature > 0
