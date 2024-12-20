/*
Problem:
Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.
*/

/* Solution */
WITH daily_table AS
    (
    SELECT 
        visited_on
        , SUM(amount) day_amount
    FROM Customer
    GROUP BY visited_on
    )
,
moving_table AS
(
    SELECT
        visited_on
        , SUM(day_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) amount
        , ROUND(
            SUM(day_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)/7
            ,2) average_amount
        , RANK() OVER(ORDER BY visited_on) rank_day
    FROM daily_table
    GROUP BY visited_on    
)

SELECT
    visited_on
    , amount
    , average_amount
FROM moving_table
WHERE rank_day>=7

/* Alternative - using joins - much better perforamance! 
WITH temp as 
(SELECT DISTINCT visited_on FROM Customer 
WHERE  DATEDIFF(visited_on,(SELECT MIN(visited_on) FROM Customer)) >= 6),

temp2 AS 
(SELECT c.*,t.visited_on as vo FROM Customer c JOIN temp t ON DATEDIFF(t.visited_on,c.visited_on) BETWEEN 0 AND 6)


SELECT vo as visited_on,SUM(amount) AS amount, ROUND(SUM(amount) / 7, 2) AS average_amount FROM temp2
GROUP BY visited_on
*/
