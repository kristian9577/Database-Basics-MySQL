CREATE TABLE `planets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `spaceports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `planet_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_spaceports_planets_idx` (`planet_id`),
  CONSTRAINT `fk_spaceports_planets` FOREIGN KEY (`planet_id`) REFERENCES `planets` (`id`)
);

CREATE TABLE `spaceships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `manufacturer` varchar(30) NOT NULL,
  `light_speed_rate` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
);

CREATE TABLE `colonists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `ucn` char(10) NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ucn_UNIQUE` (`ucn`)
);

CREATE TABLE `journeys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journey_start` datetime NOT NULL,
  `journey_end` datetime NOT NULL,
  `purpose` enum('Medical','Technical','Educational','Military') NOT NULL,
  `destination_spaceport_id` int(11) DEFAULT NULL,
  `spaceship_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_journeys_spraceports_idx` (`destination_spaceport_id`),
  KEY `fk_journeys_spaceships_idx` (`spaceship_id`),
  CONSTRAINT `fk_journeys_spaceships` FOREIGN KEY (`spaceship_id`) REFERENCES `spaceships` (`id`),
  CONSTRAINT `fk_journeys_spraceports` FOREIGN KEY (`destination_spaceport_id`) REFERENCES `spaceports` (`id`)
);

CREATE TABLE `travel_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_number` char(10) NOT NULL,
  `job_during_journey` enum('Pilot','Engineer','Trooper','Cleaner','Cook') NOT NULL,
  `colonist_id` int(11) DEFAULT NULL,
  `journey_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_number_UNIQUE` (`card_number`),
  KEY `fk_tc_colonists_idx` (`colonist_id`),
  KEY `fk_tc_journeys_idx` (`journey_id`),
  CONSTRAINT `fk_tc_colonists` FOREIGN KEY (`colonist_id`) REFERENCES `colonists` (`id`),
  CONSTRAINT `fk_tc_journeys` FOREIGN KEY (`journey_id`) REFERENCES `journeys` (`id`)
);
