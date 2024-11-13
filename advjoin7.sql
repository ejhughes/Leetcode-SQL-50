/* 
Problem:
Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

*/

/* Solution - create a Lookup Table? */
WITH lookup AS(
SELECT 
    'Low Salary' category
UNION SELECT 'Average Salary'
UNION SELECT 'High Salary'
)

SELECT category
    , IFNULL(c.accounts_count,0) accounts_count
FROM lookup
LEFT JOIN
    (
    SELECT
        CASE 
            WHEN IFNULL(income < 20000,0) THEN 'Low Salary'
            WHEN IFNULL(income <=50000,0) THEN 'Average Salary'
            ELSE 'High Salary'
        END 
            cat
        , COUNT(account_id) accounts_count
    FROM Accounts
    GROUP BY cat
    ) c
ON c.cat=lookup.category

/* Alternative - using Unions
SELECT 
    'Low Salary' AS category,
    SUM(income < 20000) AS accounts_count
FROM 
    Accounts

UNION 

    SELECT 
        'Average Salary' AS category,
        SUM(income BETWEEN 20000 AND 50000 ) AS accounts_count
    FROM 
        Accounts

UNION

    SELECT 
        'High Salary' AS category,
        SUM(income > 50000) AS accounts_count
    FROM 
        Accounts;
*/

