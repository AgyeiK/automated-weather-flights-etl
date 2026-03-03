DROP SCHEMA if exists sql_workshop;
CREATE SCHEMA sql_workshop;
USE sql_workshop;

CREATE TABLE IF NOT EXISTS city (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(255) NOT NULL,
    country VARCHAR(255),
    latitude FLOAT,
    longitude FLOAT
);

SELECT * FROM city;

CREATE TABLE IF NOT EXISTS population (
    pop_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(255) NOT NULL,
    population BIGINT,
    Population_Timestamp VARCHAR(50),
    year_data BIGINT,
    city_id INT,
    INDEX idx_city_id (city_id),
    CONSTRAINT fk_population_city FOREIGN KEY (city_id) REFERENCES city(city_id)
);

SELECT * FROM population;

CREATE TABLE IF NOT EXISTS weather (
    weather_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(255) NOT NULL,
    country VARCHAR(100),
    latitude FLOAT,
    longitude FLOAT,
    temp FLOAT,
    feels_like FLOAT,
    weather VARCHAR(100),
    humidity INT,
    wind_speed FLOAT,
    weather_timestamp DATETIME,
    city_id INT,
    INDEX idx_weather_city_id (city_id),
    CONSTRAINT fk_weather_city FOREIGN KEY (city_id) REFERENCES city(city_id)
);


USE sql_workshop;
SELECT * FROM weather;

CREATE TABLE IF NOT EXISTS flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    icao VARCHAR(10),
    iata VARCHAR(10),
    name VARCHAR(255),
    shortName VARCHAR(255),
    municipalityName VARCHAR(255),
    countryCode VARCHAR(10),
    timeZone VARCHAR(50),
    location_lat DOUBLE,
    location_lon DOUBLE,
    city VARCHAR(255),
    city_id INT,
    INDEX idx_flights_city_id (city_id),
    CONSTRAINT fk_flights_city FOREIGN KEY (city_id) REFERENCES city(city_id)
);
ALTER TABLE flights 
ADD COLUMN flight_number VARCHAR(20),
ADD COLUMN arrival_time DATETIME,
ADD COLUMN airline VARCHAR(255);

-- This wipes everything so we can start fresh
TRUNCATE TABLE flights;

USE sql_workshop;
SELECT * FROM flights;
SELECT 
    flight_number AS 'Flight', 
    airline AS 'Company', 
    city AS 'Destination',
    arrival_time AS 'Scheduled'
FROM flights 
WHERE icao = 'EDDB'
LIMIT 10;