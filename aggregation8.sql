/*
Problem:
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
*/

/* Solution */
WITH cte AS (
    SELECT 
        player_id
        , event_date
        , MIN(event_date) OVER(PARTITION BY player_id) first_login_date
    FROM Activity
    GROUP BY player_id, event_date
)

SELECT 
    ROUND(SUM(event_date=DATE_ADD(first_login_date, INTERVAL 1 day))/(SELECT COUNT(DISTINCT player_id) FROM Activity),2) fraction
FROM cte
