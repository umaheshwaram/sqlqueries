
-- CTE
-- Total rentals by each customer
WITH customer_rentals AS (
    SELECT customer_id, COUNT(*) AS total_rentals
    FROM rental
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, cr.total_rentals
FROM customer c
JOIN customer_rentals cr
ON c.customer_id = cr.customer_id
ORDER BY cr.total_rentals DESC;

-- Total payment made by each customer
WITH customer_payments AS (
    SELECT customer_id, SUM(amount) AS total_paid
    FROM payment
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, cp.total_paid
FROM customer c
JOIN customer_payments cp
ON c.customer_id = cp.customer_id
ORDER BY cp.total_paid DESC;

-- Temporary Tables 
-- Store customer payment totals

CREATE TEMPORARY TABLE temp_customer_payments AS
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;
SELECT c.customer_id, c.first_name, c.last_name, t.total_paid
FROM customer c
JOIN temp_customer_payments t
ON c.customer_id = t.customer_id
ORDER BY t.total_paid DESC;

-- Store films with inventory count
CREATE TEMPORARY TABLE temp_film_inventory AS
SELECT film_id, COUNT(*) AS copy_count
FROM inventory
GROUP BY film_id;
SELECT f.film_id, f.title, t.copy_count
FROM film f
JOIN temp_film_inventory t
ON f.film_id = t.film_id
ORDER BY t.copy_count DESC, f.title;

-- VIEWS
-- Customer rental summary
CREATE VIEW customer_rental_summary AS
SELECT customer_id, COUNT(*) AS total_rentals
FROM rental
GROUP BY customer_id;
SELECT c.customer_id, c.first_name, c.last_name, v.total_rentals
FROM customer c
JOIN customer_rental_summary v
ON c.customer_id = v.customer_id
ORDER BY v.total_rentals DESC;

-- Film with category
CREATE VIEW film_category_view AS
SELECT f.film_id, f.title, c.name AS category_name
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id;
SELECT *
FROM film_category_view
ORDER BY title;



