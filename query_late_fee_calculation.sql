DECLARE @due_length Int =14
SELECT * from(
SELECT
    r.rental_id,
    r.customer_id,
    f.title AS film_title,
    r.rental_date,
	f.rental_rate,
    DATEADD(DAY, @due_length, r.rental_date) AS due_date,
    r.return_date,
    DATEDIFF(DAY, DATEADD(DAY, @due_length, r.rental_date), ISNULL(r.return_date, GETDATE())) AS days_late,
    CASE
        WHEN r.return_date IS NULL THEN DATEDIFF(DAY, DATEADD(DAY, @due_length, r.rental_date), GETDATE()) * (f.rental_rate * 0.01)
        ELSE DATEDIFF(DAY, DATEADD(DAY, @due_length, r.rental_date), r.return_date) * (f.rental_rate * 0.01)
    END AS late_fee
FROM
    sakila.dbo.rental r
JOIN
    sakila.dbo.inventory i ON r.inventory_id = i.inventory_id
JOIN
    sakila.dbo.film f ON i.film_id = f.film_id) as result_tab
WHERE
    result_tab.late_fee>0;
