CREATE TYPE FlightsType AS OBJECT (
Origin VARCHAR2(5), 
FlightCode VARCHAR2(8),
Destination VARCHAR2(20), 
DayWeek DATE,
DepTime TIMESTAMP,
ArrTime TIMESTAMP
);  
/ 

CREATE TYPE AirlineType AS OBJECT ( 
Name VARCHAR2(20), 
AirCode NUMBER, 
Address VARCHAR2(15),
FlightID REF FlightsType
);  
/

CREATE TYPE haveTYPE AS OBJECT (
Crew  VARCHAR2(8),
PilotName VARCHAR2(8),
HDate  DATE,
Seat NUMBER(3),
PassengerID REF PassengersType,
FlightID REF FlightsTYpe);
/

CREATE TYPE givesTYPE AS OBJECT (
Miles REF MileProgramType,
AirCode REF AirlineType);
/


CREATE TYPE PassengersType AS OBJECT (
Name VARCHAR2(10), 
Sex VARCHAR2(20),
Address AddressType, 
Age NUMBER, 
PassCode NUMBER(15),
FlightCode REF FlightsType
 );
/

CREATE TYPE MilesOrderType AS OBJECT (
OrderCode NUMBER(8),
Quantity NUMBER(20), 
OrderDate DATE,
PassengerOwner REF PassengersType
);  
/ 


CREATE TYPE MileProgramType AS OBJECT (
Description VARCHAR2(10), 
StartDate DATE,
MileCode NUMBER(15),
PassengerName REF PassengersType 
 );
/

CREATE TYPE MenuType AS OBJECT (
MenuCode NUMBER(8),
Description VARCHAR2(20))NOT FINAL;
/ 

CREATE TYPE VegetarianType UNDER MenuType(
ProteinLevel NUMBER(8)
 );
/

CREATE TYPE KosherType UNDER MenuType (
KosherOrganisation VARCHAR2(10)
 );
/

CREATE TYPE Low_fatType Under MenuType (
KCal NUMBER(4)
 );
/

CREATE TABLE Airline OF AirlineType ( 
AirCode PRIMARY KEY
);  
/

CREATE TABLE Flights of FlightsType ( 
FlightCode PRIMARY KEY) ;  
/
 
CREATE TABLE Passengers OF PassengersType(
PassCode PRIMARY KEY) ; 
/

CREATE TABLE MileProgram OF MileProgramType(
MileCode PRIMARY KEY) ; 
/ 
 
CREATE TABLE Miles_Order OF MilesOrderType (
OrderCode PRIMARY KEY, 
SCOPE FOR (PassengerOwner) IS Passengers ); 
/
 
CREATE TABLE gives OF givesType(
SCOPE FOR (AirCode)IS Airline,
SCOPE FOR (Miles) IS MileProgram);
/ 

CREATE TABLE have OF haveType(
SCOPE FOR (FlightID)IS Flights,
SCOPE FOR (PassengerID) IS Passengers);
/ 

CREATE TABLE Menu OF MenuType(
MenuCode PRIMARY KEY) ; 
/
CREATE TABLE Kosher OF KosherType;

CREATE TABLE Low_fat OF Low_fatType;
/

CREATE TABLE Vegetarian OF VegetarianType;
/

