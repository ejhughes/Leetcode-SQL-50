/*
Problem:
Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.
 

Write a solution to select the product id, year, quantity, and price for the first year of every product sold.
*/

/* Solution */
WITH cte AS (
    SELECT
        product_id
        , MIN(year) first_year
    FROM Sales
    GROUP BY product_id
)


SELECT 
    p.product_id
    , first_year
    , quantity
    , price
FROM Product p
LEFT JOIN Sales s
    ON p.product_id=s.product_id
    JOIN cte
        ON s.product_id = cte.product_id AND year=first_year

/* Alternative - doesn't join to Product table? Therefore assumes every product had a sale
select product_id,year as first_year, quantity, price
from Sales
where(product_id, year) in (select  product_id, min(year) from Sales group by product_id)
*/
