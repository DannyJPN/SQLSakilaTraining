

SELECT
    s.store_id,
    st.store_name,
    e.staff_id,
    e.first_name + ' ' + e.last_name AS employee_name,
    YEAR(r.rental_date) AS rental_year,
    COUNT(r.rental_id) AS rental_count
FROM
    sakila.dbo.rental r
JOIN
    sakila.dbo.staff e ON r.staff_id = e.staff_id
JOIN
    sakila.dbo.store s ON e.store_id = s.store_id
JOIN
    (SELECT store_id, address + ', ' + city + ', ' + country AS store_name
     FROM sakila.dbo.store
     JOIN sakila.dbo.address ON store.address_id = address.address_id
     JOIN sakila.dbo.city ON address.city_id = city.city_id
     JOIN sakila.dbo.country ON city.country_id = country.country_id) st ON s.store_id = st.store_id
GROUP BY
    s.store_id,
    st.store_name,
    e.staff_id,
    e.first_name,
    e.last_name,
    YEAR(r.rental_date)
ORDER BY
    s.store_id,
    rental_year;