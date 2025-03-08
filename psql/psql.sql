-- mysql -u root < analyze.sql
-- psql -d mydb -f analyze.sql
\c postgres

-- Terminate all connections to the database
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE datname = 'mydb';

-- Drop the database
DROP DATABASE mydb;

CREATE DATABASE mydb;
\l
\c mydb


CREATE TABLE users (
    id INT PRIMARY KEY,
    username VARCHAR(50),
    city VARCHAR(50),
    balance INT
);

\dt

INSERT INTO users (id, username, city, balance) VALUES
(3543, 'marichka', 'london', 873),
(5322, 'theo', 'london', 213),
(5565, 'alex', 'atlanta', 643),
(6432, 'julian', 'new york', 645),
(6788, 'nigel', 'santiago', 4350),
(7545, 'syd', 'shanghai', 5145),
(7657, 'kee', 'portland', 75444),
(8645, 'jasper', 'boston', 342),
(9769, 'luke', 'new york', 2091),
(9908, 'miriam', 'new york', 12);


explain analyze
select *
from users
where city = 'new york'
order by balance desc;

create index city_idx on users(city);

explain analyze
select *
from users
where city = 'new york'
order by balance desc;