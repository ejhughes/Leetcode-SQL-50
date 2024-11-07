/* 
Problem

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.
*/

/* Solution - longer but more performant, filtering happens in a join between two tables before joining the 3rd*/
/* Also proved better to use SELECT DISTINCT instead of GROUP BY */
SELECT 
    DISTINCT CASE WHEN (l1.num = num2 and l1.num=num3) THEN l1.num END ConsecutiveNums
FROM Logs l1
LEFT JOIN 
    (
    SELECT 
        l2.id id2
        , l2.num num2
        , l3.id id3
        , l3.num num3
    FROM Logs l2
    LEFT JOIN Logs l3
    ON l2.id=l3.id-1
    WHERE l2.num=l3.num
    ) j
    ON l1.id=id2-1
WHERE  (l1.num = num2 and l1.num=num3)


/* Alternative - much simpler to read. Originally tried this but got errors. Results showed it was much slower

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l1.id = l2.id - 1
JOIN Logs l3 ON l1.id = l3.id - 2
WHERE l1.num = l2.num AND l2.num = l3.num;

*/
