import sqlite3
import requests
import random

def connect_db():
    return sqlite3.connect('countries.db')

def create_table():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS countries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            capital TEXT,
            flag TEXT,
            subregion TEXT,
            population INTEGER
        )
    ''')
    conn.commit()
    conn.close()

# Récupérer 10 pays aléatoires depuis l'API
def fetch_random_countries():
    url = "https://restcountries.com/v3.1/all"
    response = requests.get(url)
    if response.status_code == 200:
        countries = response.json()
        return random.sample(countries, 10)  # Sélectionne 10 pays aléatoires
    else:
        print("Failed to fetch data from the API.")
        return []

# Insérer les données des pays dans la base de données
def insert_countries(countries):
    conn = connect_db()
    cursor = conn.cursor()
    for country in countries:
        name = country.get('name', {}).get('common', 'N/A')
        capital = country.get('capital', ['N/A'])[0]
        flag = country.get('flags', {}).get('png', 'N/A')
        subregion = country.get('subregion', 'N/A')
        population = country.get('population', 0)
        
        cursor.execute('''
            INSERT INTO countries (name, capital, flag, subregion, population)
            VALUES (?, ?, ?, ?, ?)
        ''', (name, capital, flag, subregion, population))
    conn.commit()
    conn.close()

# Afficher les pays de la base de données
def display_countries():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM countries')
    rows = cursor.fetchall()
    for row in rows:
        print(row)
    conn.close()

def main():
  
    create_table()

    countries = fetch_random_countries()
    if countries:

        insert_countries(countries)
        print("10 random countries have been added to the database.")

        print("\nCountries in the database:")
        display_countries()
    else:
        print("No countries were fetched from the API.")

if __name__ == "__main__":
    main()