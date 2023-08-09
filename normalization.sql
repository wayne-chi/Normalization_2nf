
-- NORMAlIZATION TO SECOND NORMaL FORM

-- Create flights table
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
    FlightId INTEGER PRIMARY KEY,
    CarrierCode TEXT,
    FlightNumber INTEGER,
    TailNumber TEXT
);


-- Populate flights table
INSERT INTO flights (CarrierCode, FlightNumber, TailNumber)
SELECT DISTINCT CarrierCode, FlightNumber, TailNumber FROM full_data;

-- Create flight_schedule table
DROP TABLE IF EXISTS flight_schedule;
CREATE TABLE flight_schedule (
    ScheduleId INTEGER PRIMARY KEY,
    FlightId INTEGER,
    DestinationAirport TEXT,
    Scheduleddeparturetime TEXT,
    Actualdeparturetime TEXT,
    Scheduledelapsedtime INTEGER,
    Actualelapsedtime INTEGER,
    FOREIGN KEY (FlightId) REFERENCES flights(FlightId)
);

-- Populate flight_schedule table   o the original data named full data
INSERT INTO flight_schedule (FlightId, DestinationAirport, Scheduleddeparturetime, Actualdeparturetime, Scheduledelapsedtime, Actualelapsedtime)
SELECT f.FlightId, DestinationAirport, Scheduleddeparturetime, Actualdeparturetime, "Scheduledelapsedtime(Minutes)"	, "Actualelapsedtime(Minutes)" 
FROM full_data o
JOIN flights f ON o.CarrierCode = f.CarrierCode AND o.FlightNumber = f.FlightNumber AND o.TailNumber = f.TailNumber;


-- Create flight_delays table
DROP TABLE IF EXISTS flight_delays;
CREATE TABLE flight_delays (
    DelayId INTEGER PRIMARY KEY,
    FlightId INTEGER,
    "Date(MM/DD/YYYY)" DATE,
    "Departuredelay(Minutes)" INTEGER,
	"Wheels-offtime" TEXT,
    "Taxi-Outtime(Minutes)" INTEGER,
    "DelayCarrier(Minutes)" INTEGER,
    "DelayWeather(Minutes)" INTEGER,
	"DelayNationalAviationSystem(Minutes)" INTEGER,
	"DelaySecurity(Minutes)" INTEGER,
	'DelayLateAircraftArrival(Minutes)' INTEGER,

    FOREIGN KEY (FlightId) REFERENCES flights(FlightId)
);

-- Populate flight_delays table
INSERT INTO flight_delays (FlightId, "Date(MM/DD/YYYY)", "Departuredelay(Minutes)", "Wheels-offtime", "Taxi-Outtime(Minutes)", "DelayCarrier(Minutes)", "DelayWeather(Minutes)","DelayNationalAviationSystem(Minutes)","DelaySecurity(Minutes)","DelayLateAircraftArrival(Minutes)")
SELECT f.FlightId, "Date(MM/DD/YYYY)", "Departuredelay(Minutes)", "Wheels-offtime", "Taxi-Outtime(Minutes)", "DelayCarrier(Minutes)", "DelayWeather(Minutes)", "DelayNationalAviationSystem(Minutes)", "DelaySecurity(Minutes)", "DelayLateAircraftArrival(Minutes)"
FROM full_data o
JOIN flights f ON o.CarrierCode = f.CarrierCode AND o.FlightNumber = f.FlightNumber AND o.TailNumber = f.TailNumber;
