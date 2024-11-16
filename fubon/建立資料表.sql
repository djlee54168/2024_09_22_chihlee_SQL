CREATE TABLE IF NOT EXISTS 股票代號名稱(
	code VARCHAR(20),
	name VARCHAR(20),
	PRIMARY KEY(code)
);

# 證券代號,證券名稱,成交股數,成交金額,開盤價,最高價,最低價,收盤價,漲跌價差,成交筆數

CREATE TABLE IF NOT EXISTS 股市2(
	stock_id SERIAL,
	date DATE,
	open NUMERIC(17,10),
	high NUMERIC(17,10),
	low NUMERIC(17,10),
	close NUMERIC(17,10),
	adj_close NUMERIC(17,10),
	volume BIGINT DEFAULT 0,
	name VARCHAR(20),
	PRIMARY KEY(stock_id),
	FOREIGN KEY(name) REFERENCES 市場(name) 
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);