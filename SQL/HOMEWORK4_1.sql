CREATE TABLE IF NOT EXISTS stations(
	stations_id SERIAL PRIMARY KEY,
	stationCode VARCHAR(5) UNIQUE NOT NULL,
	stationName VARCHAR(20) NOT NULL,
	name VARCHAR(20),
	stationAddrTw VARCHAR(50),
	stationTel VARCHAR(20),
	gps VARCHAR(30),
	haveBike BOOLEAN
);

SELECT *
FROM stations;

CREATE TABLE IF NOT EXISTS station_in_out(
	date DATE,
	staCode VARCHAR(5) NOT NULL,
	gateInComingCnt INTEGER,
	gateOutGoingCnt INTEGER,
	PRIMARY KEY (date,staCode),
	FOREIGN KEY (staCode) REFERENCES stations(stationCode)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

SELECT *
FROM station_in_out;

SELECT *
FROM station_in_out in_out JOIN stations s on in_out.stacode=s.stationcode;

SELECT date AS 日期,
	   gateincomingcnt AS 進站人數,
	   gateoutgoingcnt AS 出站人數,
	   stationname AS 站名,
	   stationaddrtw AS 站址,
	   stationtel AS 電話
FROM station_in_out in_out JOIN stations s ON in_out.stacode = s.stationcode
WHERE stationname = '基隆';

SELECT date AS 日期,
	   gateincomingcnt AS 進站人數,
	   gateoutgoingcnt AS 出站人數,
	   stationname AS 站名,
	   stationaddrtw AS 站址,
	   stationtel AS 電話
FROM station_in_out in_out JOIN stations s ON s.stationcode=in_out.stacode
WHERE stationname = '基隆';

/* 全省各站點2022年進站總人數 */

SELECT EXTRACT(YEAR FROM date '2022-01-01') as 年度,
		stationname as 站名,
		sum(gateincomingcnt) as 進站總人數
FROM station_in_out in_out JOIN stations s on in_out.stacode=s.stationcode
WHERE date>='2020-01-01' AND date<='2020-12-31'
GROUP BY stationname
ORDER BY stationname;

全省各站點2022年進站總人數大於5佰萬人的站點

基隆火車站2020年,每月份進站人數

基隆火車站2020年,每月份進站人數,由多至少

基隆火車站2020,2021,2022,每年進站人數

基隆火車站,臺北火車站2020,2021,2022,每年進站人數

請使用SubQuery
進站人數最多的一筆
各站點進站人數最多的一筆