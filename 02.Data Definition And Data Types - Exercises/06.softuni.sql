CREATE DATABASE `soft_uni`;

USE `soft_uni`;

/* 14. Create SoftUni Database */

CREATE TABLE `towns` (
	`id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	`name` VARCHAR(30) NOT NULL,
	CONSTRAINT `pk_towns` PRIMARY KEY (`id`)
);

CREATE TABLE `addresses` (
	`id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	`address_text` VARCHAR(30) NOT NULL,
	`town_id` INT UNSIGNED,
	CONSTRAINT `pk_addresses` PRIMARY KEY (`id`),
	CONSTRAINT `fk_addresses_towns` FOREIGN KEY (`town_id`)
		REFERENCES `towns` (`id`)
);

CREATE TABLE `departments` (
	`id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	`name` VARCHAR(30) NOT NULL,
	CONSTRAINT `pk_departments` PRIMARY KEY (`id`)
);

CREATE TABLE `employees` (
	`id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	`first_name` VARCHAR(30) NOT NULL,
	`middle_name` VARCHAR(30),
	`last_name` VARCHAR(30) NOT NULL,
	`job_title` VARCHAR(30) NOT NULL,
	`department_id` INT UNSIGNED,
	`hire_date` DATE,
	`salary` DECIMAL(10 , 2 ),
	`address_id` INT UNSIGNED,
	CONSTRAINT `pk_employees` PRIMARY KEY (`id`),
	CONSTRAINT `fk_employees_departments` FOREIGN KEY (`department_id`)
		REFERENCES `departments` (`id`),
	CONSTRAINT `fk_employees_addresses` FOREIGN KEY (`address_id`)
		REFERENCES `addresses` (`id`)
);