USE soft_uni;

-- 1.	Find Names of All Employees by First Name
SELECT first_name AS 'Fist Name', last_name AS 'Last Name'
FROM employees
WHERE first_name LIKE 'Sa%'
ORDER BY employee_id;

-- 2.	Find Names of All employees by Last Name 
SELECT first_name AS 'Fist Name', last_name AS 'Last Name'
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

-- 3.	Find First Names of All Employees

SELECT first_name AS 'Fist Name'
FROM employees
WHERE department_id IN (3 , 10) AND YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

-- 4.	Find All Employees Except Engineers
SELECT first_name AS 'Fist Name', last_name AS 'Last Name'
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

-- 5.	Find Towns with Name Length

SELECT `name` AS 'Towns wiht 5 or 6 symbols'
FROM towns
WHERE CHAR_LENGTH(`name`) BETWEEN 5 AND 6
ORDER BY name;

-- 6.	 Find Towns Starting With

SELECT town_id, `name` AS 'Town'
FROM towns
WHERE `name` REGEXP '^[MmKkBbEe]'
ORDER BY name;

-- 7.	 Find Towns Not Starting With

SELECT  town_id, `name` AS 'Town'
FROM towns
WHERE `name` REGEXP '^[^RrBbDd]'
ORDER BY name;

-- 8.	Create View Employees Hired After 2000 Year

CREATE VIEW `v_employees_hired_after_2000` AS
SELECT first_name AS 'Fist Name', last_name AS 'Last Name'
FROM employees 
WHERE YEAR(hire_date) > 2000;

SELECT * FROM `v_employees_hired_after_2000`;

 -- 9.	Length of Last Name
 
 SELECT first_name AS 'Fist Name', last_name AS 'Last Name'
FROM employees
WHERE CHAR_LENGTH(last_name) = 5;

 USE geography;
 
-- 10.	Countries Holding ‘A’ 3 or More Times
SELECT country_name AS 'Country Name', iso_code as 'ISO code'
FROM countries
WHERE country_name LIKE '%a%a%a%'
ORDER BY iso_code;

-- 11.	 Mix of Peak and River Names

SELECT peak_name AS 'Peak Name',river_name AS 'Rive Name',
    LOWER(CONCAT(peak_name, SUBSTRING(river_name, 2))) AS 'mix'
FROM peaks,rivers
WHERE LOWER(RIGHT(`peak_name`, 1)) = LOWER(LEFT(`river_name`, 1))
ORDER BY mix;

USE diablo;

-- 12.	Games from 2011 and 2012 year
SELECT `name` AS 'Name',DATE_FORMAT(`start`, '%Y-%m-%d') AS 'Start Date'
FROM games
WHERE YEAR(`start`) BETWEEN 2011 AND 2012
ORDER BY `start` , `name`
LIMIT 50;

-- 13.	 User Email Providers

SELECT `user_name`, SUBSTRING_INDEX(`email`, '@', - 1) AS 'Email Provider'
FROM `users`
ORDER BY `Email Provider` , `user_name`;

-- 14.	 Get Users with IP Address Like Pattern

SELECT user_name AS 'Username', ip_address AS 'IP address'
FROM users
WHERE ip_address like '___.1%.%.___'
ORDER by `Username`;

-- 15.	 Show All Games with Duration and Part of the Day

SELECT `name` AS 'game',
    CASE
        WHEN HOUR(`start`) >= 0 AND HOUR(`start`) < 12
        THEN 'Morning'
        WHEN HOUR(`start`) >= 12 AND HOUR(`start`) < 18
        THEN 'Afternoon'
        WHEN HOUR(`start`) >= 18 AND HOUR(`start`) < 24
        THEN 'Evening'
    END AS 'Part of the Day',
    CASE
        WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` > 3 AND `duration` <= 6 THEN 'Short'
        WHEN `duration` > 6 AND `duration` <= 10 THEN 'Long'
        ELSE 'Extra Long'
    END AS 'Duration'
FROM games;

USE orders;

-- 16.	 Orders Table

SELECT 
    product_name AS 'Product',
    order_date AS 'Date Ordered',
    DATE_ADD(order_date, INTERVAL 3 DAY) AS 'Pay Due',
    DATE_ADD(order_date, INTERVAL 1 MONTH) AS 'Delivery Due'
FROM orders;