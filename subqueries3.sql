/*
Problem:
Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 
 

Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
*/

/* Solution */
WITH 
    movieCount AS(
        SELECT
            mr.user_id
            , name
            , COUNT(movie_id) count_movies
        FROM MovieRating mr
        JOIN Users u
            ON u.user_id=mr.user_id
        GROUP BY mr.user_id
),
    avgMovieRating AS(
        SELECT
            mr.movie_id
            , title
            , AVG(rating) avg_rating
        FROM MovieRating mr
        JOIN Movies m
            ON m.movie_id=mr.movie_id
        WHERE DATE_FORMAT(created_at,'%Y-%m')='2020-02'
        GROUP BY mr.movie_id
)

(
SELECT
    MIN(name) results
FROM movieCount
WHERE count_movies = (SELECT max(count_movies) FROM movieCount)
)
UNION ALL
(
SELECT 
    MIN(title)
FROM avgMovieRating
WHERE avg_rating = (SELECT max(avg_rating) FROM avgMovieRating)
)
