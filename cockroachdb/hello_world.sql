-- cockroach sql --insecure -f hello_world.sql > result.txt

DROP DATABASE mydb;
CREATE DATABASE IF NOT EXISTS mydb;
SHOW DATABASES;
USE mydb;

CREATE TABLE users (
    id INT PRIMARY KEY,
    username VARCHAR(50),
    city VARCHAR(50),
    balance INT
);
show tables;

-- Generate and insert 1000000 more users
INSERT INTO users (id, username, city, balance)
SELECT
    seq AS id,
    'user_' || seq AS username,
    (ARRAY[
            'USA', 'Canada', 'UK', 'Germany', 'France', 'Italy', 'Spain', 'Netherlands', 'Belgium', 'Sweden',
            'Norway', 'Denmark', 'Finland', 'Poland', 'Switzerland', 'Austria', 'Czech Republic', 'Slovakia', 'Hungary', 'Portugal',
            'Greece', 'Ireland', 'Russia', 'Ukraine', 'Turkey', 'China', 'Japan', 'South Korea', 'India', 'Indonesia',
            'Malaysia', 'Singapore', 'Thailand', 'Vietnam', 'Philippines', 'Australia', 'New Zealand', 'Brazil', 'Argentina', 'Chile',
            'Mexico', 'Colombia', 'Peru', 'Venezuela', 'South Africa', 'Egypt', 'Nigeria', 'Kenya', 'Morocco', 'Saudi Arabia',
            'UAE', 'Qatar', 'Kuwait', 'Israel', 'Iran', 'Pakistan', 'Bangladesh', 'Sri Lanka', 'Myanmar', 'Nepal',
            'Kazakhstan', 'Uzbekistan', 'Turkmenistan', 'Azerbaijan', 'Georgia', 'Armenia', 'Lebanon', 'Jordan', 'Iraq', 'Syria',
            'Afghanistan', 'Mongolia', 'Taiwan', 'Hong Kong', 'Macau', 'Bahrain', 'Oman', 'Yemen', 'Sudan', 'Ethiopia',
            'Tanzania', 'Ghana', 'Uganda', 'Algeria', 'Libya', 'Tunisia', 'Zambia', 'Zimbabwe', 'Cameroon', 'Ivory Coast',
            'Senegal', 'Mali', 'Madagascar', 'Botswana', 'Namibia', 'Paraguay', 'Bolivia', 'Ecuador', 'Uruguay', 'Costa Rica'
        ])[1 + (random() * 6)::INT] AS city,
    (random() * 10000000)::INT AS balance
FROM generate_series(1, 1000000) AS seq;


-- select * from users;

explain analyze
select *
from users
where city = 'new york'
order by balance desc;

create index city_balance_idx on users(city, balance);

explain analyze
select *
from users
where city = 'new york'
order by balance desc;

explain analyze
select id
from users
where city = 'new york'
order by balance desc;