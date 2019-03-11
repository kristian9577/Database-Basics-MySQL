CREATE DATABASE `hotel`;
USE `hotel`;

/* 13. Hotel Database */

CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(30),
    notes TEXT,
    CONSTRAINT pk_employees PRIMARY KEY (id)
);

CREATE TABLE customers (
    account_number VARCHAR(20) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone_number VARCHAR(15),
    emergency_name VARCHAR(30),
    emergency_number INT,
    notes TEXT,
    CONSTRAINT pk_customers PRIMARY KEY (account_number)
);

CREATE TABLE room_status (
    room_status VARCHAR(10) NOT NULL,
    notes TEXT,
    CONSTRAINT pk_room_status PRIMARY KEY (room_status)
);

CREATE TABLE room_types (
    room_type VARCHAR(20) NOT NULL,
    notes TEXT,
    CONSTRAINT pk_room_types PRIMARY KEY (room_type)
);

CREATE TABLE bed_types (
    bed_type VARCHAR(10) NOT NULL,
    notes TEXT,
    CONSTRAINT pk_bed_types PRIMARY KEY (bed_type)
);

CREATE TABLE rooms (
    room_number INT(4) NOT NULL AUTO_INCREMENT,
    room_type VARCHAR(20),
    bed_type VARCHAR(10),
    rate DECIMAL,
    room_status VARCHAR(10),
    notes TEXT,
    CONSTRAINT pk_rooms PRIMARY KEY (room_number)
);

CREATE TABLE payments (
    id INT NOT NULL AUTO_INCREMENT,
    employee_id INT,
    payment_date DATE,
    account_number VARCHAR(20),
    first_date_occupied DATE,
    last_date_occupied DATE,
    total_days INT,
    amount_charged DECIMAL,
    tax_rate FLOAT,
    tax_amount FLOAT,
    payment_total DECIMAL(8, 2),
    notes TEXT,
    CONSTRAINT pk_payments PRIMARY KEY (id)
);

CREATE TABLE occupancies (
    id INT NOT NULL AUTO_INCREMENT,
    employee_id INT,
    date_occupied DATE,
    account_number VARCHAR(20),
    room_number INT(4),
    rate_applied FLOAT,
    phone_charge FLOAT,
    notes TEXT,
    CONSTRAINT pk_occupancies PRIMARY KEY (id)
);

INSERT INTO employees (first_name, last_name)
VALUES ('Maria', 'Ivanova'), ('Svetla', 'Petrova'), ('Galya', 'Mihova');

INSERT INTO customers (account_number, first_name, last_name, phone_number)
VALUES ('3728FHCJ738291', 'Ivan', 'Petrov', '0888332289'), ('5848PVQM329048', 'Iva', 'Georgieva', '0883987654'),
('4589DKSL654789', 'Hristo', 'Stoyanov', '0878654124');

INSERT INTO room_status (room_status)
VALUES ('occupied'), ('free'), ('reserved');

INSERT INTO room_types (room_type)
VALUES ('Single room'), ('Double room'), ('Family studio');

INSERT INTO bed_types (bed_type)
VALUES ('Single'), ('Double'), ('Mixed');

INSERT INTO rooms (room_type, bed_type, room_status)
VALUES ('Single room', 'Double', 'free'), ('Family studio', 'Mixed', 'occupied'), ('Double room', 'Single', 'reserved');

INSERT INTO payments (employee_id, account_number, first_date_occupied, last_date_occupied, total_days, payment_total)
VALUES (1, '3728FHCJ738291', '2017-05-01', '2017-05-05', 4, 636.62),
(3, '5848PVQM329048', '2017-03-09', '2017-03-10', 1, 55.70),
(2, '4589DKSL654789', '2016-12-10', '2016-12-20', 10, 1024.89);

INSERT INTO occupancies (employee_id, room_number)
VALUES (1, 3), (2, 1), (3, 2);