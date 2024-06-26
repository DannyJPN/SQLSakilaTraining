-- query_rentals_by_employee.sql

/*
This script returns the number of rentals made by each employee for each year, broken down by store.
The query joins the rental, staff, and store tables to get the employee's name, store name, year of rental, and the count of rentals.
The results are grouped by store, employee, and year, and ordered by store and year.
*/

SELECT
    s.store_id,
    st.store_name,
    e.staff_id,
    e.first_name + ' ' + e.last_name AS employee_name,
    YEAR(r.rental_date) AS rental_year,
    COUNT(r.rental_id) AS rental_count
FROM
    rental r
JOIN
    staff e ON r.staff_id = e.staff_id
JOIN
    store s ON e.store_id = s.store_id
JOIN
    (SELECT store_id, address + ', ' + city + ', ' + country AS store_name
     FROM store
     JOIN address ON store.address_id = address.address_id
     JOIN city ON address.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id) st ON s.store_id = st.store_id
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