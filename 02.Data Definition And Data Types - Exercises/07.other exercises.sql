/* 16.	Basic Insert */
INSERT INTO `towns` 
		(`name`)
    VALUES 
		('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO `departments` 
		(`name`) 
	VALUES
		('Engineering'),
		('Sales'),
		('Marketing'),
		('Software Development'),
		('Quality Assurance');

INSERT INTO `employees`
		(`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, `salary`)
	VALUES
		('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
		('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
		('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
		('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
		('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

/* 17.	Basic Select All Fields */

USE `soft_uni`;
SELECT * FROM `towns`;
    
SELECT * FROM `departments`;
    
SELECT * FROM `employees`;


/* 18.	Basic Select All Fields and Order Them */


SELECT * FROM `towns` ORDER BY `name`;

SELECT * FROM `departments` ORDER BY `name`;

SELECT * FROM `employees` ORDER BY `salary` DESC;


/* 19.	Basic Select Some Fields */

SELECT `name` FROM `towns` ORDER BY `name`;

SELECT `name` FROM `departments` ORDER BY `name`;

SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees` ORDER BY `salary` DESC;


/* 20. Increase Employees Salary */


UPDATE `employees` SET `salary` = `salary` * 1.1;

SELECT `salary`FROM `employees`;

/* 21.	Decrease Tax Rate */


UPDATE `payments` 
SET  `tax_rate` = `tax_rate` * 0.97;

SELECT `tax_rate` FROM `payments`;


/* 22. Delete All Records */


DELETE FROM `occupancies`;