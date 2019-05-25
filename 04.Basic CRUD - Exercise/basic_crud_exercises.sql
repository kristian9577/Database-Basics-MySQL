USE `soft_uni`;

-- 1.	Find All Information About Departments

SELECT * FROM `departments`
ORDER BY `department_id`;

-- 2. Find all Department Names

SELECT department.name
FROM `departments` AS department
ORDER BY department.department_id;

-- 3. Find salary of Each Employee

SELECT employee.first_name, employee.last_name, employee.salary
FROM `employees` AS employee
ORDER BY employee.employee_id;

-- 4. Find Full Name of Each Employee

SELECT employee.first_name, employee.middle_name, employee.last_name
FROM `employees` AS employee
ORDER BY employee.employee_id;

-- 5. Find Email Address of Each Employee
SELECT 
    CONCAT(employee.first_name, '.', employee.last_name,
		'@softuni.bg') AS 'full_email_address'
FROM `employees` AS employee;

-- 6. Find All Different Employee’s Salaries
SELECT DISTINCT employee.salary
FROM `employees` AS employee
ORDER BY employee.employee_id;

-- 7. Find all Information About Employees
SELECT * FROM `employees` AS employee
WHERE employee.job_title = 'Sales Representative'
ORDER BY employee.employee_id;

-- 8. Find Names of All Employees by salary in Range
SELECT employee.first_name, employee.last_name, employee.job_title
FROM `employees` AS employee
WHERE employee.salary BETWEEN 20000 AND 30000
ORDER BY employee.employee_id;

-- 9. Find Names of All Employees 
SELECT 
    CONCAT_WS(' ',employee.first_name, employee.middle_name, employee.last_name) AS 'Full Name'
FROM `employees` AS employee
WHERE employee.salary IN (25000 , 14000, 12500, 23600)
ORDER BY employee.employee_id;

-- 10. Find All Employees Without Manager

SELECT employee.first_name, employee.last_name
FROM `employees` AS employee
WHERE employee.manager_id IS NULL;


-- 11. Find All Employees with salary More Than 50000

SELECT employee.first_name, employee.last_name, employee.salary
FROM `employees` AS employee
WHERE employee.salary > 50000
ORDER BY employee.salary DESC;

-- 12. Find 5 Best Paid Employees
SELECT employee.first_name, employee.last_name
FROM `employees` AS employee
ORDER BY employee.salary DESC
LIMIT 5;

-- 13. Find All Employees Except Marketing
SELECT employee.first_name, employee.last_name
FROM `employees` AS employee
WHERE employee.department_id != 4;

-- 14. Sort Employees Table
SELECT * FROM `employees` AS employee
ORDER BY employee.salary DESC , employee.first_name , employee.last_name DESC , employee.middle_name , employee.employee_id;

-- 15. Create View Employees with Salaries
CREATE VIEW `v_employees_salaries` AS
SELECT employee.first_name, employee.last_name, employee.salary
FROM `employees` AS employee;

-- 16.	Create View Employees with Job Titles
CREATE VIEW `v_employees_job_titles` AS
    SELECT CONCAT_WS(' ',employee.first_name,
	IF(employee.middle_name IS NULL,'',employee.middle_name),employee.last_name) AS 'Full Name',
        employee.job_title
    FROM `employees` AS employee;

-- 17. Distinct Job Titles
SELECT DISTINCT employee.job_title
FROM `employees` AS employee
ORDER BY employee.job_title;

-- 18. Find First 10 Started Projects
SELECT * FROM `projects` AS prj
ORDER BY prj.start_date , prj.name , prj.project_id
LIMIT 10;

-- 19. Last 7 Hired Employees
SELECT employee.first_name, employee.last_name, employee.hire_date
FROM `employees` AS employee
ORDER BY employee.hire_date DESC
LIMIT 7;


-- 21. Increase Salaries

UPDATE `employees` 
SET `salary` = `salary` * 1.12
WHERE `department_id` IN (1 , 2, 4, 11);

SELECT employee.salary
FROM `employees` AS employee;


-- Part II – Queries for Geography Database

USE `geography`;

-- 21. All Mountain Peaks.

SELECT peak.peak_name
FROM `peaks` AS peak
ORDER BY peak.peak_name;


-- 22. Biggest Countries by Population
SELECT country.country_name, country.population
FROM `countries` AS country
WHERE country.continent_code = 'EU'
ORDER BY country.population DESC , country.country_name
LIMIT 30;


-- 23. Countries and Currency (Euro / Not Euro)
SELECT country.country_name,country.country_code,
    IF(country.currency_code = 'EUR','Euro','Not Euro') AS 'currency'
FROM`countries` AS country
ORDER BY country.country_name;


-- Part III – Queries for Diablo Database
USE `diablo`;

-- 25. All Diablo Characters

SELECT `name`
FROM`characters`
ORDER BY `name`;