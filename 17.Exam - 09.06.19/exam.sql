CREATE TABLE `branches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
);

CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `started_on` date NOT NULL,
  `branch_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employees_branches_idx` (`branch_id`),
  CONSTRAINT `fk_employees_branches` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
);

CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `employees_clients` (
  `employee_id` int(11),
  `client_id` int(11),
  KEY `fk_ec_employees_idx` (`employee_id`),
  KEY `fk_ec_clients_idx` (`client_id`),
  CONSTRAINT `fk_ec_clients` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_ec_employees` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
);

CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_number` varchar(10) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id_UNIQUE` (`client_id`),
  CONSTRAINT `fk_ba_clients` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`)
);

CREATE TABLE `cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_number` varchar(19) NOT NULL,
  `card_status` varchar(7) NOT NULL,
  `bank_account_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cards_ba_idx` (`bank_account_id`),
  CONSTRAINT `fk_cards_ba` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_accounts` (`id`)
);