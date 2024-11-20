/*
Problem:
Table: Patients

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key (column with unique values) for this table.
'conditions' contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.
 

Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.
*/

/* Solution */
SELECT *
FROM Patients
WHERE conditions REGEXP '^DIAB1| DIAB1'

/* ALternative - using \b to denote a non-alphanumeric character, note that in this basic version of regex the notation required is \\b
SELECT *
FROM Patients
WHERE conditions REGEXP '\\bDIAB1'
*/
