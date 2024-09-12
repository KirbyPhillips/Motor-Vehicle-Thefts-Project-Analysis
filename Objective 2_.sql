-- OBJECTIVE 2: IDENTIFY WHICH VEHICLES WERE STOLEN

-- 1. Find the vehicle types that are most often and least often stolen.

SELECT * FROM stolen_vehicles;

SELECT vehicle_type, COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5;

SELECT vehicle_type, COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_vehicles 
LIMIT 5;

-- 2. For each vehicle type, find the average age of the cars that are stolen.

SELECT vehicle_type, YEAR(date_stolen) - model_year
FROM stolen_vehicles;

SELECT vehicle_type, AVG(YEAR(date_stolen) - model_year) AS avg_age
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY avg_age DESC;

-- 3. For each vehicle type, find the percent of vehicles stolen that are luxury vs standard.

SELECT * FROM stolen_vehicles;

SELECT * FROM make_details;

SELECT *
FROM stolen_vehicles sv 
LEFT JOIN make_details md
ON sv.make_id = md.make_id;

-- Calculate the percent of vehicles stolen:
SELECT vehicle_type, make_type
FROM stolen_vehicles sv 
LEFT JOIN make_details md
ON sv.make_id = md.make_id;

-- Change make_type field into numeric field:
SELECT vehicle_type, CASE WHEN make_type = 'Luxury' THEN 1 ELSE 0 END AS luxury
FROM stolen_vehicles sv 
LEFT JOIN make_details md
ON sv.make_id = md.make_id;

-- Need to have numerator and denominator:
SELECT vehicle_type, 
CASE 
WHEN make_type = 'Luxury' THEN 1 ELSE 0 END AS luxury, 1 AS all_cars
FROM stolen_vehicles sv 
LEFT JOIN make_details md
ON sv.make_id = md.make_id;

-- Save table as a Common Table Expression:
WITH lux_standard AS (SELECT vehicle_type, 
CASE 
WHEN make_type = 'Luxury' THEN 1 ELSE 0 END AS luxury, 1 AS all_cars
FROM stolen_vehicles sv 
LEFT JOIN make_details md
ON sv.make_id = md.make_id)

SELECT * FROM make_details;

WITH lux_standard AS (SELECT vehicle_type, 
CASE 
WHEN make_type = 'Luxury' THEN 1 ELSE 0 END AS luxury, 1 AS all_cars
FROM stolen_vehicles sv 
LEFT JOIN make_details md
ON sv.make_id = md.make_id) -- for each vehicle type, the percent of vehicles stolen that are luxury vs standard:
SELECT vehicle_type, SUM(luxury) / SUM(all_cars) * 100 AS pct_lux
FROM lux_standard
GROUP BY vehicle_type
ORDER BY pct_lux DESC;

-- 4. Create a table where the rows represent the top 10 vehicle types, the columns represent the top 7 colors (plus 1 column for all other colors) and the values are the number of vehicles stolen. 

SELECT * FROM stolen_vehicles;

SELECT color, COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY color
ORDER BY num_vehicles DESC; 

SELECT vehicle_type,
    CASE WHEN color = 'Silver' THEN 1 ELSE 0 END AS silver,
    CASE WHEN color = 'White' THEN 1 ELSE 0 END AS white,
    CASE WHEN color = 'Black' THEN 1 ELSE 0 END AS black,
    CASE WHEN color = 'Blue' THEN 1 ELSE 0 END AS blue,
    CASE WHEN color = 'Red' THEN 1 ELSE 0 END AS red,
    CASE WHEN color = 'Grey' THEN 1 ELSE 0 END AS grey,
    CASE WHEN color = 'Green' THEN 1 ELSE 0 END AS green,
    CASE WHEN color IN ('Gold', 'Brown', 'Yellow', 'Orange', 'Purple', 'Cream', 'Pink') THEN 1 ELSE 0 END AS other
FROM stolen_vehicles;

-- Fill up the number of each vehicle that was stolen:
SELECT vehicle_type, 
    COUNT(vehicle_id) AS num_vehicles,
    SUM(CASE WHEN color = 'Silver' THEN 1 ELSE 0 END) AS silver,
    SUM(CASE WHEN color = 'White' THEN 1 ELSE 0 END) AS white,
    SUM(CASE WHEN color = 'Black' THEN 1 ELSE 0 END) AS black,
    SUM(CASE WHEN color = 'Blue' THEN 1 ELSE 0 END) AS blue,
    SUM(CASE WHEN color = 'Red' THEN 1 ELSE 0 END) AS red,
    SUM(CASE WHEN color = 'Grey' THEN 1 ELSE 0 END) AS grey,
    SUM(CASE WHEN color = 'Green' THEN 1 ELSE 0 END) AS green,
    SUM(CASE WHEN color IN ('Gold', 'Brown', 'Yellow', 'Orange', 'Purple', 'Cream', 'Pink') THEN 1 ELSE 0 END) AS other
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_vehicles DESC
LIMIT 10;
