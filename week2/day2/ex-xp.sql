-- Exercice 1 : Articles et clients

-- 1. Tous les articles, classés par prix (du plus bas au plus élevé).
SELECT *
FROM items
ORDER BY price ASC;

-- 2. Articles avec un prix supérieur à 80 (80 inclus), classés par prix (du plus élevé au plus bas).
SELECT *
FROM items
WHERE price >= 80
ORDER BY price DESC;

-- 3. Les 3 premiers clients par ordre alphabétique du prénom (AZ) – excluez la colonne de clé primaire des résultats.
SELECT first_name, last_name
FROM customers
ORDER BY first_name ASC
LIMIT 3;

-- 4. Tous les noms de famille (pas d'autres colonnes !), dans l'ordre alphabétique inverse (ZA).
SELECT last_name
FROM customers
ORDER BY last_name DESC;

-- Exercice 2 :

-- 1
SELECT *
FROM customer;

-- 2
SELECT first_name || ' ' || last_name AS full_name
FROM customer;

-- 3
SELECT DISTINCT create_date
FROM customer;

-- 4
SELECT *
FROM customer
ORDER BY first_name DESC;

-- 5. 
SELECT film_id, title, description, release_year, rental_rate
FROM film
ORDER BY rental_rate ASC;

-- 6
SELECT address, phone
FROM address
WHERE district = 'Texas';

-- 7
SELECT *
FROM film
WHERE film_id IN (15, 150);

-- 8
SELECT film_id, title, description, length, rental_rate
FROM film
WHERE title = 'VotreFilm';

-- 9
SELECT film_id, title, description, length, rental_rate
FROM film
WHERE title LIKE 'Vo%'; 

-- 10
SELECT *
FROM film
ORDER BY rental_rate ASC
LIMIT 10;

-- 11
SELECT *
FROM film
ORDER BY rental_rate ASC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

-- 12
SELECT c.first_name, c.last_name, p.amount, p.payment_date
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
ORDER BY c.customer_id;

-- 13.
SELECT f.*
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;

-- 14
SELECT city.city, country.country
FROM city
JOIN country ON city.country_id = country.country_id;

-- Bonus :
SELECT c.customer_id, c.first_name, c.last_name, p.amount, p.payment_date
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
ORDER BY c.customer_id;
