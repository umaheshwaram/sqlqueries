-- customers who made more than 5 payments using subquery
SELECT customer_id, 
first_name, 
last_name
FROM customer
WHERE customer_id IN (
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING COUNT(*)> 5
);

-- name of actors who acted in more than 10 films

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
SELECT actor_id
FROM film_actor
GROUP BY actor_id
HAVING COUNT(*)> 10
);

-- names of customers who neve made a payment

SELECT customer_id, 
first_name, 
last_name
FROM customer
WHERE customer_id NOT IN(
SELECT customer_id
FROM payment
);

-- films having rental rate higher than avergae rental rate of all films
SELECT rental_rate,title
FROM film
WHERE rental_rate>(
SELECT AVG(rental_rate)
FROM film 
);

-- list titles of films that were never rented
SELECT title, film_id
FROM film
WHERE NOT EXISTS (
SELECT *
FROM inventory i
JOIN rental r
ON  i.inventory_id = r.inventory_i
WHERE f.film_id=i.film_id
);

-- Display who rented films in same month as customer with id 5
WITH customer5_months AS (
    SELECT DISTINCT MONTH(rental_date) AS month_val
    FROM rental
    WHERE customer_id = 5
)
SELECT DISTINCT r.customer_id
FROM rental r
JOIN customer5_months c
ON MONTH(r.rental_date) = c.month_val
WHERE r.customer_id <> 5;

-- finding staff member who handled payment greather than average payment
WITH avg_payment AS (
    SELECT AVG(amount) AS avg_amt
    FROM payment
)
SELECT DISTINCT s.staff_id, s.first_name, s.last_name
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
JOIN avg_payment a
ON p.amount > a.avg_amt;

-- show title and rental duration of film whose duration is greater than the average

WITH avg_duration AS (
    SELECT AVG(rental_duration) AS avg_val
    FROM film
)
SELECT title, rental_duration
FROM film, avg_duration
WHERE rental_duration > avg_val;

-- Find all customers who have the same address as customer with ID 1.
CREATE TEMPORARY TABLE temp_address AS
SELECT address_id
FROM customer
WHERE customer_id = 1;

SELECT customer_id, first_name, last_name
FROM customer
WHERE address_id IN (
    SELECT address_id FROM temp_address
)
AND customer_id <> 1;

-- List all payments that are greater than the average of all payments.
-- create view
CREATE VIEW avg_payment_view AS
SELECT AVG(amount) AS avg_amt
FROM payment;
SELECT p.payment_id, p.customer_id, p.amount
FROM payment p, avg_payment_view v
WHERE p.amount > v.avg_amt;
