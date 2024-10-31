/* 
Problem:
Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
*/

/* Solution */
WITH cte AS ( 
    SELECT 
        *
        , SUM(CASE WHEN order_date=customer_pref_delivery_date THEN 1 ELSE 0 END) immediate_order
        , MIN(order_date) OVER(PARTITION BY customer_id) first_order_date
    FROM Delivery
    GROUP BY delivery_id
)

SELECT 
    ROUND(SUM(immediate_order)/COUNT(*)*100,2) immediate_percentage
FROM cte
WHERE order_date=first_order_date
