-- 1.	One-To-One Relationship

CREATE TABLE  passports(
 passport_id INT PRIMARY KEY,
 passport_number VARCHAR(8) UNIQUE NOT NULL
);

CREATE TABLE persons(
person_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(64) NOT NULL,
salary DECIMAL(10,2) NOT NULL,
passport_id INT NOT NULL UNIQUE,
CONSTRAINT fk_person_passport
FOREIGN KEY(passport_id) REFERENCES passports(passport_id)
);

INSERT INTO passports VALUES(101,'N34FG21B'),
(102,'K65LO4R7'),(103,'ZE657QP2');

INSERT INTO persons(first_name,salary,passport_id)
 VALUES('Roberto','43300.00',102),
	('Tom','56100.00',103),
	('Yana','60200.00',101);
    
-- 2. One-To-Many Relationship
    
CREATE TABLE manufacturers(
manufacturer_id INT UNIQUE NOT NULL AUTO_INCREMENT,
name VARCHAR(10) NOT NULL,
established_on DATE NOT NULL,
CONSTRAINT pk_manufacturers PRIMARY KEY(manufacturer_id) 
);

CREATE TABLE models(
model_id INT UNIQUE NOT NULL AUTO_INCREMENT,
name VARCHAR(10) NOT NULL,
manufacturer_id INT,
CONSTRAINT pk_models PRIMARY KEY(model_id),
CONSTRAINT fk_manufacturers_models FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(manufacturer_id)
)AUTO_INCREMENT=101;

INSERT INTO manufacturers (name, established_on)
	VALUES ('BMW', '1916-03-01'),
		('Tesla', '2003-01-01'),
		('Lada', '1966-05-01');

INSERT INTO models (name, manufacturer_id)
    VALUES('X1', 1),
		('i6', 1),
		('Model S', 2),
		('Model X', 2),
		('Model 3', 2),
		('Nova', 3);
        
-- 3.	Many-To-Many Relationship

CREATE TABLE students (
    student_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_students PRIMARY KEY (student_id)
);

CREATE TABLE exams (
    exam_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_exams PRIMARY KEY (exam_id)
)  AUTO_INCREMENT=101;

CREATE TABLE students_exams (
    student_id INT UNSIGNED,
    exam_id INT UNSIGNED
);
ALTER TABLE students_exams
	ADD CONSTRAINT pk_students_exams PRIMARY KEY (student_id , exam_id),
	ADD CONSTRAINT fk_students_exams_students FOREIGN KEY (student_id)
        REFERENCES students (student_id),
	ADD CONSTRAINT fk_students_exams_exams FOREIGN KEY (exam_id)
        REFERENCES exams (exam_id);
        INSERT
        
INTO students (name)
	VALUES ('Mila'), 
        ('Toni'), 
        ('Ron');

INSERT INTO exams (name)
	VALUES ('Spring MVC'), 
        ('Neo4j'), 
        ('Oracle 11g');

INSERT INTO students_exams
    VALUES  (1, 101),
		(1, 102),
		(2, 101),
		(3, 103),
		(2, 102),
		(2, 103);
        
        -- 4.	Self-Referencing
        
CREATE TABLE teachers(
teacher_id INT PRIMARY KEY NOT NULL,
name VARCHAR(20) NOT NULL,
manager_id INT 
);

INSERT INTO teachers VALUES(101,'John',NULL),
(102,'Maya',106),
(103,'Silvia',106),
(104,'Ted',105),
(105,'Mark',101),
(106,'Greta',101);

ALTER TABLE teachers
ADD CONSTRAINT fk_manager_teacher FOREIGN KEY(manager_id)
REFERENCES teachers(teacher_id);


-- 5.	Online Store Database

CREATE DATABASE online_store;

USE online_store;

CREATE TABLE cities (
    city_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE item_types (
    item_type_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    birthday DATE,
    city_id INT NOT NULL,
    CONSTRAINT fk_cities_customers FOREIGN KEY (city_id)
        REFERENCES cities (city_id)
);

CREATE TABLE orders (
    order_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

CREATE TABLE items (
    item_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    item_type_id INT NOT NULL,
    CONSTRAINT fk_item_types_items FOREIGN KEY (item_type_id)
        REFERENCES item_types (item_type_id)
);

CREATE TABLE order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    CONSTRAINT PRIMARY KEY (order_id , item_id),
    CONSTRAINT fk_orders_order_items FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT fk_items_order_items FOREIGN KEY (item_id)
        REFERENCES items (item_id)
);

-- 6.	University Database

CREATE TABLE subjects (
	subject_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50) NOT NULL
);

CREATE TABLE majors (
	major_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE students (
    student_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(12) NOT NULL,
    student_name VARCHAR(50) NOT NULL,
    major_id INT NOT NULL,
    CONSTRAINT fk_majors_students FOREIGN KEY (major_id)
        REFERENCES majors (major_id)
);

CREATE TABLE payments (
	payment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    payment_date DATE not null,
    payment_amount DECIMAL(8,2),
    student_id INT NOT NULL,
     CONSTRAINT fk_students_payments FOREIGN KEY (student_id)
        REFERENCES students (student_id)
);

CREATE TABLE agenda (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    CONSTRAINT PRIMARY KEY (student_id , subject_id),
    CONSTRAINT fk_students_agenda FOREIGN KEY (student_id)
        REFERENCES students (student_id),
    CONSTRAINT fk_subjects_agenda FOREIGN KEY (subject_id)
        REFERENCES subjects (subject_id)
);

-- 9.	Peaks in Rila
USE geography;

SELECT m.mountain_range, p.peak_name, p.elevation AS peak_elevation
FROM mountains AS m
JOIN peaks AS p ON m.id = p.mountain_id
WHERE m.mountain_range = 'Rila'
ORDER BY peak_elevation DESC;

