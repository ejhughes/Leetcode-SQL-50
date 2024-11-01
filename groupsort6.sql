/*
Problem:
Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.
*/

/* Solution - not great since it returns several rows so have to group by */
SELECT IFNULL(
    (
    SELECT
        num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*)=1
    ORDER BY num desc
    LIMIT 1
    )
    , null) num
FROM MyNumbers
GROUP BY 1

/* Alternative 1 - using MAX(num) and num IN( sub-query )
SELECT MAX(num) AS num 
 FROM MyNumbers 
 WHERE num IN (SELECT num FROM MyNumbers GROUP BY num HAVING COUNT(*) = 1)
*/

/* Alternative 2 - using COALESCE
SELECT COALESCE(
(SELECT  num
FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1 
ORDER BY num DESC LIMIT 1),
null) as num
*/

