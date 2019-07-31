-- insert in tables

INSERT INTO cards(card_number, card_status, bank_account_id)
SELECT
		(REVERSE(c.full_name)) as card_number,
        ('Active') as card_status,
        (c.id) as bank_account_id
FROM clients as c
WHERE c.id BETWEEN 191 AND 200;

-- update tables

SET SQL_SAFE_UPDATES = 0;

UPDATE employees_clients as ec
JOIN
(SELECT ec1.employee_id, COUNT(ec1.client_id) AS 'count'
		FROM employees_clients as ec1 
		GROUP BY ec1.employee_id
		ORDER BY `count`, ec1.employee_id) AS s
SET ec.employee_id = s.employee_id
WHERE ec.employee_id = ec.client_id;

-- delete

DELETE FROM employees
WHERE id NOT IN(SELECT employee_id FROM employees_clients);

-- selects

#5
SELECT id, full_name
FROM clients
ORDER BY id;

#6
SELECT id, concat_ws(' ', first_name, last_name) as full_name,
		concat('$',salary),
        started_on
FROM employees
WHERE salary >= 100000 AND DATE(started_on) >= '2018-01-01'
ORDER BY salary DESC, id;

#7
SELECT card.id, 
		concat(card.card_number, ' : ', cli.full_name) as card_token
FROM clients as cli
JOIN bank_accounts as ba
ON cli.id = ba.client_id
JOIN cards as card
ON ba.id = card.bank_account_id
ORDER BY card.id DESC;

#8
SELECT concat_ws(' ', e.first_name, e.last_name) as 'name',
		e.started_on,
        COUNT(ec.client_id) as count_of_clients
FROM employees as e
JOIN employees_clients as ec
ON e.id = ec.employee_id
GROUP BY ec.employee_id
ORDER BY count_of_clients DESC, ec.employee_id
LIMIT 5;

#9
SELECT b.`name`, COUNT(card.id) as count_of_cards
FROM branches as b
LEFT JOIN employees as e
ON b.id = e.branch_id
LEFT JOIN employees_clients as ec
ON e.id = ec.employee_id
LEFT JOIN clients as c
ON ec.client_id = c.id
LEFT JOIN bank_accounts as ba
ON c.id = ba.client_id
LEFT JOIN cards as card
ON ba.id = card.bank_account_id
GROUP BY b.`name` 
ORDER BY count_of_cards DESC, b.`name`;

#10
DELIMITER $$

CREATE FUNCTION udf_client_cards_count(`name` VARCHAR(30))
RETURNS INT
BEGIN
	DECLARE result INT;
    
    SET result := (SELECT COUNT(card.id) as `count` FROM clients as c
				JOIN bank_accounts as ba
                ON c.id = ba.client_id
                JOIN cards as card
                ON ba.id = card.bank_account_id
                WHERE c.full_name = `name`);
			
	RETURN result;
END $$


SELECT c.full_name, udf_client_cards_count('Baxy David') as `cards` FROM clients c
WHERE c.full_name = 'Baxy David';

#11
DELIMITER $$

CREATE PROCEDURE udp_clientinfo(ins_full_name VARCHAR(50))
BEGIN
	SELECT c.full_name, c.age, ba.account_number, concat('$', ba.balance) FROM clients as c
    JOIN bank_accounts as ba
    ON c.id = ba.client_id
    WHERE c.full_name = ins_full_name;
END $$

CALL udp_clientinfo('Hunter Wesgate');


