CREATE DATABASE Hollywood ;
CREATE TABLE actors(
 actor_id SERIAL PRIMARY KEY,
 first_name VARCHAR (50) NOT NULL,
 last_name VARCHAR (100) NOT NULL,
 age DATE NOT NULL,
 number_oscars SMALLINT NOT NULL
)
-- 1
SELECT COUNT(*) FROM actors;
-- 2
INSERT INTO actors (first_name,  last_name, age, number_oscars) 
VALUES ('', '', NULL, NULL);