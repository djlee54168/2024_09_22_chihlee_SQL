SELECT *
FROM stations;

SELECT *
FROM station_in_out;
/*全省各站點2022年進站總人數*/
SELECT stationname AS 站名, SUM(gateincomingcnt) AS 總進站人數
FROM stations JOIN station_in_out ON stationcode = stacode
/*WHERE date BETWEEN '2022-01-01' AND '2022-12-31';(第一種寫法)*/
/*WHERE date>='2022-01-01' and date<='2022-12-31'(第二種寫法)*/
WHERE EXTRACT(YEAR FROM date) = 2022 
GROUP BY 站名
ORDER BY 總進站人數 DESC;

/*全省各站點2022年進站總人數大於5佰萬人的站點*/
SELECT stationname AS 站名, SUM(gateincomingcnt) AS 總進站人數
FROM stations JOIN station_in_out ON stationcode = stacode
/*WHERE date BETWEEN '2022-01-01' AND '2022-12-31';*/
WHERE EXTRACT(YEAR FROM date) = 2022
GROUP BY 站名
/*下方條件不可直接加在where之後，因需在group作完之後，而where只能用1次，故後面追加篩選條件需用having。*/
HAVING SUM(gateincomingcnt) >= 5000000
ORDER BY 總進站人數 DESC;

/*基隆火車站2020年,每月份進站人數*/
SELECT stationname AS 站名, TO_CHAR(date,'YYYY-MM') AS 日期, SUM(gateincomingcnt) AS 當月總進站人數
FROM stations JOIN station_in_out ON stationcode = stacode
WHERE EXTRACT(YEAR FROM date) = 2020 AND stationname='基隆'
/*WHERE不能用小名*/
GROUP BY 站名,日期;
/*今日學到的新函式TO_CHAR(date,'YYYY-MM')*/

/*基隆火車站2020年,每月份進站人數,由多至少*/
SELECT stationname AS 站名, TO_CHAR(date, 'YYYY-MM') AS 日期,SUM(gateincomingcnt) AS 當月總進站人數
FROM stations JOIN station_in_out ON stationcode = stacode
/*WHERE date BETWEEN '2022-01-01' AND '2022-12-31';*/
WHERE EXTRACT(YEAR FROM date) = 2020 AND stationname='基隆'
GROUP BY 站名,日期
ORDER BY 當月總進站人數 DESC;

/*基隆火車站2020,2021,2022,每年進站人數*/
SELECT stationname AS 站名, EXTRACT(YEAR FROM date) as 年份,SUM(gateincomingcnt) AS 當年總進站人數
FROM stations JOIN station_in_out ON stationcode = stacode
WHERE EXTRACT(YEAR FROM date) IN (2020,2021,2022) AND stationname='基隆'
GROUP BY 站名,年份;

/*基隆火車站,臺北火車站2020,2021,2022,每年進站人數*/
SELECT stationname AS 站名, EXTRACT(YEAR FROM date) as 年份,SUM(gateincomingcnt) AS 當年總進站人數
FROM stations JOIN station_in_out ON stationcode = stacode
WHERE EXTRACT(YEAR FROM date) IN (2020,2021,2022) AND stationname IN ('基隆','臺北')
GROUP BY 站名,年份;

/*進站人數最多的一筆*/
SELECT stationname AS 站名,date as 日期, gateincomingcnt AS 進站人數
FROM stations JOIN station_in_out ON stationcode = stacode
WHERE gateincomingcnt = (
	SELECT MAX(gateincomingcnt)
	FROM station_in_out
);

select stationname as 站名,max(gateincomingcnt) as 最多進站人數
from stations JOIN station_in_out ON stationcode = stacode
group by 站名;

/*各站點進站人數最多的一筆*/
/*主查詢*/
SELECT name,date,gateincomingcnt
FROM stations JOIN station_in_out ON stationcode = stacode
WHERE (stationname,gateincomingcnt) IN 
(
	SELECT stationname AS 站名,MAX(gateincomingcnt) AS 最多人數
	FROM stations JOIN station_in_out ON stationcode = stacode
	GROUP BY 站名	
)
GROUP BY NAME
ORDER BY gateincomingcnt;

/*子查詢*/
/*子查詢先作，再將子查詢放到主查詢即可。*/
SELECT stationname AS 站名,MAX(gateincomingcnt) AS 最多人數
FROM stations JOIN station_in_out ON stationcode = stacode
GROUP BY 站名;


/* 注意 進站人數有多筆為0 的情況→執行ok *//*陳同學的答案*/
SELECT MAX(io.date) AS 日期, io.staCode AS 站號, s_name.stationName AS 站名, MAX(io.gateInComingCnt) AS 進站人數
FROM station_in_out io JOIN stations s_name ON io.staCode = s_name.stationCode
WHERE (io.staCode,io.gateInComingCnt) IN (
    SELECT staCode,MAX(gateInComingCnt)
    FROM station_in_out
    GROUP BY staCode
)
GROUP BY io.staCode,s_name.stationName
ORDER BY 進站人數 DESC;

/*整理後→執行ok*/
SELECT MAX(date) AS 日期, staCode AS 站號, stationName AS 站名, MAX(gateInComingCnt) AS 進站人數
FROM station_in_out JOIN stations ON staCode = stationCode
WHERE (staCode,gateInComingCnt) IN 
(
    SELECT staCode,MAX(gateInComingCnt)
    FROM station_in_out
    GROUP BY staCode
)
GROUP BY staCode,stationName
ORDER BY 進站人數 DESC;
