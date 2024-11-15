/*
Problem:
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
The ID sequence always starts from 1 and increments continuously.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.
*/

/* Solution - original */
WITH swappedSeats AS
    (SELECT 
        s.id
        , t.student
    FROM Seat s
    JOIN Seat t
        ON s.id+CASE WHEN s.id%2=0 THEN -1 ELSE 1 END=t.id
    )

(SELECT * FROM swappedSeats)
UNION 
(SELECT * FROM Seat WHERE id NOT IN (SELECT id FROM swappedSeats))
ORDER BY id

/* Alternative 1 - using COALESCE - less performant
SELECT 
    s.id
    , COALESCE(t.student,s.student) student
FROM Seat s
LEFT JOIN Seat t
    ON s.id+CASE WHEN s.id%2=0 THEN -1 ELSE 1 END=t.id
*/

/* Alternative 2 - No Joins, still using CASE statement
WITH max_cte AS
(
    SELECT 
        max(id) max_id
    FROM Seat
)

SELECT 
    IF( id < (SELECT max_id FROM max_cte),
        CASE WHEN id%2=0 THEN id-1 ELSE id+1 END,
        CASE WHEN id%2=0 THEN id-1 ELSE id END
    ) id
    , student
FROM Seat
ORDER BY id
*/

/* Alternative 3 - No Joins, using IF statements - best performance
WITH max_cte AS (
	SELECT 
		MAX(Id) AS max_id 
	FROM Seat
)
SELECT 
   IF(Id < (SELECT max_id FROM max_cte), 
		IF(Id%2 = 1, Id+1, Id-1), 
		IF(Id%2 = 1, Id, Id-1)
	 ) AS id,
   student
FROM Seat
ORDER BY Id;
*/
