-- 1.	Employees with Salary Above 35000

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000 ()
BEGIN 
	SELECT e.first_name,e.last_name 
	FROM employees AS e
	WHERE salary > 35000
	ORDER BY e.first_name,e.last_name,e.employee_id;
END $$

CALL usp_get_employees_salary_above_35000();

-- 2.	Employees with Salary Above Number

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(min_salary DOUBLE)
BEGIN
	SELECT e.first_name,e.last_name 
	FROM employees AS e
	WHERE e.salary >= min_salary
	ORDER BY e.first_name,e.last_name,e.employee_id;
END $$

CALL usp_get_employees_salary_above(48100);

-- 3.	Town Names Starting With

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(str_start VARCHAR(10))
BEGIN
	SELECT name AS town_name
    FROM towns 
    WHERE name LIKE CONCAT(str_start,'%') 
    ORDER BY town_name;
END $$

CALL usp_get_towns_starting_with('b');

-- 4.	Employees from Town

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town (town_names VARCHAR(45))
BEGIN
	SELECT e.first_name,e.last_name 
	FROM employees AS e
	JOIN addresses AS a ON  a.address_id=e.address_id
    JOIN towns AS t ON t.town_id = a.town_id
    WHERE t.name = town_names
  	ORDER BY e.first_name,e.last_name,e.employee_id;
END $$

CALL usp_get_employees_from_town('Sofia');

-- 5.	Salary Level Function

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(input_salary DOUBLE)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(10);
	RETURN CASE
    WHEN input_salary < 30000 THEN 'low'
    WHEN input_salary >= 30000 AND input_salary <= 50000 THEN  'average'
    WHEN input_salary > 50000 THEN 'high'
    END;
END$$

SELECT ufn_get_salary_level(13500.00);

-- 6.	Employees by Salary Level
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(10))
BEGIN 
	SELECT first_name,last_name FROM employees
	WHERE
	CASE
	WHEN salary < 30000 THEN 'Low'
	WHEN salary >= 30000 AND salary <= 50000 THEN 'Average'
	WHEN salary > 50000 THEN 'High'
	END = salary_level
    ORDER BY first_name,last_name DESC;
END$$

CALL usp_get_employees_by_salary_level('high');

-- 7.	Define Function

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50),word varchar(50))
RETURNS BIT
DETERMINISTIC
BEGIN
RETURN IF(LOWER(word) REGEXP CONCAT('^[', LOWER(set_of_letters), ']+$'), TRUE, FALSE);
END $$

SELECT ufn_is_word_comprised('oistmiahf','Sofia');
