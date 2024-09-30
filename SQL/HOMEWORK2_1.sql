/*車站代號,車站中文名稱,車站英文名稱*/

DROP TABLE IF EXISTS ticket;

CREATE TABLE IF NOT EXISTS ticket(
id SERIAL PRIMARY KEY,
code VARCHAR(4) NOT NULL UNIQUE,
name VARCHAR(10) UNIQUE,
e_name VARCHAR(50) UNIQUE
);

SELECT * FROM ticket;