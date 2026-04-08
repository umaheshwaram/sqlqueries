-- USING IN
-- Show all films for a given rating.
DELIMITER //

CREATE PROCEDURE GetFilmsByRating(IN p_rating VARCHAR(10))
BEGIN
    SELECT film_id, title, rating, rental_rate
    FROM film
    WHERE rating = p_rating;
END //

DELIMITER ;
CALL GetFilmsByRating('PG');

-- USING OUT
-- Count how many rentals a customer made.
DELIMITER //

CREATE PROCEDURE GetCustomerRentalCount(
    IN p_customer_id INT,
    OUT p_total_rentals INT
)
BEGIN
    SELECT COUNT(*)
    INTO p_total_rentals
    FROM rental
    WHERE customer_id = p_customer_id;
END //

DELIMITER ;
CALL GetCustomerRentalCount(1, @total);
SELECT @total;

-- INOUT
-- Add a bonus amount to a payment value.
DELIMITER //

CREATE PROCEDURE AddBonus(
    INOUT p_amount DECIMAL(5,2)
)
BEGIN
    SET p_amount = p_amount + 5.00;
END //

DELIMITER ;
SET @amt = 10.00;
CALL AddBonus(@amt);
SELECT @amt;
-- Procedure for total amount paid by a customer
DELIMITER //

CREATE PROCEDURE GetCustomerTotalPayment(
    IN p_customer_id INT,
    OUT p_total_payment DECIMAL(10,2)
)
BEGIN
    SELECT IFNULL(SUM(amount), 0)
    INTO p_total_payment
    FROM payment
    WHERE customer_id = p_customer_id;
END //

DELIMITER ;
CALL GetCustomerTotalPayment(1, @total_paid);
SELECT @total_paid;

