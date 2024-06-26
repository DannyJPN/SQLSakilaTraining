
SELECT
    c.name AS category,
    COUNT(f.film_id) AS film_count
FROM
    sakila.dbo.film f
JOIN
    sakila.dbo.film_category fc ON f.film_id = fc.film_id
JOIN
    sakila.dbo.category c ON fc.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    c.name;