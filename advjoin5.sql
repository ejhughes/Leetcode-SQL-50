/*
Problem
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
*/

/* Solution */
SELECT
    p.product_id
    , CASE WHEN ISNULL(max_date) THEN 10 ELSE new_price END price
FROM Products p
LEFT JOIN (
    SELECT 
        product_id
        , MAX(change_date) max_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
    ) q
ON p.product_id=q.product_id
WHERE change_date=max_date or ISNULL(max_date)
GROUP BY product_id
