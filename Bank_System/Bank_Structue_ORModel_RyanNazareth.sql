
/*
Courseork Part 1 - Ryan Nazareth 
*/


CREATE TYPE BranchType AS OBJECT (
BCode NUMBER(10), 
Phone NUMBER(10),
Location VARCHAR2(20), 
BSize NUMBER(4),
DepTime TIMESTAMP
);  
/ 

CREATE TYPE MenuType AS OBJECT (
MCode NUMBER(10), 
MType VARCHAR2(10),
Creator VARCHAR2(20),
MAP MEMBER FUNCTION getMCode RETURN NUMBER(10),
PRAGMA RESTRICT_REFERENCES(getMCode, WNDS, WNPS, RNDS, RNPS)
);
/

/*

A member method is a function of procedure that always has an implicit or
explicit SELF parameter as its first parameter whose type is the containing 
object type. The member function getMCode returs the value of the getMCode 
attribute. The Prama clause is a complier directive which denies member fucntions 
read/write access to databse tables an package variables
WNDS means does not modify database tables 
WNPS means does not modify packaged variables 
RNDS means does not query tables 
RNPS means does not reference package variables 
*/


CREATE TYPE ServesType AS OBJECT (
BranchID REF BranchType,
MenuID REF MenuType
);
/


CREATE TYPE IncomeType AS OBJECT (
InCode NUMBER(10), 
IDate DATE,
Amount NUMBER(4),
BranchID REF BranchType
);  
/ 

CREATE TYPE EmployeeType AS OBJECT (
ECode NUMBER(10), 
Name  VARCHAR2(20),
Age NUMBER(4),
Sex VARCHAR2(5),
Phone NUMBER(15),
Address AddressType,
BranchID REF BranchType 
)NOT FINAL ;         
/ 

CREATE TYPE CleanerType UNDER EmployeeType (
Shift VARCHAR2(10) 
);  
/ 

CREATE TYPE WaiterType UNDER EmployeeType (
Shift VARCHAR2(10)
);  
/ 

CREATE TYPE ChefType UNDER EmployeeType (
Qualification  VARCHAR2(20)
);  
/ 


CREATE TYPE Dishes AS OBJECT (  
DCode NUMBER (10), 
Name VARCHAR2(20),
Price NUMBER(5),
Description VARCHAR2(50)
);  
/


CREATE TYPE IsComposedOfType AS OBJECT (
MenuContent REF MenuType,
DishesContent REF DishesType
);


CREATE TYPE OrderType AS OBJECT (
ODate  DATE,
Quantity NUMBER(5),
ItemsID REF ItemsType, 
MenuID REF MenuType, 
BranchID REF BranchType
);
/

CREATE TYPE ItemsType AS OBJECT (
ITCode NUMBER(10), 
Description VARCHAR2(20)
 );
/


CREATE TABLE Branch OF BranchType ( 
BCode PRIMARY KEY,
SCOPE FOR (EmployeeID) IS Employee
);  
/

CREATE TABLE Menu of MenuType ( 
MCode PRIMARY KEY
) ;  
/
 
CREATE TABLE Income OF IncomeType(
InCode PRIMARY KEY) ; 
/

CREATE TABLE Employee OF EmployeeType(
ECode PRIMARY KEY,
SCOPE FOR (BranchID) IS BranchType 
); 
/
CREATE TABLE Cleaner OF CleanerType;

CREATE TABLE Waiter OF WaiterType;
/

CREATE TABLE Chef OF ChefType;
/

CREATE TABLE Dishes OF DishesType(
DCode PRIMARY KEY) ; 
/ 
 
CREATE TABLE IsComposedOf OF IsComposedOfType (
SCOPE FOR (MenuContent) IS Menu,
SCOPE FOR (DishesContent) Dishes
); 
 
CREATE TABLE Order OF OrderType (
SCOPE FOR (PassengerOwner) IS Items,
SCOPE FOR (MenuID) IS Menu,
SCOPE FOR (BranchID)IS Branch
); 
/
 
 
CREATE TABLE Serves of ServesType (
SCOPE FOR (BranchID) IS BranchType 
SCOPE FOR (MenuID) IS MenuType 
);
/

