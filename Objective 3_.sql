-- OBJECTIVE 3: IDENTIFY WHERE VEHICLES ARE STOLEN

-- 1. Find the number of vehicles that were stolen in each region.

SELECT * FROM stolen_vehicles;

SELECT * FROM locations;

SELECT *
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id;

SELECT region, COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id
GROUP BY region;

-- 2. Combine the previous output with the population and density statistics for each region. 

SELECT region, COUNT(vehicle_id) AS num_vehicles,
	population, density
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id
GROUP BY region, population, density;

SELECT l.region, COUNT(sv.vehicle_id) AS num_vehicles,
	l.population, l.density
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id
GROUP BY l.region, l.population, l.density
ORDER BY num_vehicles DESC;

-- 3. Do the types of vehicles stolen in the three most dense regions differ from the three least dense regions?

-- Determine the 3 most and least dense regions:

SELECT l.region, COUNT(sv.vehicle_id) AS num_vehicles,
	l.population, l.density
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id
GROUP BY l.region, l.population, l.density
ORDER BY l.density DESC;

-- Identify types of vehicles stolen in these regions:

SELECT sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id
WHERE l.region IN ('Auckland', 'Nelson', 'Wellington')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC;

SELECT sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id
WHERE l.region IN ('Otago', 'Gisbourne', 'Southland')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC;

-- Create a table to see the results of these regions stacked from high to low, using a UNION:

(SELECT sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id
WHERE l.region IN ('Auckland', 'Nelson', 'Wellington')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC)

UNION

(SELECT sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
ON sv.location_id = l.location_id
WHERE l.region IN ('Otago', 'Gisbourne', 'Southland')
GROUP BY sv.vehicle_type);

-- Distinguish between these areas by adding new columns such as 'High Density' and 'Low Density':

(SELECT 'High Density' AS density, sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv
LEFT JOIN locations l
ON sv.location_id = l.location_id
WHERE l.region IN ('Auckland', 'Nelson', 'Wellington')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5)

UNION

(SELECT 'Low Density' AS density, sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv
LEFT JOIN locations l
ON sv.location_id = l.location_id
WHERE l.region IN ('Otago', 'Gisborne', 'Southland')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5);
