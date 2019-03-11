CREATE DATABASE `car_rental`;

USE `car_rental`;

/* 12. Car Rental Database */

CREATE TABLE `categories` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `category` VARCHAR(30) NOT NULL,
    `daily_rate` FLOAT,
    `weekly_rate` FLOAT,
    `monthly_rate` FLOAT,
	`weekend_rate` FLOAT,
    CONSTRAINT `PK_categories` PRIMARY KEY (`id`)
);

CREATE TABLE `cars`(
	`id` INT NOT NULL AUTO_INCREMENT,
    `plate_number` VARCHAR(10) NOT NULL,
    `make` VARCHAR(50),
    `model` VARCHAR(50),
    `car_year` INT,
    `category_id` INT,
    `doors` INT,
    `picture` BLOB,
    `car_condition` TEXT,
    `available` TINYINT,
	CONSTRAINT `PK_categories` PRIMARY KEY (`id`,`plate_number`)
);

CREATE TABLE `employees` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`first_name` VARCHAR(30) NOT NULL,
	`last_name` VARCHAR(30) NOT NULL,
	`title` VARCHAR(50) NOT NULL,
	`notes` TEXT(65535),
	CONSTRAINT `PK_employees` PRIMARY KEY (`id`)
);

CREATE TABLE `customers` (
	`id` INT NOT NULL AUTO_INCREMENT, 
    `driver_licence_number` BIGINT, 
    `full_name` VARCHAR(200) NOT NULL,
    `address` VARCHAR(200),
    `city` VARCHAR(30),
    `zip_code` INT,
    `notes` TEXT(65535),
    CONSTRAINT `PK_customers` PRIMARY KEY (`id`)
);

CREATE TABLE `rental_orders` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `employee_id` INT,
    `customer_id` INT,
    `car_id` INT,
    `car_condition` TEXT(65535),
    `tank_level` DOUBLE,
    `kilometrage_start` DOUBLE, 
    `kilometrage_end` DOUBLE,
    `total_kilometrage` DOUBLE, 
    `start_date` DATE,
    `end_date` DATE,
    `total_days` INT,
    `rate_applied` FLOAT,
    `tax_rate` FLOAT,
    `order_status`TINYINT, 
    `notes` TEXT(65535),
    CONSTRAINT `PK_rental_orders` PRIMARY KEY (`id`)
);

INSERT INTO `categories`
	(`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES
	('Compact',15.6,90.4,300.9,25.3),
    ('SUV',30.3,150.8,500.1,45.67),
    ('Limousine',45.8,250.4,850.6,75.7);

INSERT INTO `cars` 
	(`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `picture`, `car_condition`, `available`)
VALUES
	('A8972KB','VW','Polo',2017,1,4,'ima snimka','Excellent condition',1),
    ('CB3462AA','Audi','A3',2018,2,5,'ima snimka','Brand new',0),
    ('CB3783CH','Audi','A8',2017,3,4,'ima snimka','Brand new',1);

INSERT INTO `employees` 
	(`first_name`, `last_name`, `title`)
VALUES
	('Qnko','Halilov', 'Office director'),
    ('Pesho','Peshev', 'Order processing'), 
    ('Gosho','Goshev', 'Car Managment');
    
INSERT INTO `customers` 
	(`driver_licence_number`, `full_name`, `city`)
VALUES
	(456635892, 'Chefo Chefov','Varna'),
    (326373434, 'Mama Goshka','Milioni'),
    (120958035, 'Bai Ivan','Poduene');
    
INSERT INTO `rental_orders`
	(`employee_id`, `customer_id`, `car_id`, `order_status`)
VALUES
	(2,1,3,1),
    (1,2,2,0),
    (3,3,1,1);
