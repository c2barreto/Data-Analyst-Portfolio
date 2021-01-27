/* List the event number, date held, customer number, customer name, facility
number, and facility name of 2018 events placed by Boulder customers. */

SELECT ER.EventNo, ER.DateHeld, ER.CustNo, CM.CustName,  
       FC.FacNo, FC.FacName
FROM EventRequest as ER INNER JOIN Customer as CM
	ON ER.CustNo = CM.CustNo
	INNER JOIN Facility as FC
	ON ER.FacNo = FC.FacNo
WHERE City = 'Boulder'
	AND DateHeld BETWEEN '2018-01-01'AND '2018-12-31';
	
/* List the customer number, customer name, event number, date held, facility number, 
facility name, and estimated audience cost per person for events held on 2018, in 
which the estimated cost per person is less than $0.2 */

SELECT CM.CustNo, CM.CustName, ER.EventNo, ER.DateHeld,
	   FC.FacNo, FC.FacName, EstCost/EstAudience as AudCost
FROM EventRequest as ER INNER JOIN Customer as CM
	ON ER.CustNo = CM.CustNo
	INNER JOIN Facility as FC
	ON ER.FacNo = FC.FacNo
WHERE (DateHeld BETWEEN '2018-01-01'AND '2018-12-31')
	AND EstCost/EstAudience < 0.2;
	
/* List the customer number, customer name, and total estimated costs for 
Approved events. The total amount of events is the sum of the estimated cost for each event. 
Group the results by customer number and customer name. */

SELECT CM.CustNo, CM.CustName, SUM(ER.EstCost) AS TotEstCost
FROM EventRequest as ER INNER JOIN Customer as CM
	ON ER.CustNo = CM.CustNo
WHERE Status = 'Approved'
GROUP BY CM.CustNo, CustName;

/* Inserting a random customer as a test */

INSERT INTO Customer 
  (CustNo, CustName, Address, Internal, Contact, Phone, City, State, Zip)
VALUES ('C9999999', 'Michael Mannino', '123 Any Street', 'Y', 'Self', '720000',
               'Denver', 'CO', '80204');
			   
/* Increase the rate by 10 percent of resource names equal to nurse. */
UPDATE ResourceTbl
	SET Rate = Rate*1.1
	WHERE ResName = 'Nurse';
	
/* Deleting the random customer that was added */
DELETE FROM Customer
WHERE CustNo = 'C9999999';


/*For event requests, list the event number, event date (eventrequest.dateheld), and count of the 
event plans.  Only include event requests in the result if the event request has more than one 
related event plan with a work date in December 2018. */

SELECT ER.EventNo, ER.DateHeld, COUNT(EP.PlanNo) AS TotalPlans
FROM EventRequest AS ER INNER JOIN EventPlan AS EP
	ON ER.EventNo = EP.EventNo
WHERE (WorkDate BETWEEN '2018-12-01'AND '2018-12-31')
GROUP BY ER.EventNo
HAVING COUNT(EP.PlanNo) > 1;


/* List the plan number, event number, work date, and activity of event plans meeting the
following two conditions: (1) the work date is in December 2018 and (2) the event is held in
the “Basketball arena” */

SELECT EP.PlanNo, ER.EventNo, EP.WorkDate, EP.Activity
FROM EventRequest AS ER INNER JOIN EventPlan AS EP
	ON ER.EventNo = EP.EventNo
	INNER JOIN Facility as F 
	ON ER.FacNo = F.FacNo
WHERE (WorkDate BETWEEN '2018-12-01'AND '2018-12-31')
	AND F.FacName = 'Basketball arena';

/* List the event number, event date, status, and estimated cost of events where there is an event
plan managed by Mary Manager and the event is held in the basketball arena in the period 
October 1 to December 31, 2018. */

SELECT ER.EventNo, ER.DateHeld, ER.Status, ER.EstCost
FROM EventPlan AS EP INNER JOIN EventRequest AS ER
	ON ER.EventNo = EP.EventNo
	INNER JOIN Facility AS F
	ON ER.FacNo = F.FacNo
	INNER JOIN Employee AS E
	ON EP.EmpNo = E.EmpNo
WHERE (ER.DateHeld BETWEEN '2018-10-01'AND '2018-12-31')
	AND F.FacName = 'Basketball arena'
	AND E.EmpName = 'Mary Manager';

/* List the plan number, line number, resource name, number of resources 
(eventplanline.number), location name, time start, and time end where the event is held at the
basketball arena, the event plan has activity of activity of “Operation”, and the event plan has
a work date in the period October 1 to December 31, 2018. */

SELECT EPL.PlanNo, EPL.LineNo, RT.ResName, EPL.NumberFld, L.LocName,
		EPL.TimeStart, EPL.TimeEnd 
FROM EventPlan AS EP INNER JOIN EventPlanLine AS EPL
	ON EP.PlanNo = EPL.PlanNo
	INNER JOIN ResourceTbl AS RT
	ON EPL.ResNo = RT.ResNo
	INNER JOIN Location AS L 
	ON EPL.LocNo = L.LocNo
	INNER JOIN Facility as F
	ON L.FacNo = F.FacNo
WHERE (EP.WorkDate BETWEEN '2018-10-01'AND '2018-12-31')
	AND F.FacName = 'Basketball arena'
	AND EP.Activity = 'Operation';

--database modifications

INSERT INTO Facility 
  (FacNo, FacName)
VALUES ('C9999999', 'Swimming Pool');


INSERT INTO Location
	(LocNo, FacNo, Locname)
VALUES ('L9999999', 'C9999999', 'Door');


INSERT INTO Location
	(LocNo, FacNo, Locname)
VALUES ('L9999998', 'C9999999', 'Locker Room');


UPDATE Location
	SET LocName = 'Gate'
	WHERE LocName = 'Door';
	
DELETE FROM Location
WHERE LocName = 'L9999998';


--Correcting SQL Statements with Errors and Poor Formatting

--1 
SELECT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, employee, facility, eventplan 
WHERE estaudience > 5000
  AND eventplan.empno = employee.empno 
  AND eventrequest.facno = facility.facno -- Semantic: Missing row condition
  AND facname = 'Football stadium' 
  AND empname = 'Mary Manager'

--1 corrected
SELECT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, employee, facility, eventplan
WHERE estaudience > 5000
  AND eventplan.eventno = eventrequest.eventno
  AND eventplan.empno = employee.empno 
  AND eventrequest.facno = facility.facno
  AND facname = 'Football stadium' 
  AND empname = 'Mary Manager';
  
 --2
SELECT DISTINCT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, eventplan --Redundancy: Extra Table
WHERE estaudience > 4000
  AND eventplan.eventno = eventrequest.eventno 
GROUP BY eventrequest.eventno, dateheld, status, estcost

--2 Corrected 
SELECT DISTINCT eventno, dateheld, status, estcost
FROM eventrequest
WHERE estaudience > 4000
GROUP BY eventno, dateheld, status, estcost;

--3
SELECT DISTINCT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, employee, facility, eventplan --Redundancy: Extra Tables
WHERE estaudience > 5000
  AND eventplan.empno = employee.empno 
  AND eventrequest.facno = facility.facno
  AND eventplan.eventno = eventrequest.eventno 
  AND facname = 'Football stadium' 

--3 Corrected
SELECT DISTINCT eventno, dateheld, status, estcost
FROM eventrequest, facility
WHERE estaudience > 5000 
  AND eventrequest.facno = facility.facno
  AND facname = 'Football stadium';
  
 --4
 --Syntax: Misspelled keywords and unqualified column names
SELECT DISTINCT eventno, dateheld, status, estcost
FROM eventrequest, employee, eventplan
WHERE estaudience BETWEN 5000 AND 10000
  AND eventplan.empno = employee.empno 
  AND eventrequest.eventno = eventplan.eventno
  AND empname = 'Mary Manager'
 
 --4 Corrected
SELECT DISTINCT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, employee, eventplan
WHERE estaudience BETWEEN 5000 AND 10000
  AND eventplan.empno = employee.empno 
  AND eventrequest.eventno = eventplan.eventno
  AND empname = 'Mary Manager';
  
 --5
 --keywords misaligned and poorly indented, condition statements not organized
    SELECT eventplan.planno, lineno, resname, 
numberfld, timestart, timeend
    FROM eventrequest, facility, eventplan, 
eventplanline, resourcetbl
     WHERE estaudience = '10000'
AND eventplan.planno = 
eventplanline.planno AND eventrequest.facno 
= facility.facno
      AND facname = 
'Basketball arena' AND 
   eventplanline.resno = resourcetbl.resno
      AND eventrequest.eventno = eventplan.eventno 
      
--5 corrected
SELECT eventplan.planno, lineno, resname, numberfld,
	timestart, timeend
FROM eventrequest, facility, eventplan, 
	eventplanline, resourcetbl
WHERE estaudience = '10000'
	AND facname = 'Basketball arena'
	AND eventplan.planno = eventplanline.planno 
	AND eventrequest.facno = facility.facno
    AND eventplanline.resno = resourcetbl.resno
    AND eventrequest.eventno = eventplan.eventno; 
 
 
 