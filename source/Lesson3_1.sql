/*車站代號,車站中文名稱,車站英文名稱*/

DROP TABLE IF EXISTS stations;

CREATE TABLE IF NOT EXISTS stations(
	id SERIAL PRIMARY KEY,
	code VARCHAR(4) NOT NULL UNIQUE,
	name VARCHAR(10) NOT NULL UNIQUE,
	e_name VARCHAR(40)
);

SELECT * FROM stations;

ALTER TABLE stations
ALTER COLUMN name
TYPE VARCHAR(15);

ALTER TABLE stations
DROP CONSTRAINT e_name; /* error */


