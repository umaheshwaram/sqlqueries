USE sakila;
-- STRING FUNCTIONS
-- CONCAT
SELECT actor_id, CONCAT(first_name, ' ', last_name) AS full_name
FROM actor;
-- UPPER
SELECT first_name, UPPER(first_name) AS upper_name
FROM actor;
-- LOWER()
SELECT email, LOWER(email) AS lower_email
FROM customer;
-- LENGTH()
SELECT title, LENGTH(title) AS title_length
FROM film;

SELECT title, SUBSTRING(title, 1, 5) AS first_five_chars
FROM film;

SELECT first_name, LEFT(first_name, 3) AS first3
FROM actor;
SELECT last_name, RIGHT(last_name, 2) AS last2
FROM actor;
-- TRIM()
SELECT CONCAT('   ', first_name, '   ') AS original_text,
       TRIM(CONCAT('   ', first_name, '   ')) AS trimmed_text
FROM actor;
-- REPLACE
SELECT title, REPLACE(title, 'A', '@') AS modified_title
FROM film;
-- LOCATE
SELECT title, LOCATE('LOVE', description) AS love_position
FROM film;
-- INSTR
SELECT first_name, INSTR(first_name, 'A') AS position_of_a
FROM actor;

-- LPAD() and RPAD()

SELECT first_name,
       LPAD(first_name, 10, '*') AS left_padded
FROM actor;
SELECT first_name,
       RPAD(first_name, 10, '-') AS right_padded
FROM actor;

-- REVERSE()
SELECT first_name, REVERSE(first_name) AS reversed_name
FROM actor;
 -- DISTINCT with string function
SELECT DISTINCT UPPER(district) AS district_name
FROM address;
-- String functions with WHERE
SELECT first_name, last_name
FROM actor
WHERE LEFT(first_name, 2) = 'ED';
-- String functions with GROUP BY
SELECT SUBSTRING_INDEX(email, '@', -1) AS domain, COUNT(*) AS total_customers
FROM customer
GROUP BY SUBSTRING_INDEX(email, '@', -1);
-- Numeric functions
-- ROUND()
SELECT amount, ROUND(amount, 1) AS rounded_amount
FROM payment;

-- CEIL() / CEILING()
SELECT amount, CEIL(amount) AS rounded_up
FROM payment;
--  FLOOR()
SELECT amount, FLOOR(amount) AS rounded_down
FROM payment;
-- ABS()
SELECT amount, ABS(amount - 5) AS difference_from_5
FROM payment;
-- MOD
SELECT customer_id, MOD(customer_id, 2) AS remainder
FROM customer;
-- POWER()
SELECT rental_rate, POWER(rental_rate, 2) AS rate_squared
FROM film;
--  SQRT()
SELECT replacement_cost, SQRT(replacement_cost) AS sqrt_cost
FROM film;
-- TRUNCATE()
SELECT amount, TRUNCATE(amount, 1) AS truncated_amount
FROM payment;
-- AVG(), SUM(), MAX(), MIN(), COUNT()
SELECT AVG(amount) AS avg_payment
FROM payment;
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;
-- Highest and lowest rental rate
SELECT MAX(rental_rate) AS highest_rate,
       MIN(rental_rate) AS lowest_rate
FROM film;
-- Count films per rating
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating;
-- Numeric function with CASE
SELECT payment_id, amount,
       CASE
         WHEN amount < 3 THEN 'Low'
         WHEN amount BETWEEN 3 AND 6 THEN 'Medium'
         ELSE 'High'
       END AS payment_level
FROM payment;
-- Numeric function with HAVING
SELECT customer_id, ROUND(SUM(amount), 2) AS total_paid
FROM payment
GROUP BY customer_id
HAVING ROUND(SUM(amount), 2) > 100;
-- Date and time functions
--  NOW()
SELECT NOW() AS current_datetime;
-- CURDATE()
SELECT CURDATE() AS current_date;
-- 3. CURTIME()
SELECT CURTIME() AS current_time;
-- YEAR()
SELECT payment_id, payment_date, YEAR(payment_date) AS payment_year
FROM payment;
-- MONTH()
SELECT payment_id, payment_date, MONTH(payment_date) AS payment_month
FROM payment;
-- MONTHNAME()
SELECT payment_id, payment_date, MONTHNAME(payment_date) AS month_name
FROM payment;
 -- DAY(), DAYNAME()
SELECT rental_id, rental_date,
       DAY(rental_date) AS day_of_month,
       DAYNAME(rental_date) AS weekday
FROM rental;
-- TIMESTAMPDIFF
SELECT rental_id, rental_date, return_date,
       TIMESTAMPDIFF(HOUR, rental_date, return_date) AS rental_hours
FROM rental
WHERE return_date IS NOT NULL;
-- 13. DATE_ADD()
SELECT rental_id, rental_date,
       DATE_ADD(rental_date, INTERVAL 7 DAY) AS due_after_7_days
FROM rental;
-- . DATE_SUB()
SELECT payment_id, payment_date,
       DATE_SUB(payment_date, INTERVAL 1 MONTH) AS one_month_before
FROM payment;
-- 15. DATE_FORMAT()
SELECT payment_id,
       payment_date,
       DATE_FORMAT(payment_date, '%d-%m-%Y') AS formatted_date
FROM payment;
-- Grouping by date parts
SELECT YEAR(payment_date) AS payment_year,
       SUM(amount) AS total_revenue
FROM payment
WHERE YEAR(payment_date) = 2005;


