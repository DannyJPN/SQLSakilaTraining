-- query_late_fee_calculation.sql

/*
This script calculates the late fee for rentals. The late fee is calculated as 1% of the rental rate for each day past the due date.
Assume films are rented for 14 days. The query returns the rental ID, customer ID, film title, rental date, due date, return date, days late, and the calculated late fee.
The query handles cases where the film has not been returned yet.
*/

SELECT
    r.rental_id,
    r.customer_id,
    f.title AS film_title,
    r.rental_date,
    DATEADD(DAY, 14, r.rental_date) AS due_date,
    r.return_date,
    DATEDIFF(DAY, DATEADD(DAY, 14, r.rental_date), ISNULL(r.return_date, GETDATE())) AS days_late,
    CASE
        WHEN r.return_date IS NULL THEN DATEDIFF(DAY, DATEADD(DAY, 14, r.rental_date), GETDATE()) * (f.rental_rate * 0.01)
        ELSE DATEDIFF(DAY, DATEADD(DAY, 14, r.rental_date), r.return_date) * (f.rental_rate * 0.01)
    END AS late_fee
FROM
    rental r
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film f ON i.film_id = f.film_id
WHERE
    DATEDIFF(DAY, DATEADD(DAY, 14, r.rental_date), ISNULL(r.return_date, GETDATE())) > 0;