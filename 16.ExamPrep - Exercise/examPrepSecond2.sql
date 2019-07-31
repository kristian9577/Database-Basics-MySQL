#2
INSERT INTO travel_cards(card_number, job_during_journey, colonist_id, journey_id)
SELECT  (
            CASE
                WHEN birth_date > '1980-01-01'
                    THEN CONCAT_WS('', YEAR(birth_date),DAY(birth_date),LEFT(ucn,4))
                ELSE CONCAT_WS('', YEAR(birth_date),MONTH(birth_date),RIGHT(ucn,4))
            END
        ) AS card_number,
        (
            CASE
                WHEN id % 2 = 0 THEN 'Pilot'
                WHEN id % 3 = 0 THEN 'Cook'
                ELSE 'Engineer'
            END
        ) AS job_during_journey,
        id AS colonist_id,
        LEFT(ucn,1) AS journey_id
FROM colonists
WHERE id BETWEEN 96 AND 100;
 
#3
UPDATE journeys SET purpose = (
    CASE
        WHEN id % 2 = 0 THEN 'Medical'
        WHEN id % 3 = 0 THEN 'Technical'
        WHEN id % 5 = 0 THEN 'Educational'
        WHEN id % 7 = 0 THEN 'Military'
        ELSE purpose
    END
);
 
#3
DELETE FROM colonists
WHERE id NOT IN (SELECT colonist_id FROM travel_cards);
 
#4
SELECT id, journey_start, journey_end FROM journeys
WHERE purpose = 'Military'
ORDER BY journey_start;
 
#5
SELECT ship.name AS spaceship_name, port.name AS spaceport_name
FROM spaceships AS ship
JOIN journeys AS j
ON ship.id = j.spaceship_id
JOIN spaceports AS port
ON j.destination_spaceport_id = port.id
ORDER BY light_speed_rate DESC LIMIT 1;
 
#6
SELECT ship.name, ship.manufacturer
FROM spaceships AS ship
JOIN journeys AS j
ON ship.id = j.spaceship_id
JOIN travel_cards AS tc
ON j.id = tc.journey_id
JOIN colonists AS c
ON tc.colonist_id = c.id
WHERE tc.job_during_journey = 'Pilot' AND
YEAR(birth_date) > YEAR('1989-01-01')
ORDER BY ship.name;
 
#7
SELECT p.name AS planet_name, port.name AS spaceport_name
FROM spaceports AS port
JOIN planets AS p
ON port.planet_id = p.id
JOIN journeys AS j
ON port.id = j.destination_spaceport_id
WHERE j.purpose = 'Educational'
ORDER BY port.name DESC;
 
#8
SELECT p.name AS planet_name, COUNT(j.id) AS journeys_count
FROM planets AS p
JOIN spaceports AS port
ON p.id = port.planet_id
JOIN journeys AS j
ON port.id = j.destination_spaceport_id
GROUP BY p.name
ORDER BY journeys_count DESC, p.name;
 
#9
SELECT tc.job_during_journey AS job_name
FROM travel_cards AS tc
WHERE tc.journey_id = (
    SELECT j.id FROM journeys AS j
    ORDER BY DATEDIFF(j.journey_end,j.journey_start) DESC LIMIT 1
)
GROUP BY job_name
ORDER BY COUNT(tc.job_during_journey) LIMIT 1;
 
 
#10
DELIMITER $$
CREATE FUNCTION udf_count_colonists_by_destination_planet(planet_name VARCHAR(30))
RETURNS INT
BEGIN
        DECLARE c_count INT;
        SET c_count := (
            SELECT COUNT(c.id) FROM colonists AS c
            JOIN travel_cards AS tc
            ON c.id = tc.colonist_id
            JOIN journeys AS j
            ON tc.journey_id = j.id
            JOIN spaceports AS ports
            ON j.destination_spaceport_id = ports.id
            JOIN planets AS p
            ON ports.planet_id = p.id
            WHERE p.name = planet_name
        );
                       
        RETURN c_count;
END; $$
 
SELECT udf_count_colonists_by_destination_planet('Otroyphus');
 
 
#11
DELIMITER $$
CREATE PROCEDURE udp_modify_spaceship_light_speed_rate
                        (spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
BEGIN
    START TRANSACTION;
    IF spaceship_name NOT IN (SELECT name FROM spaceships)
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Spaceship you are trying to modify does not exists.';
            ROLLBACK;
    ELSE
        UPDATE spaceships
            SET light_speed_rate = light_speed_rate +  light_speed_rate_increse
        WHERE name = spaceship_name;
    END IF;
END; $$
 
CALL udp_modify_spaceship_light_speed_rate ('Na Pesho koraba', 1914);
SELECT name, light_speed_rate FROM spacheships WHERE name = 'Na Pesho koraba'
 
CALL udp_modify_spaceship_light_speed_rate('USS Templar', 5);
SELECT name, light_speed_rate FROM spaceships WHERE name = 'USS Templar'