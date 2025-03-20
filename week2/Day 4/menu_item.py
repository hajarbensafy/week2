import psycopg2

class MenuItem:
    def __init__(self, name, price):
        self.name = name
        self.price = price

    def save(self):
        """Enregistre un nouvel élément dans la base de données."""
        try:
            conn = psycopg2.connect(
                dbname="restaurant",
                user="postgres",
                password="your_password",
                host="localhost"
            )
            cur = conn.cursor()
            cur.execute(
                "INSERT INTO Menu_Items (item_name, item_price) VALUES (%s, %s)",
                (self.name, self.price)
            )
            conn.commit()
            cur.close()
            conn.close()
            print(f"Item '{self.name}' added successfully!")
        except Exception as e:
            print(f"Error: {e}")

    def delete(self):
        """Supprime un élément de la base de données."""
        try:
            conn = psycopg2.connect(
                dbname="restaurant",
                user="postgres",
                password="your_password",
                host="localhost"
            )
            cur = conn.cursor()
            cur.execute(
                "DELETE FROM Menu_Items WHERE item_name = %s",
                (self.name,)
            )
            conn.commit()
            cur.close()
            conn.close()
            print(f"Item '{self.name}' deleted successfully!")
        except Exception as e:
            print(f"Error: {e}")

    def update(self, new_name, new_price):
        """Met à jour un élément dans la base de données."""
        try:
            conn = psycopg2.connect(
                dbname="restaurant",
                user="postgres",
                password="your_password",
                host="localhost"
            )
            cur = conn.cursor()
            cur.execute(
                "UPDATE Menu_Items SET item_name = %s, item_price = %s WHERE item_name = %s",
                (new_name, new_price, self.name)
            )
            conn.commit()
            cur.close()
            conn.close()
            print(f"Item updated to '{new_name}' successfully!")
        except Exception as e:
            print(f"Error: {e}")