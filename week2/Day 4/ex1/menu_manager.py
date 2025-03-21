import psycopg2

class MenuManager:
    @classmethod
    def get_by_name(cls, name):
        """Récupère un élément par son nom."""
        try:
            conn = psycopg2.connect(
                dbname="restaurant",
                user="postgres",
                password="azer2000",
                host="localhost"
            )
            cur = conn.cursor()
            cur.execute(
                "SELECT * FROM Menu_Items WHERE item_name = %s",
                (name,)
            )
            item = cur.fetchone()
            cur.close()
            conn.close()
            return item
        except Exception as e:
            print(f"Error: {e}")
            return None

    @classmethod
    def all_items(cls):
        """Récupère tous les éléments du menu."""
        try:
            conn = psycopg2.connect(
                dbname="restaurant",
                user="postgres",
                password="azer2000",
                host="localhost"
            )
            cur = conn.cursor()
            cur.execute("SELECT * FROM Menu_Items")
            items = cur.fetchall()
            cur.close()
            conn.close()
            return items
        except Exception as e:
            print(f"Error: {e}")
            return []