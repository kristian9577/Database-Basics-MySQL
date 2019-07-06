-- 1.	Count Employees by Town

DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
    SET e_count := (SELECT COUNT(e.employee_id)
					FROM employees AS e
					JOIN addresses AS a ON e.address_id = a.address_id
					JOIN towns AS t ON t.town_id = a.town_id
					WHERE t.name = town_name);
	RETURN e_count;
END $$

SELECT ufn_count_employees_by_town('Sofia') AS count;

-- 2.	Employees Promotion

DELIMITER $$

CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN 
	UPDATE employees AS e
    INNER JOIN departments AS d
    ON e.department_id = d.department_id
    SET salary = salary * 1.05
    WHERE d.name = department_name;
END $$

SELECT usp_raise_salaries('Finance');

-- 3.	Employees Promotion By ID

CREATE PROCEDURE usp_raise_salary_by_id(id int)
BEGIN
	START TRANSACTION;
	IF((SELECT count(employee_id) FROM employees WHERE employee_id like id)<>1) THEN
	ROLLBACK;
	ELSE
		UPDATE employees AS e SET salary = salary + salary*0.05 
		WHERE e.employee_id = id;
	END IF; 
END
