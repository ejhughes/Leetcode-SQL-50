/*
Problem:
Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.
*/

/* Solution */
WITH acceptedFriends AS
(
    SELECT 
        requester_id id
        , COUNT(accepter_id) num
    FROM RequestAccepted
    GROUP BY requester_id
)
,
requestedFriends AS
(
    SELECT
        accepter_id id
        , COUNT(requester_id) num
    FROM RequestAccepted
    GROUP BY accepter_id
)
,
totalFriends AS
(
SELECT 
    id
    , SUM(num) num
FROM
    (
    (SELECT * FROM acceptedFriends) 
    UNION ALL
    (SELECT * FROM requestedFriends) 
    ) t
GROUP BY id
)

SELECT 
    id
    , num
FROM totalFriends
WHERE num = (SELECT max(num) FROM totalFriends)

/* Alternative - create a list of requester/accepter, then union and only then count rows, groupy by id
SELECT id, COUNT(*) AS num 
FROM (SELECT requester_id AS id FROM RequestAccepted

UNION ALL

SELECT accepter_id FROM RequestAccepted
) AS friends_count

GROUP BY id
ORDER BY num DESC 
LIMIT 1;
*/
