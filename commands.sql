DROP DATABASE world_db;
CREATE DATABASE world_db;

USE world_db;
show databases;

CREATE TABLE COUNTRY (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    population BIGINT,
    area BIGINT
);

CREATE TABLE CITY (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country_id INT,
    population BIGINT,
    rating INT,
    FOREIGN KEY (country_id) REFERENCES COUNTRY(id)
);

show tables;


-- Insert data into COUNTRY table
INSERT INTO COUNTRY (id, name, population, area) VALUES
(1, 'France', 66600000, 640680),
(2, 'Germany', 80700000, 357000),
(3, 'Spain', 46700000, 505990),
(4, 'Italy', 60400000, 301340),
(5, 'Netherlands', 17400000, 41543);

-- Insert data into CITY table
INSERT INTO CITY (id, name, country_id, population, rating) VALUES
(1, 'Paris', 1, 2243000, 5),
(2, 'Berlin', 2, 3460000, 3),
(3, 'Madrid', 3, 3223000, 4),
(4, 'Rome', 4, 2873000, 4),
(5, 'Amsterdam', 5, 872000, 5),
(6, 'Paris2', 1, 2243000, 5);


select * 
from COUNTRY;

select * 
from CITY;

SELECT ci.name as city
FROM city as ci
WHERE rating > 3
ORDER BY rating DESC;

SELECT co.name as country, ci.name as city
FROM city as ci
JOIN country AS co
  ON ci.country_id = co.id;


SELECT city.name, country.name
FROM city
JOIN country
  ON city.country_id = country.id;

SELECT COUNT(*)
FROM city;

SELECT country_id, SUM(population)
FROM city
GROUP BY country_id
HAVING SUM(population) > 3000000;


SELECT name
FROM country
WHERE EXISTS (
  SELECT *
  FROM city
  WHERE country_id = country.id
);



-- List the country with more than 1 city
select name
from country
where id in (
  select country_id
  from city
  group by country_id
  HAVING count(country_id) > 1);