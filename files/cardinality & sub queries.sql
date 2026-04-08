-- one to one
SELECT s.store_id, st.staff_id, st.first_name, st.last_name
FROM store s
JOIN staff st
ON s.manager_staff_id = st.staff_id;

-- one to many
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
ORDER BY c.customer_id, r.rental_date;

-- Many to one
SELECT r.rental_id, r.rental_date, c.customer_id, c.first_name, c.last_name
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
ORDER BY r.rental_id;

SELECT c.customer_id, c.first_name, c.last_name, s.store_id
FROM customer c
JOIN store s
ON c.store_id = s.store_id
ORDER BY s.store_id, c.customer_id;

SELECT a.address_id, a.address, ci.city_id, ci.city
FROM address a
JOIN city ci
ON a.city_id = ci.city_id
ORDER BY ci.city, a.address;

-- Many to many
SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
JOIN actor a
ON fa.actor_id = a.actor_id
ORDER BY f.title, a.last_name;

SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
ORDER BY a.actor_id, f.title;

-- SUBQUERIES

-- Find customers who made rentals from store 1 inventory
SELECT DISTINCT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM inventory
        WHERE store_id = 1
    )
);

-- films whose length is greater than the average length of films in the same rating
SELECT f1.title, f1.length, f1.rating
FROM film f1
WHERE f1.length > (
    SELECT AVG(f2.length)
    FROM film f2
    WHERE f2.rating = f1.rating
);

-- customers who have made at least one rental
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.customer_id = c.customer_id
);



