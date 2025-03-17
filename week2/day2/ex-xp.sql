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

-- Exercice 2 : Base de données de location de DVD

-- 1. Sélectionnez toutes les colonnes de la table « client ».
SELECT *
FROM customer;

-- 2. Affichez les noms (prénom, nom) en utilisant un alias nommé « full_name ».
SELECT first_name || ' ' || last_name AS full_name
FROM customer;

-- 3. Obtenez toutes les dates de création des comptes (sans doublons).
SELECT DISTINCT create_date
FROM customer;

-- 4. Obtenez tous les détails du client, affichés par ordre décroissant de leur prénom.
SELECT *
FROM customer
ORDER BY first_name DESC;

-- 5. Obtenez l'ID du film, le titre, la description, l'année de sortie et le tarif de location par ordre croissant en fonction de leur tarif de location.
SELECT film_id, title, description, release_year, rental_rate
FROM film
ORDER BY rental_rate ASC;

-- 6. Obtenez l'adresse et le numéro de téléphone de tous les clients vivant dans le district du Texas.
SELECT address, phone
FROM address
WHERE district = 'Texas';

-- 7. Récupérez tous les détails du film où l'ID du film est 15 ou 150.
SELECT *
FROM film
WHERE film_id IN (15, 150);

-- 8. Vérifiez si votre film préféré existe dans la base de données (remplacez 'VotreFilm' par le titre de votre film).
SELECT film_id, title, description, length, rental_rate
FROM film
WHERE title = 'VotreFilm';

-- 9. Si vous n'avez pas trouvé votre film, recherchez les films commençant par les deux premières lettres de votre film préféré.
SELECT film_id, title, description, length, rental_rate
FROM film
WHERE title LIKE 'Vo%'; -- Remplacez 'Vo' par les deux premières lettres de votre film

-- 10. Trouvez les 10 films les moins chers.
SELECT *
FROM film
ORDER BY rental_rate ASC
LIMIT 10;

-- 11. Trouvez les 10 films les moins chers suivants (sans utiliser LIMIT).
SELECT *
FROM film
ORDER BY rental_rate ASC
OFFSET 10
LIMIT 10;

-- 12. Joignez les données de la table client et de la table paiement pour obtenir le prénom, le nom, le montant et la date de chaque paiement, classés par identifiant.
SELECT c.first_name, c.last_name, p.amount, p.payment_date
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
ORDER BY c.customer_id;

-- 13. Obtenez tous les films qui ne sont pas dans l'inventaire.
SELECT f.*
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;

-- 14. Trouvez quelle ville se trouve dans quel pays.
SELECT city.city, country.country
FROM city
JOIN country ON city.country_id = country.country_id;

-- Bonus : Obtenez l'identifiant du client, son nom, le montant et la date de paiement, classés par identifiant du vendeur.
SELECT c.customer_id, c.first_name, c.last_name, p.amount, p.payment_date
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
ORDER BY c.customer_id;