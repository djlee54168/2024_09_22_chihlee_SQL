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
SELECT stationname as 站名, sum(gateincomingcnt) as 進站總人數
FROM station_in_out in_out JOIN stations s on in_out.stacode=s.stationcode
WHERE EXTRACT(YEAR from date)='2022'
GROUP BY stationname
ORDER BY SUM(gateincomingcnt) DESC;

/* 全省各站點2022年進站總人數大於5佰萬人的站點 */
SELECT stationname as 站名, sum(gateincomingcnt) as 進站總人數
FROM station_in_out in_out JOIN stations s on in_out.stacode=s.stationcode
WHERE EXTRACT(YEAR from date)='2022'
GROUP BY stationname
HAVING SUM(gateincomingcnt) > 5000000
ORDER BY SUM(gateincomingcnt) DESC;

/* 基隆火車站2020年,每月份進站人數 */
SELECT stationname as 站別, EXTRACT(MONTH from date) as 月別, sum(gateincomingcnt) as 進站總人數
FROM station_in_out in_out JOIN stations s on in_out.stacode=s.stationcode
WHERE EXTRACT(YEAR from date)='2020' AND stationname='基隆'
GROUP BY stationname, 月別
ORDER BY 月別;

/* 基隆火車站2020年,每月份進站人數,由多至少 */
SELECT stationname as 站別, EXTRACT(MONTH from date) as 月別, sum(gateincomingcnt) as 進站總人數
FROM station_in_out in_out JOIN stations s on in_out.stacode=s.stationcode
WHERE stationname='基隆' and EXTRACT(YEAR from date)='2020'
GROUP BY stationname, 月別
ORDER BY 進站總人數 DESC;

/* 基隆火車站2020,2021,2022,每年進站人數 */
SELECT stationname as 站別, EXTRACT(year from date) as 年度, sum(gateincomingcnt) as 進站總人數
FROM station_in_out in_out JOIN stations s on in_out.stacode=s.stationcode
WHERE stationname='基隆' and EXTRACT(YEAR from date) in('2020','2021','2022')
GROUP BY stationname, 年度
ORDER BY 年度;

/* 基隆火車站,臺北火車站2020,2021,2022,每年進站人數 */
SELECT stationname as 站別, EXTRACT(year from date) as 年度, sum(gateincomingcnt) as 進站總人數
FROM station_in_out in_out JOIN stations s on in_out.stacode=s.stationcode
WHERE stationname in('臺北','基隆') and EXTRACT(YEAR from date) in('2020','2021','2022')
GROUP BY 站別, 年度
ORDER BY 站別;

/* 請使用SubQuery */
/* 進站人數最多的一筆 */
SELECT stationname as 站別, date as 日期, gateincomingcnt as 進站人數
FROM stations s JOIN station_in_out in_out on in_out.stacode=s.stationcode
WHERE gateincomingcnt=(
	SELECT MAX(gateincomingcnt)
	FROM station_in_out
);

/* 各站點進站人數最多的一筆 */
SELECT stationname as 站別, in_out.date as 日期, gateincomingcnt as 進站人數
FROM stations s 
    JOIN (
        SELECT staCode,MAX(gateincomingcnt) as 進站最多人數
        FROM station_in_out
        GROUP BY staCode ) in_out
	ON s.stationcode = in_out.staCode
;

SELECT staCode,MAX(gateincomingcnt) as 進站最多人數
        FROM station_in_out
        GROUP BY staCode;

SELECT stationname as 站名, max(gateincomingcnt) as 進站最多人數
FROM stations s JOIN station_in_out in_out on in_out.stacode=s.stationcode
GROUP BY stationname
ORDER BY 進站最多人數 DESC;

SELECT stationname,date,gateincomingcnt as 最多人数
FROM station_in_out in_out JOIN stations s ON in_out.staCode = s.stationcode
    JOIN (
        SELECT staCode,MAX(gateincomingcnt) as 最大進站數
        FROM station_in_out
        GROUP BY staCode ) as 每站最大值
    ON in_out.staCode = 每站最大值.staCode
    AND gateincomingcnt = 最大進站數
ORDER BY in_out.staCode DESC;