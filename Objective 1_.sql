-- OBJECTIVE 1: IDENTIFY WHEN VEHICLES WERE STOLEN

-- 1. Find the number of vehicles stolen each year.

SELECT * FROM stolen_vehicles;

SELECT YEAR(date_stolen), COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY YEAR(date_stolen);

-- 2. Find the number of vehicles stolen each month.

SELECT MONTH(date_stolen), COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY MONTH(date_stolen);

SELECT YEAR(date_stolen), MONTH(date_stolen), COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY YEAR(date_stolen), MONTH(date_stolen)
ORDER BY YEAR(date_stolen), MONTH(date_stolen);

SELECT YEAR(date_stolen), MONTH(date_stolen), DAY(date_stolen), COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
WHERE MONTH(date_stolen) = 4 
GROUP BY YEAR(date_stolen), MONTH(date_stolen), DAY(date_stolen)
ORDER BY YEAR(date_stolen), MONTH(date_stolen), DAY(date_stolen);

-- 3. Find the number of vehicles stolen each day of the week.

SELECT DAYOFWEEK(date_stolen) AS dow, COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY DAYOFWEEK(date_stolen)
ORDER BY dow;

-- 4. Replace the numeric day of week values with the full name of each day.alter

SELECT DAYOFWEEK(date_stolen) AS dow, 
CASE WHEN DAYOFWEEK(date_stolen) = 1 THEN 'Sunday'
     WHEN DAYOFWEEK(date_stolen) = 2 THEN 'Monday'
     WHEN DAYOFWEEK(date_stolen) = 3 THEN 'Tuesday'
     WHEN DAYOFWEEK(date_stolen) = 4 THEN 'Wednesday'
     WHEN DAYOFWEEK(date_stolen) = 5 THEN 'Thursday'
     WHEN DAYOFWEEK(date_stolen) = 6 THEN 'Friday'
ELSE 'Saturday' END AS day_of_week,
COUNT(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY DAYOFWEEK(date_stolen), day_of_week
ORDER BY dow;
