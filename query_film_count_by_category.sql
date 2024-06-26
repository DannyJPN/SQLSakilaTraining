-- query_film_count_by_category.sql

/*
This script returns the count of films in each film category.
The query joins the film, film_category, and category tables to get the category name and the count of films in each category.
The results are grouped by category name and ordered alphabetically.
*/

SELECT
    c.name AS category,
    COUNT(f.film_id) AS film_count
FROM
    film f
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    c.name;