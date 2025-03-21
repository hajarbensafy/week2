from fastapi import FastAPI, HTTPException
import psycopg2
from pydantic import BaseModel
import uvicorn

app = FastAPI()

class MenuItem(BaseModel):
    name: str
    price: float

def get_db_connection():
    return psycopg2.connect(
        dbname="restaurant",
        user="postgres",
        password="azer2000",
        host="localhost",
        port="5432"
    )

@app.get("/menu", response_model=list[MenuItem])
def get_menu():
    """Récupère tous les éléments du menu."""
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        cur.execute("SELECT item_name, item_price FROM Menu_Items")
        items = [MenuItem(name=row[0], price=row[1]) for row in cur.fetchall()]
        return items
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cur.close()
        conn.close()

@app.get("/menu/{name}", response_model=MenuItem)
def get_menu_item(name: str):
    """Récupère un élément du menu par son nom."""
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        cur.execute("SELECT item_name, item_price FROM Menu_Items WHERE item_name = %s", (name,))
        row = cur.fetchone()
        if row:
            return MenuItem(name=row[0], price=row[1])
        raise HTTPException(status_code=404, detail="Item not found")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cur.close()
        conn.close()

@app.post("/menu")
def add_menu_item(item: MenuItem):
    """Ajoute un nouvel élément au menu."""
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        cur.execute("INSERT INTO Menu_Items (item_name, item_price) VALUES (%s, %s)", (item.name, item.price))
        conn.commit()
        return {"message": "Item added successfully"}
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cur.close()
        conn.close()

@app.put("/menu/{name}")
def update_menu_item(name: str, item: MenuItem):
    """Met à jour un élément du menu."""
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        cur.execute("UPDATE Menu_Items SET item_name = %s, item_price = %s WHERE item_name = %s", (item.name, item.price, name))
        conn.commit()
        return {"message": "Item updated successfully"}
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cur.close()
        conn.close()

@app.delete("/menu/{name}")
def delete_menu_item(name: str):
    """Supprime un élément du menu."""
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        cur.execute("DELETE FROM Menu_Items WHERE item_name = %s", (name,))
        conn.commit()
        return {"message": "Item deleted successfully"}
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    uvicorn.run("menu_editor:app", host="127.0.0.1", port=8000, reload=True)