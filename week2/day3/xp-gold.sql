-- Exercice 1 : Location de DVD

-- 1
SELECT film.film_id, film.title
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.return_date IS NULL;

-- 2
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
WHERE rental.return_date IS NULL
GROUP BY customer.customer_id;

-- 3
SELECT film.title
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE actor.first_name = 'Joe' AND actor.last_name = 'Swank'
AND category.name = 'Action';

-- Exercice 2 – Joyeux Halloween

-- 1
SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 2
SELECT store.store_id, SUM(film.length) AS total_viewing_minutes
FROM inventory
JOIN store ON inventory.store_id = store.store_id
JOIN film ON inventory.film_id = film.film_id
WHERE inventory.inventory_id NOT IN (
    SELECT inventory_id FROM rental WHERE return_date IS NULL
)
GROUP BY store.store_id;

-- 3
SELECT DISTINCT customer.customer_id, customer.first_name, customer.last_name, city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN store ON city.city_id = (
    SELECT address.city_id FROM store WHERE store.store_id = store.store_id
);

-- 4
SELECT DISTINCT customer.customer_id, customer.first_name, customer.last_name, country.country
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
JOIN store ON country.country_id = (
    SELECT country.country_id FROM store JOIN address ON store.address_id = address.address_id JOIN city ON address.city_id = city.city_id JOIN country ON city.country_id = country.country_id WHERE store.store_id = store.store_id
);

-- 5
SELECT film.title, SUM(film.length) AS total_viewing_minutes
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name != 'Horror'
AND (film.title NOT ILIKE '%beast%' AND film.title NOT ILIKE '%monster%' AND film.title NOT ILIKE '%ghost%' AND film.title NOT ILIKE '%dead%' AND film.title NOT ILIKE '%zombie%' AND film.title NOT ILIKE '%undead%')
AND (film.description NOT ILIKE '%beast%' AND film.description NOT ILIKE '%monster%' AND film.description NOT ILIKE '%ghost%' AND film.description NOT ILIKE '%dead%' AND film.description NOT ILIKE '%zombie%' AND film.description NOT ILIKE '%undead%')
GROUP BY film.title;

-- 6
SELECT store.store_id, 
       SUM(film.length) AS total_viewing_minutes,
       SUM(film.length) / 60 AS total_viewing_hours,
       SUM(film.length) / 1440 AS total_viewing_days
FROM inventory
JOIN store ON inventory.store_id = store.store_id
JOIN film ON inventory.film_id = film.film_id
WHERE inventory.inventory_id NOT IN (
    SELECT inventory_id FROM rental WHERE return_date IS NULL
)
GROUP BY store.store_id;