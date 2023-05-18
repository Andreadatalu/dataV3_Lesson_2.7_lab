USE sakila;

-- 1 How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT category.name AS 'Category', count(film_category.film_id) as num_films
from sakila.category
join sakila.film_category
on category.category_id = film_category.category_id
group by category.name;

-- 2 Display the total amount rung up by each staff member in August of 2005

SELECT * FROM sakila.payment;

SELECT payment.staff_id, SUM(payment.amount) AS total_amount
FROM sakila.payment
JOIN sakila.rental 
ON payment.rental_id = rental.rental_id
WHERE EXTRACT(YEAR_MONTH FROM rental.rental_date) = '200508'
GROUP BY payment.staff_id;

-- 3 Which actor has appeared in the most films?
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.actor;
SELECT * FROM sakila.film;
-- Option one:
SELECT fa.actor_id, COUNT(film.film_id) AS film_count
FROM sakila.film_actor fa
JOIN sakila.film ON fa.film_id = film.film_id
GROUP BY fa.actor_id
ORDER BY film_count DESC
LIMIT 1;
-- Option two:
SELECT fa.actor_id, a.first_name, COUNT(film.film_id) AS film_count
FROM sakila.film_actor fa
JOIN sakila.film ON fa.film_id = film.film_id
JOIN sakila.actor a ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id, a.first_name
ORDER BY film_count DESC
LIMIT 1;

-- 4 Most active customer (the customer that has rented the most number of films)
SELECT * FROM sakila.customer;
SELECT * FROM sakila.rental;

SELECT c.customer_id, c.first_name, COUNT(r.rental_id) AS Total_Rental
FROM sakila.rental r
JOIN sakila.customer c ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name
ORDER BY Total_Rental DESC
LIMIT 1;

-- 5 Display the first and last names, as well as the address, of each staff member.
SELECT * FROM sakila.staff;
SELECT * FROM sakila.address;

SELECT staff_id, first_name, last_name, a.address 
FROM sakila.staff s
JOIN sakila.address a ON a.address_id = s.address_id
GROUP BY s.staff_id, s.first_name;

-- 6 List each film and the number of actors who are listed for that film.
SELECT * FROM sakila.film;
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.actor;
SELECT COUNT(actor_id) FROM sakila.actor;

SELECT f.film_id, f.title, COUNT(fa.actor_id) AS num_actors
FROM sakila.film f
JOIN sakila.film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title;


-- 7 Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.

SELECT * FROM sakila.payment;
SELECT * FROM sakila.customer;

SELECT p.customer_id,  c.last_name, SUM(p.amount) AS 'total_amount_client'
FROM sakila.payment p
JOIN sakila.customer c ON p.customer_id = c.customer_id
GROUP BY p.customer_id, 'total_amount_client', c.last_name
ORDER BY last_name ASC;

-- ****************** LAB 2.08 PARTll

-- 1 Write a query to display for each store its store ID, city, and country.
SELECT * FROM sakila.store;
SELECT * FROM sakila.country;
SELECT * FROM sakila.city;

SELECT store.store_id, city.city, country.country
FROM sakila.store
JOIN sakila.address ON store.address_id = address.address_id
JOIN sakila.city ON address.city_id = city.city_id
JOIN sakila.country ON city.country_id = country.country_id;

-- 2 Write a query to display how much business, in dollars, each store brought in.

SELECT * FROM sakila.payment;
SELECT * FROM sakila.staff;

SELECT store.store_id, SUM(payment.amount) AS total_business
FROM sakila.store
JOIN sakila.staff ON store.store_id = staff.store_id
JOIN sakila.payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 3 Which film categories are longest?

SELECT category.name AS category_name, AVG(film.length) AS average_length
FROM sakila.category
JOIN sakila.film_category ON category.category_id = film_category.category_id
JOIN sakila.film ON film_category.film_id = film.film_id
GROUP BY category.category_id, category_name
ORDER BY average_length DESC;

-- 4 Display the most frequently rented movies in descending order.
SELECT * FROM sakila.film;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.payment;
