/*
Problem:
Table: Products

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |
+------------------+---------+
product_id is the primary key (column with unique values) for this table.
This table contains data about the company's products.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| order_date    | date    |
| unit          | int     |
+---------------+---------+
This table may have duplicate rows.
product_id is a foreign key (reference column) to the Products table.
unit is the number of products ordered in order_date.
 

Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
*/

/* Solution - filtering and grouping to product-level before joining product_name*/
SELECT
    product_name
    , unit
FROM (
    SELECT
        product_id
        , SUM(unit) unit
    FROM Orders
    WHERE DATE_FORMAT(order_date,'%Y-%m')='2020-02'
    GROUP BY 1
    HAVING SUM(unit)>=100
) o
JOIN Products p
ON o.product_id=p.product_id
