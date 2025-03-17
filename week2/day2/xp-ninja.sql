-- 1. Récupérez les 2 derniers clients par ordre alphabétique (AZ) – excluez « id » des résultats.
SELECT first_name, last_name
FROM customers
ORDER BY first_name DESC
LIMIT 2;

-- 2. Utilisez SQL pour supprimer tous les achats effectués par Scott.
DELETE FROM Achats
WHERE customer_id = (SELECT id FROM customers WHERE first_name = 'Scott' AND last_name = 'Scott');

-- 3. Scott existe-t-il toujours dans la table des clients, même s'il a été supprimé ? Essayez de le retrouver.
SELECT *
FROM customers
WHERE first_name = 'Scott' AND last_name = 'Scott';

-- 4. Utilisez SQL pour trouver tous les achats. Joignez les achats à la table des clients afin que la commande de Scott apparaisse, mais au lieu du prénom et du nom du client, vous ne devriez voir que des valeurs vides. (Quel type de jointure utiliser ?)
-- Utilisation d'une jointure LEFT JOIN pour inclure toutes les lignes de la table Achats, même si le client correspondant n'existe plus.
SELECT a.id, a.customer_id, a.item_id, a.quantity_purchased, c.first_name, c.last_name
FROM Achats a
LEFT JOIN customers c ON a.customer_id = c.id;

-- 5. Utilisez SQL pour trouver tous les achats. Joignez les achats à la table des clients afin que la commande de Scott n'apparaisse pas. (Quel type de jointure utiliser ?)
-- Utilisation d'une jointure INNER JOIN pour exclure les achats sans client correspondant.
SELECT a.id, a.customer_id, a.item_id, a.quantity_purchased, c.first_name, c.last_name
FROM Achats a
INNER JOIN customers c ON a.customer_id = c.id;