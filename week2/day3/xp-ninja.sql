--- 1
SELECT film.film_id, film.title, film.rating
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id AND rental.return_date IS NULL
WHERE film.rating IN ('G', 'PG')
AND rental.rental_id IS NULL;

-- 2
CREATE TABLE child_film_waitlist (
    waitlist_id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES film(film_id) ON DELETE CASCADE,
    child_name TEXT NOT NULL,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3
SELECT film.film_id, film.title, COUNT(child_film_waitlist.waitlist_id) AS num_waiting
FROM film
LEFT JOIN child_film_waitlist ON film.film_id = child_film_waitlist.film_id
WHERE film.rating IN ('G', 'PG')
GROUP BY film.film_id, film.title;

-- 4
INSERT INTO child_film_waitlist (film_id, child_name) VALUES
(1, 'Alice'),
(1, 'Bob'),
(2, 'Charlie');

-- 5
SELECT film.film_id, film.title, COUNT(child_film_waitlist.waitlist_id) AS num_waiting
FROM film
LEFT JOIN child_film_waitlist ON film.film_id = child_film_waitlist.film_id
WHERE film.rating IN ('G', 'PG')
GROUP BY film.film_id, film.title;