USE sakila;
SELECT * 
FROM actor;
SELECT first_name, last_name

FROM actor;
SELECT title, rental_rate
FROM film;

-- SELECT DISTINCT
SELECT DISTINCT rating
FROM film;
SELECT DISTINCT active
FROM customer;

-- WHERE clause
SELECT title, rental_rate
FROM film
WHERE rental_rate > 2.99;

-- ORDER BY
SELECT title, release_year
FROM film
ORDER BY title ASC; 

SELECT customer_id, amount, payment_date
FROM payment
ORDER BY amount DESC;

-- LIMIT 
SELECT customer_id, amount
FROM payment
ORDER BY amount DESC
LIMIT 10;

-- LIKE and wildcards
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'A%';

SELECT first_name, last_name
FROM customer
WHERE last_name LIKE '%SON';

SELECT title, description
FROM film
WHERE description LIKE '%LOVE%';

SELECT first_name
FROM actor
WHERE first_name LIKE '____';

-- IN operator
SELECT title, rating
FROM film
WHERE rating IN ('G', 'PG', 'PG-13');

SELECT first_name, last_name, store_id
FROM customer
WHERE store_id IN (1, 2);

-- BETWEEN operator
SELECT customer_id, amount
FROM payment
WHERE amount BETWEEN 2 AND 5;

-- IS NULL / IS NOT NULL
SELECT address, address2
FROM address
WHERE address2 IS NULL;
SELECT address, address2
FROM address
WHERE address2 IS NOT NULL;

-- Aliases
SELECT first_name AS actor_first_name, last_name AS actor_last_name
FROM actor;
SELECT c.first_name, c.last_name, c.email
FROM customer c;

-- Aggregate functions
SELECT COUNT(*) AS total_actors
FROM actor;
SELECT COUNT(*) AS total_films
FROM film;
SELECT AVG(rental_rate) AS avg_rental_rate
FROM film;
SELECT MAX(amount) AS max_payment, MIN(amount) AS min_payment
FROM payment;

 -- GROUP BY
SELECT store_id, COUNT(*) AS total_customers
FROM customer
GROUP BY store_id;

SELECT customer_id, AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id;

--  HAVING
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating
HAVING COUNT(*) > 200;

SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
-- CASE expressions
SELECT title, length,
       CASE
           WHEN length < 60 THEN 'Short'
           WHEN length BETWEEN 60 AND 120 THEN 'Medium'
           ELSE 'Long'
       END AS film_length_category
FROM film;
SELECT customer_id, amount,
       CASE
           WHEN amount < 3 THEN 'Low'
           WHEN amount BETWEEN 3 AND 6 THEN 'Medium'
           ELSE 'High'
       END AS payment_category
FROM payment;

-- Combined queries using multiple concepts
SELECT title, rental_rate, rating
FROM film
WHERE rental_rate BETWEEN 2 AND 4
  AND rating IN ('PG', 'PG-13')
ORDER BY rental_rate DESC;

SELECT language_id, COUNT(*) AS total_films
FROM film
GROUP BY language_id;

SELECT language_id, COUNT(*) AS total_films
FROM film
GROUP BY language_id;