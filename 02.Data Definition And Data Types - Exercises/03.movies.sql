CREATE DATABASE `movies`;
USE `movies`;
    
CREATE TABLE `directors` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`director_name` VARCHAR(50) NOT NULL,
	`notes` TEXT(65535),
	CONSTRAINT `PK_directors` PRIMARY KEY (`id`)
);

CREATE TABLE `genres` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`genre_name` VARCHAR(50) NOT NULL,
	`notes` TEXT(65535),
	CONSTRAINT `PK_genres` PRIMARY KEY (id)
);
    
CREATE TABLE `categories` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `category_name` VARCHAR(50) NOT NULL,
    `notes` TEXT(65535),
    CONSTRAINT `PK_categories` PRIMARY KEY (id)
);
    
CREATE TABLE `movies` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(50) NOT NULL,
	`director_id` INT,
	`copyright_year` DATE,
	`length` INT,
	`genre_id` INT,
	`category_id` INT,
	`rating` FLOAT(2, 1),
    `notes` TEXT(65535),
    CONSTRAINT `PK_movies` PRIMARY KEY (id)
);
    
INSERT INTO `directors`
	(`director_name`,`notes`)
VALUES
	('Pesho',NULL),
	('Qnko',NULL),
    ('Goshka','opalaq'), 
	('Stamat',NULL),
	('Ivan',NULL);

INSERT INTO `genres`
	(`genre_name`,`notes`)
VALUES
	('Liutenica','za esteti'),
	('Shliokavica','za ne tolkova golemi esteti'),
    ('Jasanica','malki da ne gledat mnogo, samo malko'), 
	('Jivotinska Jasanica','malki tuk vyobshte da ne gledat'),
	('Mandjare','za gladni');
    
INSERT INTO `categories`
	(`category_name`,`notes`)
VALUES
	('1',NULL),
    ('34536',NULL),
    ('sdf234',NULL),
    ('we7j','ha siga'),
    ('34343',NULL);
    
INSERT INTO `movies`
	(`title`,`director_id`,`genre_id`,`category_id`,`rating`)
VALUES
	('Goshka v obora',1,4,3,6.7),
    ('Pesho v lozqta',3,3,1,3.6),
    ('Misirki v mola',4,1,5,7.8),
    ('Goshka v obora 2',1,4,1,9.7),
    ('Goshka v obora: Zaden izhod, vyrhovno razkysvane',1,4,5,9.9);