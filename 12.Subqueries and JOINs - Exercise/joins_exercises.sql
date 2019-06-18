-- 1.	Employee Address

SELECT e.employee_id,e.job_title,a.address_id,a.address_text
FROM employees AS e
JOIN addresses AS a ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;

-- 2.	Addresses with Towns
SELECT e.first_name,e.last_name,t.name,a.address_text
FROM employees AS e
JOIN addresses AS a
JOIN towns t ON e.address_id = a.address_id
AND a.town_id = t.town_id
ORDER BY e.first_name,e.last_name
LIMIT 5;

-- 3.	Sales Employee
SELECT e.employee_id,e.first_name,e.last_name,d.name
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC;

-- 4.	Employee Departments
SELECT e.employee_id,e.first_name,e.salary,d.name
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

-- 5.	Employees Without Project
SELECT e.employee_id,e.first_name
FROM employees AS e
LEFT JOIN employees_projects AS ep ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

-- 6.	Employees Hired After
SELECT e.first_name,e.last_name,e.hire_date,d.name AS dept_name
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE d.name IN('Sales','Finance') 
AND DATE (e.hire_date) > '1999/1/1'
ORDER BY e.hire_date;

-- 7.	Employees with Project
SELECT e.employee_id,e.first_name,p.name
FROM employees AS e
JOIN employees_projects AS ep ON e.employee_id = ep.employee_id
JOIN projects AS p ON ep.project_id = p.project_id
WHERE DATE(p.start_date) > ('2002-08-13')
AND ISNULL(p.end_date)
ORDER BY e.first_name,p.name
LIMIT 5; 

-- 8.	Employee 24
SELECT e.employee_id,e.first_name,IF(YEAR(p.start_date) >= 2005,NULL,p.name)
FROM employees AS e
JOIN employees_projects AS ep ON e.employee_id = ep.employee_id
JOIN projects AS p ON ep.project_id = p.project_id
WHERE ep.employee_id = 24
ORDER BY p.name;

-- 9.	Employee Manager
SELECT e.employee_id,e.first_name,e.manager_id,m.first_name
FROM employees AS e
JOIN employees AS m ON e.manager_id = m.employee_id
WHERE e.manager_id IN (3,7)
ORDER BY e.first_name;


-- 10.	Employee Summary
SELECT e.employee_id,
CONCAT(e.first_name,' ',e.last_name) AS 'employee_name',
CONCAT(m.first_name,' ',m.last_name) AS 'manager_name',
d.name AS department_name
FROM employees AS e
JOIN employees AS m ON m.employee_id=e.manager_id
JOIN departments AS d ON e.department_id=d.department_id
ORDER BY e.employee_id
LIMIT 5;

-- 11.	Min Average Salary

SELECT MIN(min_avg_salary) AS 'min_average_salary'
FROM
(
 SELECT AVG(salary) AS min_avg_salary
 FROM employees
 GROUP BY department_id
)  AS min_salaries;

USE geography;

-- 12.	Highest Peaks in Bulgaria
SELECT mk.country_code,m.mountain_range,p.peak_name,p.elevation
FROM mountains_countries AS mk
JOIN mountains AS m ON mk.mountain_id=m.id
JOIN peaks AS p ON m.id=p.mountain_id
WHERE mk.country_code = 'BG' AND p.elevation>2835
ORDER BY p.elevation DESC; 

-- 13.	Count Mountain Ranges
SELECT c.country_code,COUNT(m.mountain_range) AS mountain_range
FROM countries AS c
JOIN mountains_countries AS mc ON c.country_code = mc.country_code
JOIN mountains AS m ON mc.mountain_id = m.id
WHERE c.country_code IN ('US' , 'BG', 'RU')
GROUP BY c.country_code
ORDER BY mountain_range DESC;

-- 14.	Countries with Rivers

SELECT c.country_name,r.river_name
FROM rivers AS r
RIGHT JOIN countries_rivers AS cr
ON r.id=cr.river_id
RIGHT JOIN countries AS c
ON cr.country_code=c.country_code
WHERE continent_code = 'AF'
ORDER BY country_name ASC
LIMIT 5;

-- 16.	Countries without any Mountains

SELECT (COUNT(*) - COUNT(mc.mountain_id)) AS country_count  
FROM countries AS c
LEFT JOIN mountains_countries As mc
ON c.country_code = mc.country_code;

-- 17.	Highest Peak and Longest River by Country

SELECT c.country_name, MAX(p.elevation) AS highest_peak_elevation, MAX(r.length) AS longest_river_length
FROM countries AS c
LEFT JOIN mountains_countries as mc ON c.country_code = mc.country_code 
LEFT JOIN peaks AS p ON mc.mountain_id = p.mountain_id
LEFT JOIN countries_rivers AS cr ON cr.country_code = c.country_code
LEFT JOIN rivers as r ON r.id = cr.river_id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC, c.country_name
LIMIT 5;