SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE code = '1001';

SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE code = '1001' or code='1002';

SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE code in ('1001','1002');

SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE code = '1001' or code='1002';

SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE code = '1001' or name='八堵';


SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE name LIKE '台_';
/* _ → 1個 */

SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE name LIKE '台%';

SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE name LIKE '%港';

SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE id <=10;

SELECT id as 序號, code as 代碼, name as 車站名稱, e_name as 英文名稱
FROM stations
WHERE id >=10 and id<15;