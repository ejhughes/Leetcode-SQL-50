/*
Problem:
able: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 

We define query quality as:

The average of the ratio between query rating and its position.

We also define poor query percentage as:

The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.
*/

/* Solution */
with cte as(
    SELECT
        query_name
        , COUNT(*) poor_query_n
    FROM Queries
    WHERE rating < 3
    GROUP BY 1
)

SELECT
    q.query_name
    , ROUND(AVG(rating/position),2) quality
    , ROUND((IFNULL(cte.poor_query_n,0)/COUNT(rating)*100),2) poor_query_percentage
FROM Queries q
JOIN cte
    ON q.query_name=cte.query_name
WHERE query_name IS NOT NULL
GROUP BY query_name

/* Alternative - more compact but didn't perform as well
SELECT
    query_name
    , ROUND(AVG(rating/position),2) quality
    , ROUND((SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)/COUNT(*))*100,2) poor_query_percentage
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY query_name
*/

