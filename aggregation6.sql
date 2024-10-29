/*
Problem:
Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.
*/

/* Solution */
SELECT
    Date_format(trans_date,'%Y-%m') month
    , country
    , COUNT(*) trans_count
    , SUM(CASE WHEN state='approved' THEN 1 ELSE 0 END) approved_count
    , SUM(amount) trans_total_amount
    , SUM(CASE WHEN state='approved' THEN amount ELSE 0 END) approved_total_amount
FROM Transactions
GROUP BY 1,2
