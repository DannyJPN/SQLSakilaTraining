-- query_recent_rentals.sql

/*
This script retrieves information about all customers who rented a film in the last year.
The query returns the customer's first name, last name, and complete address (including address, address2, district, city, postal code, and country).
*/

SELECT distinct
    c.first_name,
    c.last_name,
    a.address,
    a.district,
    ci.city,
    a.postal_code,
    co.country
FROM
    sakila.dbo.rental r
JOIN
    sakila.dbo.customer c ON r.customer_id = c.customer_id
JOIN
    sakila.dbo.address a ON c.address_id = a.address_id
JOIN
    sakila.dbo.city ci ON a.city_id = ci.city_id
JOIN
    sakila.dbo.country co ON ci.country_id = co.country_id
WHERE
    year(r.rental_date) >= 2006/* DATEADD(YEAR, -1, GETDATE());*/
	/*replace with year 2006 to see effect - for "current year" there is no record*/