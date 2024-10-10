DROP TABLE IF EXISTS customer;

CREATE TABLE IF NOT EXISTS customer(
	customer_id int,
	store_id int,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	email VARCHAR(100),
	address_id int,
	activebool VARCHAR(10),
	create_date date,
	last_update timestamp,
	active boolean
	);

SELECT * 
FROM customer;

/* 下列語法無法執行 */
psql -h your_host -U your_user -d dvd_rental;
\COPY customer FROM 'E:/dvdrental/3055.dat' WITH (FORMAT text, DELIMITER tab);

SELECT *
FROM customer
WHERE first_name='Jamie'; /* 字串無法使用 " "，而只能使用' '。 */

SELECT *
FROM customer
WHERE first_name='Jamie' and last_name='Rice';

SELECT *
FROM customer
WHERE last_name='Rodriquez' or first_name='Adam';

SELECT *
FROM customer
WHERE first_name='Ann' or first_name='Anne' or first_name='Annie';

SELECT *
FROM customer
WHERE first_name like 'Ann%';

SELECT *
FROM customer
WHERE first_name like 'A%' and (length(first_name)>=3 and length(first_name)<=5);

SELECT *
FROM customer
WHERE first_name like 'Bra%' and last_name!='Motley';