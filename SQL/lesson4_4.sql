/*payment資料表取出所有員工的訂單總數*/
SELECT *
FROM payment;

SELECT staff_id,COUNT(amount) as 訂單總合
FROM payment
GROUP BY staff_id;

/*取出每個員工在每一個客戶的訂單金額總合*/
SELECT staff_id,customer_id,SUM(amount) as 訂單總合
FROM payment
GROUP BY customer_id,staff_id
ORDER BY 訂單總合 DESC;

/*取出每日訂單的總合*/
/* cast operator */
SELECT payment_date::date AS 日期, SUM(amount) AS 總合
FROM payment
GROUP BY 日期
ORDER BY 日期;