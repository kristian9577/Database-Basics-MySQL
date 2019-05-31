USE gringotts;

-- 1. Records’ Count
SELECT COUNT(*) AS 'count'
FROM wizzard_deposits;

-- 2.	 Longest Magic Wand
SELECT MAX(`magic_wand_size`) AS 'longest magic wand'
FROM wizzard_deposits;

-- 3. Longest Magic Wand per Deposit Groups
SELECT `deposit_group`, MAX(`magic_wand_size`) AS 'longest magic wand'
FROM wizzard_deposits
GROUP BY `deposit_group`
ORDER BY `longest magic wand`,`deposit_group`;

-- 4.	 Smallest Deposit Group per Magic Wand Size

SELECT w.deposit_group
FROM wizzard_deposits AS w
GROUP BY w.deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;

-- 5.	 Deposits Sum

SELECT `deposit_group`, SUM(`deposit_amount`) AS 'total_sum'
FROM wizzard_deposits
GROUP BY `deposit_group`
ORDER BY `total_sum`;

-- 6.	 Deposits Sum for Ollivander family
SELECT `deposit_group`, SUM(`deposit_amount`) AS 'total_sum'
FROM wizzard_deposits
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

-- 7.	Deposits Filter

SELECT `deposit_group`, SUM(`deposit_amount`) AS 'total_sum'
FROM wizzard_deposits
WHERE `magic_wand_creator` = 'Ollivander family' 
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;

-- 8.	 Deposit charge
SELECT `deposit_group`,`magic_wand_creator`,MIN(`deposit_charge`) AS 'min_deposit_charge'
FROM wizzard_deposits
GROUP BY `deposit_group`,`magic_wand_creator`
ORDER BY `magic_wand_creator`,`deposit_group`;

-- 9. Age Groups

SELECT
	CASE 
		WHEN `age`<=10 THEN '[0-10]'
        WHEN `age`<=20 THEN '[11-20]'
		WHEN `age`<=30 THEN '[21-30]'
		WHEN `age`<=40 THEN '[31-40]'
		WHEN `age`<=50 THEN '[41-50]'
		WHEN `age`<=60 THEN '[51-60]'
        ELSE '[61+]'
	END AS 'age_group',
    COUNT(`age`) AS 'wizzard_count'
FROM `wizzard_deposits`
GROUP BY `age_group`
ORDER BY `age_group`;

-- 10. First Letter

SELECT LEFT(`first_name`,1) AS 'first_letter'
FROM `wizzard_deposits`
WHERE `deposit_group` LIKE 'Troll%'
GROUP BY `first_letter`
ORDER BY `first_letter`;

 -- 11. Average Interest 
 
 SELECT `deposit_group`,`is_deposit_expired`, AVG(`deposit_interest`) AS 'average_interest'
 FROM `wizzard_deposits`
 WHERE `deposit_start_date` >'1985/01/01'
 GROUP BY `is_deposit_expired`, `deposit_group`
 ORDER BY `deposit_group` DESC, `is_deposit_expired`;
 
 -- 12.	Rich Wizard, Poor Wizard
 
 SELECT SUM(diff.next) AS 'sum_difference'
 FROM (
		SELECT `deposit_amount` - 
			(SELECT `deposit_amount`
            FROM `wizzard_deposits`
            WHERE `id` = wd.id + 1) AS 'next'
    FROM `wizzard_deposits` AS wd) AS diff;
 
USE `soft_uni`;

-- 13.	 Employees Minimum Salaries
SELECT `department_id`,MIN(`salary`) AS minimum_salary
FROM employees
WHERE `department_id` IN (2,5,7) AND `hire_date`>'2000-01-01'
GROUP BY `department_id`
ORDER BY `department_id`;

-- 14.	Employees Average Salaries

SELECT e.department_id,
	CASE
		WHEN e.department_id = 1 THEN AVG(e.salary) + 5000
        ELSE AVG(e.salary)
	END AS avg_salary
FROM employees AS e
WHERE e.manager_id !=42 AND e.salary > 30000
GROUP BY e.department_id
ORDER BY department_id;

-- 15. Employees Maximum Salaries

SELECT e.department_id, MAX(e.salary) AS 'max_salary'
FROM employees AS e
GROUP BY e.department_id
HAVING NOT (max_salary BETWEEN 30000 AND 70000)
ORDER BY department_id;

-- 16.	Employees Count Salaries
SELECT COUNT(e.salary)
FROM employees AS e
WHERE ISNULL(e.manager_id);

-- 17.	3rd Highest Salary

SELECT `department_id`,
    (SELECT DISTINCT `e2`.`salary`
        FROM `employees` AS `e2`
        WHERE `e2`.`department_id` = `e1`.`department_id`
        ORDER BY `e2`.`salary` DESC
        LIMIT 2 , 1) AS `third_highest_salary`
FROM `employees` AS `e1`
GROUP BY `department_id`
HAVING `third_highest_salary` IS NOT NULL;

-- 18.	 Salary Challenge

SELECT e1.first_name, e1.last_name, e1.department_id
FROM employees AS e1
	JOIN
    (SELECT e2.department_id, AVG(e2.salary) AS dep_avg_salary
    FROM employees AS e2
    GROUP BY e2.department_id) AS e3 ON e1.department_id = e3.department_id
WHERE e1.salary > e3.dep_avg_salary
ORDER BY department_id
LIMIT 10;

-- 19.	Departments Total Salaries

SELECT e1.department_id, SUM(e1.salary)
FROM employees AS e1
GROUP BY e1.department_id
ORDER BY department_id;