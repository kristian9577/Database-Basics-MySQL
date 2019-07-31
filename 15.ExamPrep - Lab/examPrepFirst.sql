create table `users`(
`id` INT(11) auto_increment PRIMARY KEY,
`username` VARCHAR(30) not null unique,
`password`VARCHAR(30)not null,
`email`varchar(50) not null
);

CREATE TABLE `buhtig`.`repositories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));

create table `repositories_contributers`(
	`repository_id` INT(11) not null,
    `contributer_id` INT(11) not null,
		PRIMARY KEY(`repository_id`, `contributer_id`),
        FOREIGN KEY (`repository_id`)  
			references `repositories`(`id`),
		FOREIGN KEY (`contributer_id`) 
			references `users`(`id`)
    );
    
    CREATE TABLE `buhtig`.`issues` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `issue_status` VARCHAR(6) NOT NULL,
  `repository_id` INT NOT NULL,
  `assignee_id` INT NOT NULL,
  PRIMARY KEY (`id`));
  
  CREATE TABLE `issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `issue_status` varchar(6) NOT NULL,
  `repository_id` int(11) NOT NULL,
  `assignee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_issues_repositories_idx` (`repository_id`),
  KEY `FK_issues_users_idx` (`assignee_id`),
  CONSTRAINT `FK_issues_repositories` FOREIGN KEY (`repository_id`) REFERENCES `repositories` (`id`),
  CONSTRAINT `FK_issues_users` FOREIGN KEY (`assignee_id`) REFERENCES `users` (`id`)
);
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `size` decimal(10,2) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `commit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_files_commits_idx` (`commit_id`),
  KEY `FK_files_files_idx` (`parent_id`),
  CONSTRAINT `FK_files_commits` FOREIGN KEY (`commit_id`) REFERENCES `commits` (`id`),
  CONSTRAINT `FK_files_files` FOREIGN KEY (`parent_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `commits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `repository_id` int(11) NOT NULL,
  `contributer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_issues_commits_idx` (`issue_id`),
  KEY `FK_issues_repositories_idx` (`repository_id`),
  KEY `FK_issues_users_idx` (`contributer_id`),
  CONSTRAINT `FK_commits_issues` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`id`),
  CONSTRAINT `FK_commits_repositories` FOREIGN KEY (`repository_id`) REFERENCES `repositories` (`id`),
  CONSTRAINT `FK_commits_users` FOREIGN KEY (`contributer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
