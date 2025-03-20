import psycopg2
import sys 

sys.stdout.reconfigure(encoding='utf-8')

hostname = "localhost"
username = "postgres"
password = "azer2000"
dbname = "Hollywood"
port_id = "5432"
try:
    connection = psycopg2.connect(
        host=hostname,
        user=username,
        password=password,
        database=dbname,
        client_encoding='utf8',
        port=port_id
    )
    connection.set_client_encoding('UTF8')
    cursor = connection.cursor();
    query = 'select * from user'
    cursor.execute(query);
    result = cursor.fetchall();

    # print({result})

    print("Connexion réussie !")
    connection.close()

except Exception as e:
    print()
    print("Erreur :", e)
