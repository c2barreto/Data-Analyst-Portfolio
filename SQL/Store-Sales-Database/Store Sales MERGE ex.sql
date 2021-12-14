-- MERGE and INSERT ALL statements 

-- The first set of examples require the SSCustomer table.
-- The CREATE TABLE and INSERT statements are provided here for convenience.
DROP TABLE SSCustomer;

CREATE TABLE SSCustomer
( 	CustId 	        CHAR(8) NOT NULL,
  	CustName	VARCHAR2(30) NOT NULL,
        CustPhone    	VARCHAR2(15) NOT NULL,
	CustStreet	VARCHAR2(50) NOT NULL,
	CustCity	VARCHAR2(30) NOT NULL,
   	CustState	VARCHAR2(20) NOT NULL,
   	CustZip		VARCHAR2(10) NOT NULL,
	CustNation	VARCHAR2(20) NOT NULL,
 CONSTRAINT PKSSCustomer PRIMARY KEY (CustId)  );

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C0954327','Sheri Gordon', '(303)123-1234','336 Hill St.','Littleton','CO','80129-5543','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C1010398','Jim Glussman','(303)321-9876','1432 E. Ravenna','Denver','CO','80111-0033','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C2388597','Beth Taylor','(206)124-9876','2396 Rafter Rd','Seattle','WA','98103-1121','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C3340959','Betty Wise','(206)421-1276','4334 153rd NW','Seattle','WA','98178-3311','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C8543321','Ron Thompson','(206)891-7664','789 122nd St.','Renton','WA','98666-1289','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C8574932','Wally Jones','(206)391-8564','411 Webber Ave.','Seattle','WA','98105-1093','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C8654390','Candy Kendall','(206)561-2264','456 Pine St.','Seattle','WA','98105-3345','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9128574','Jerry Wyatt','(303)821-1234','16212 123rd Ct.','Denver','CO','80222-0022','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9403348','Mike Boren','(303)821-5688','642 Crest Ave.','Englewood','CO','80113-5431','USA');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9432910','Larry Styles','(406)921-7688','9825 S. Crest Lane','Vancouver','BC','98104-2211','Canada');

insert into SSCustomer 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9543029','Sharon Johnson','(406)921-4468','1223 Meyer Way','Surrey','BC','98222-1123','Canada');

SELECT COUNT(*) FROM SSCustomer;
-- should be 11

-- Create table statement for the first MERGE statement example
-- Non key columns are not required so that only changes are recorded.

CREATE TABLE SSCustomerChanges
( 	CustId 	        CHAR(8),
  	CustName	VARCHAR2(30),
        CustPhone    	VARCHAR2(15),
	CustStreet	VARCHAR2(50),
	CustCity	VARCHAR2(30),
   	CustState	VARCHAR2(20),
   	CustZip		VARCHAR2(10),
	CustNation	VARCHAR2(20),
 CONSTRAINT PKSSCustomerChanges PRIMARY KEY (CustId)  );

-- Change to street and zip code
insert into SSCustomerChanges 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C0954327','Sheri Gordon', '(303)123-1234','444 Jump Ave.','Littleton','CO','80128-5443','USA');
-- Change to phone
insert into SSCustomerChanges 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C1010398','Jim Glussman','(303)257-4186','1432 E. Ravenna','Denver','CO','80111-0033','USA');
-- Change to name
insert into SSCustomerChanges 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C2388597','Beth Taylor-Hines','(206)124-9876','2396 Rafter Rd','Seattle','WA','98103-1121','USA');
-- New customer
insert into SSCustomerChanges
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C8888888','William Wise','(303)421-1276','4334 Alameda Pkwy','Denver','CO','80210-3311','USA');
-- New customer
insert into SSCustomerChanges
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9999999','Toan Lee','(303)555-1111','7504 Dry Creek Road','Centennial','CO','80112-3311','USA');

-- List SSCustomer rows before MERGE
SELECT * FROM SSCustomer;

-- Example 1
-- MERGE statement
-- Insert not matched into SSCustomer
-- Update columns from SSCustomerChanges to corresponding columns in SSCustomer

MERGE INTO SSCustomer Target
USING SSCustomerChanges Source
ON (Target.CustId = Source.CustId)

WHEN MATCHED THEN
UPDATE SET
 Target.CustName = Source.CustName,
 Target.CustPhone = Source.CustPhone,
 Target.CustStreet = Source.CustStreet,
 Target.CustCity = Source.CustCity,
 Target.CustState = Source.CustState,
 Target.CustZip = Source.CustZip,
 Target.CustNation = Source.CustNation

WHEN NOT MATCHED THEN
INSERT (Target.CustId, Target.CustName, Target.CustPhone, Target.CustStreet, Target.CustCity, 
        Target.CustState, Target.CustZip, Target.CustNation)
VALUES (Source.CustId, Source.CustName, Source.CustPhone, Source.CustStreet, Source.CustCity, 
        Source.CustState, Source.CustZip, Source.CustNation);

-- List SSCustomer rows after MERGE
SELECT * FROM SSCustomer;
Rollback;

-- Change table for MERGE example 2
CREATE TABLE SSCustomerChanges2

( 	CustId 	        CHAR(8),
  	CustName	VARCHAR2(30),
        CustPhone    	VARCHAR2(15),
	CustStreet	VARCHAR2(50),
	CustCity	VARCHAR2(30),
   	CustState	VARCHAR2(20),
   	CustZip		VARCHAR2(10),
	CustNation	VARCHAR2(20),
 CONSTRAINT PKSSCustomerChanges2 PRIMARY KEY (CustId)  );

-- Rows for example 2
-- Changed rows only have values for PK and changed columns
-- Change to street and zip code so only values for CustId, CustStreet and CustZip
insert into SSCustomerChanges2 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C0954327',NULL,NULL,'444 Jump Ave.',NULL ,NULL,'80128-5443',NULL);
-- Change to phone so only values for CustId and CustPhone
insert into SSCustomerChanges2 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C1010398', NULL,'(303)257-4186', NULL, NULL, NULL, NULL, NULL);
-- Change to name so only values for CustId and CustName columns
insert into SSCustomerChanges2 
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C2388597','Beth Taylor-Hines', NULL, NULL, NULL, NULL, NULL, NULL);
-- New customer so values for all columns
insert into SSCustomerChanges2
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C8888888','William Wise','(303)421-1276','4334 Alameda Pkwy','Denver','CO','80210-3311','USA');
-- New customer so values for all columns
insert into SSCustomerChanges2
(CustId, CustName, CustPhone, CustStreet, CustCity, CustState, CustZip, CustNation)
values ('C9999999','Toan Lee','(303)555-1111','7504 Dry Creek Road','Centennial','CO','80112-3311','USA');

-- List SSCustomer rows before MERGE
SELECT * FROM SSCustomer;

-- Example 2
-- MERGE statement
-- Insert not matched into SSCustomer
-- Update non null columns from SSCustomerChanges to corresponding columns in SSCustomer
-- Syntax only allows one MATCHED clause. Use DECODE function to substitute non null source values.
-- DECODE(Source.CustName, NULL, Target.CustName, Source.CustName): if Source.CustName is NULL use Target, else Source

MERGE INTO SSCustomer Target
USING SSCustomerChanges2 Source
ON (Target.CustId = Source.CustId)

WHEN MATCHED THEN
UPDATE SET 
  Target.CustName = DECODE(Source.CustName, NULL, Target.CustName, Source.CustName), 
  Target.CustPhone = DECODE(Source.CustPhone, NULL, Target.CustPhone, Source.CustPhone), 
  Target.CustStreet = DECODE(Source.CustStreet, NULL, Target.CustStreet, Source.CustStreet), 
  Target.CustCity = DECODE(Source.CustCity, NULL, Target.CustCity, Source.CustCity), 
  Target.CustState = DECODE(Source.CustState, NULL, Target.CustState, Source.CustState), 
  Target.CustZip = DECODE(Source.CustZip, NULL, Target.CustZip, Source.CustZip), 
  Target.CustNation = DECODE(Source.CustNation, NULL, Target.CustNation, Source.CustNation) 

WHEN NOT MATCHED THEN
INSERT (Target.CustId, Target.CustName, Target.CustPhone, Target.CustStreet, Target.CustCity, 
        Target.CustState, Target.CustZip, Target.CustNation)
VALUES (Source.CustId, Source.CustName, Source.CustPhone, Source.CustStreet, Source.CustCity, 
        Source.CustState, Source.CustZip, Source.CustNation);


-- List SSCustomer rows after MERGE
SELECT * FROM SSCustomer;
Rollback;

DROP TABLE SSCustomerChanges;
DROP TABLE SSCustomerChanges2;

