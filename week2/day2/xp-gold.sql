-- Exercice 1 : Location de DVD

-- 1. Découvrez combien de films il y a pour chaque classement.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 2. Obtenez une liste de tous les films classés G ou PG-13.
SELECT title, rating
FROM film
WHERE rating IN ('G', 'PG-13');-- Exercice 1 : 

-- 1
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 2.
SELECT title, rating
FROM film
WHERE rating IN ('G', 'PG-13');

-- 3.
SELECT title, length, rental_rate
FROM film
WHERE rating IN ('G', 'PG-13')
  AND length < 120
  AND rental_rate < 3.00
ORDER BY title;

-- 4.
UPDATE customer
SET first_name = 'VotrePrénom', last_name = 'VotreNom', email = 'votre@email.com'
WHERE customer_id = 1;

-- 5
UPDATE address
SET address = '123 Votre Rue', district = 'Votre Quartier', city_id = 1 
WHERE address_id = (SELECT address_id FROM customer WHERE customer_id = 1);

-- Exercice 2 : Table des élèves

-- 1
UPDATE students
SET birth_date = '1998-11-02'
WHERE first_name IN ('Léa', 'Marc') AND last_name = 'Bénichou';

UPDATE students
SET last_name = 'Guez'
WHERE first_name = 'David' AND last_name = 'Grez';

-- 2
DELETE FROM students
WHERE first_name = 'Léa' AND last_name = 'Benichou';

-- 3
SELECT COUNT(*) AS total_students FROM students;

SELECT COUNT(*) AS students_born_after_2000
FROM students
WHERE birth_date > '2000-01-01';

-- 4
ALTER TABLE students ADD COLUMN math_grade INT;

UPDATE students SET math_grade = 80 WHERE id = 1;

UPDATE students SET math_grade = 90 WHERE id IN (2, 4);

UPDATE students SET math_grade = 40 WHERE id = 6;

SELECT COUNT(*) AS students_above_83
FROM students
WHERE math_grade > 83;

INSERT INTO students (first_name, last_name, birth_date, math_grade)
SELECT first_name, last_name, birth_date, 70
FROM students
WHERE first_name = 'Omer' AND last_name = 'Simpson';

SELECT first_name, last_name, COUNT(math_grade) AS total_grade
FROM students
GROUP BY first_name, last_name;

SELECT SUM(math_grade) AS total_grades_sum FROM students;

-- Exercice 3 : Articles et clients

-- Partie I

-- 1
CREATE TABLE purchases (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    item_id INT REFERENCES items(id),
    quantity_purchased INT NOT NULL
);

-- 2
INSERT INTO purchases (customer_id, item_id, quantity_purchased)
VALUES (
    (SELECT id FROM customers WHERE firstname = 'Scott' AND lastname = 'Scott'),
    (SELECT id FROM items WHERE name = 'Fan'),
    1
);

INSERT INTO purchases (customer_id, item_id, quantity_purchased)
VALUES (
    (SELECT id FROM customers WHERE firstname = 'Melanie' AND lastname = 'Johnson'),
    (SELECT id FROM items WHERE name = 'Large Desk'),
    10
);

INSERT INTO purchases (customer_id, item_id, quantity_purchased)
VALUES (
    (SELECT id FROM customers WHERE firstname = 'Greg' AND lastname = 'Jones'),
    (SELECT id FROM items WHERE name = 'Small Desk'),
    2
);

-- Partie II

-- 1
SELECT * FROM purchases;

-- 2
SELECT p.id, c.firstname, c.lastname, p.item_id, p.quantity_purchased
FROM purchases p
JOIN customers c ON p.customer_id = c.id;

-- 3
SELECT * FROM purchases
WHERE customer_id = 5;

-- 4
SELECT * FROM purchases
WHERE item_id IN (
    SELECT id FROM items WHERE name IN ('Large Desk', 'Small Desk')
);

-- 5
SELECT DISTINCT c.firstname, c.lastname, i.name AS item_name
FROM purchases p
JOIN customers c ON p.customer_id = c.id
JOIN items i ON p.item_id = i.id;

-- 6
INSERT INTO purchases (customer_id, quantity_purchased)
VALUES (
    (SELECT id FROM customers WHERE firstname = 'Trevor' AND lastname = 'Green'),
    5
);


-- 3. Filtrez davantage cette liste : recherchez uniquement les films de moins de 2 heures et dont le prix de location (rental_rate) est inférieur à 3,00 $. Triez la liste par ordre alphabétique.
SELECT title, length, rental_rate
FROM film
WHERE rating IN ('G', 'PG-13')
  AND length < 120
  AND rental_rate < 3.00
ORDER BY title;

-- 4. Recherchez un client dans la table des clients et modifiez ses coordonnées avec les vôtres, à l'aide de SQL UPDATE.
UPDATE customer
SET first_name = 'VotrePrénom', last_name = 'VotreNom', email = 'votre@email.com'
WHERE customer_id = 1; -- Remplacez 1 par l'ID du client que vous souhaitez modifier

-- 5. Recherchez maintenant l'adresse du client et utilisez UPDATE pour modifier l'adresse en fonction de votre adresse (ou inventez-en une).
UPDATE address
SET address = '123 Votre Rue', district = 'Votre Quartier', city_id = 1 -- Remplacez city_id par l'ID de la ville appropriée
WHERE address_id = (SELECT address_id FROM customer WHERE customer_id = 1); -- Remplacez 1 par l'ID du client

-- Exercice 2 : Table des élèves

-- 1. Mise à jour
UPDATE students
SET birth_date = '1998-11-02'
WHERE first_name IN ('Léa', 'Marc') AND last_name = 'Bénichou';

UPDATE students
SET last_name = 'Guez'
WHERE first_name = 'David' AND last_name = 'Grez';

-- 2. Supprimer
DELETE FROM students
WHERE first_name = 'Léa' AND last_name = 'Benichou';

-- 3. Compter
SELECT COUNT(*) AS total_students FROM students;

SELECT COUNT(*) AS students_born_after_2000
FROM students
WHERE birth_date > '2000-01-01';

-- 4. Insérer / Modifier
ALTER TABLE students ADD COLUMN math_grade INT;

UPDATE students SET math_grade = 80 WHERE id = 1;

UPDATE students SET math_grade = 90 WHERE id IN (2, 4);

UPDATE students SET math_grade = 40 WHERE id = 6;

SELECT COUNT(*) AS students_above_83
FROM students
WHERE math_grade > 83;

INSERT INTO students (first_name, last_name, birth_date, math_grade)
SELECT first_name, last_name, birth_date, 70
FROM students
WHERE first_name = 'Omer' AND last_name = 'Simpson';

SELECT first_name, last_name, COUNT(math_grade) AS total_grade
FROM students
GROUP BY first_name, last_name;

SELECT SUM(math_grade) AS total_grades_sum FROM students;

-- Exercice 3 : Articles et clients

-- Partie I

-- 1. Créez une table intitulée « Achats ».
CREATE TABLE Achats (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    item_id INT REFERENCES items(id),
    quantity_purchased INT
);

-- 2. Insérez les achats des clients.
INSERT INTO Achats (customer_id, item_id, quantity_purchased)
VALUES
((SELECT id FROM customers WHERE first_name = 'Scott' AND last_name = 'Scott'), (SELECT id FROM items WHERE name = 'ventilateur'), 1),
((SELECT id FROM customers WHERE first_name = 'Melanie' AND last_name = 'Johnson'), (SELECT id FROM items WHERE name = 'grand bureau'), 10),
((SELECT id FROM customers WHERE first_name = 'Greg' AND last_name = 'Jones'), (SELECT id FROM items WHERE name = 'petit bureau'), 2);

-- Partie II

-- 1. Tous les achats.
SELECT * FROM Achats;

-- 2. Tous les achats, en rejoignant la table des clients.
SELECT c.first_name, c.last_name, a.item_id, a.quantity_purchased
FROM Achats a
JOIN customers c ON a.customer_id = c.id;

-- 3. Achats du client avec l'ID égal à 5.
SELECT * FROM Achats WHERE customer_id = 5;

-- 4. Achats pour un grand bureau ET un petit bureau.
SELECT * FROM Achats
WHERE item_id IN (
    SELECT id FROM items WHERE name IN ('grand bureau', 'petit bureau')
);

-- 5. Affichez tous les clients ayant effectué un achat.
SELECT c.first_name, c.last_name, i.name AS item_name
FROM Achats a
JOIN customers c ON a.customer_id = c.id
JOIN items i ON a.item_id = i.id;

-- 6. Ajoutez une ligne qui référence un client par ID, mais pas un article par ID.
INSERT INTO Achats (customer_id, item_id, quantity_purchased)
VALUES (1, NULL, 1);