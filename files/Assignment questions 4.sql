
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       f.title
FROM customer c
JOIN rental r
  ON c.customer_id = r.customer_id
JOIN inventory i
  ON r.inventory_id = i.inventory_id
JOIN film f
  ON i.film_id = f.film_id
ORDER BY c.customer_id, f.title;

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r
  ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC, c.customer_id;

SELECT f.film_id,
       f.title,
       c.name AS category_name
FROM film f
LEFT JOIN film_category fc
  ON f.film_id = fc.film_id
LEFT JOIN category c
  ON fc.category_id = c.category_id
ORDER BY f.title;

SELECT c.first_name AS customer_first_name,
       c.last_name AS customer_last_name,
       c.email AS customer_email,
       s.first_name AS staff_first_name,
       s.last_name AS staff_last_name,
       s.email AS staff_email
FROM customer c
LEFT JOIN staff s
  ON c.email = s.email

UNION

SELECT c.first_name AS customer_first_name,
       c.last_name AS customer_last_name,
       c.email AS customer_email,
       s.first_name AS staff_first_name,
       s.last_name AS staff_last_name,
       s.email AS staff_email
FROM customer c
RIGHT JOIN staff s
  ON c.email = s.email;
  
  SELECT a.actor_id,
       a.first_name,
       a.last_name
FROM actor a
JOIN film_actor fa
  ON a.actor_id = fa.actor_id
JOIN film f
  ON fa.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
ORDER BY a.last_name, a.first_name;

SELECT st.store_id,
       COUNT(sf.staff_id) AS total_staff
FROM store st
LEFT JOIN staff sf
  ON st.store_id = sf.store_id
GROUP BY st.store_id
ORDER BY st.store_id;

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r
  ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) > 5
ORDER BY total_rentals DESC, c.customer_id;