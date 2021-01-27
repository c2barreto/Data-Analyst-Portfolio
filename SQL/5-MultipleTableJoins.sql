---Practice 1
SELECT ER.EventNo, ER.DateHeld, ER.CustNo, CM.CustName,  
       FC.FacNo, FC.FacName
FROM EventRequest as ER INNER JOIN Customer as CM
	ON ER.CustNo = CM.CustNo
	INNER JOIN Facility as FC
	ON ER.FacNo = FC.FacNo
WHERE City = 'Boulder'
	AND DateHeld BETWEEN '2018-01-01'AND '2018-12-31';
	
--Practice 2
SELECT CM.CustNo, CM.CustName, ER.EventNo, ER.DateHeld,
	   FC.FacNo, FC.FacName, EstCost/EstAudience as AudCost
FROM EventRequest as ER INNER JOIN Customer as CM
	ON ER.CustNo = CM.CustNo
	INNER JOIN Facility as FC
	ON ER.FacNo = FC.FacNo
WHERE (DateHeld BETWEEN '2018-01-01'AND '2018-12-31')
	AND EstCost/EstAudience < 0.2;
	
--Practice 3
SELECT CM.CustNo, CM.CustName, SUM(ER.EstCost) AS TotEstCost
FROM EventRequest as ER INNER JOIN Customer as CM
	ON ER.CustNo = CM.CustNo
WHERE Status = 'Approved'
GROUP BY CM.CustNo, CustName;

--Pracitce 4
INSERT INTO Customer 
  (CustNo, CustName, Address, Internal, Contact, Phone, City, State, Zip)
VALUES ('C9999999', 'Michael Mannino', '123 Any Street', 'Y', 'Self', '720000',
               'Denver', 'CO', '80204');
			   
--Practice 5
UPDATE ResourceTbl
	SET Rate = Rate*1.1
	WHERE ResName = 'Nurse';
	
--Practice 6
DELETE FROM Customer
WHERE CustNo = 'C9999999';


--Graded 1
SELECT ER.EventNo, ER.DateHeld, COUNT(EP.PlanNo) AS TotalPlans
FROM EventRequest AS ER INNER JOIN EventPlan AS EP
	ON ER.EventNo = EP.EventNo
WHERE (WorkDate BETWEEN '2018-12-01'AND '2018-12-31')
GROUP BY ER.EventNo
HAVING COUNT(EP.PlanNo) > 1;

--Graded 2
SELECT EP.PlanNo, ER.EventNo, EP.WorkDate, EP.Activity
FROM EventRequest AS ER INNER JOIN EventPlan AS EP
	ON ER.EventNo = EP.EventNo
	INNER JOIN Facility as F 
	ON ER.FacNo = F.FacNo
WHERE (WorkDate BETWEEN '2018-12-01'AND '2018-12-31')
	AND F.FacName = 'Basketball arena';

--Graded 3
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

--GRADED 4
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

--database mod problems

--Graded 1
INSERT INTO Facility 
  (FacNo, FacName)
VALUES ('C9999999', 'Swimming Pool');

--Graded 2
INSERT INTO Location
	(LocNo, FacNo, Locname)
VALUES ('L9999999', 'C9999999', 'Door');

--Graded 3
INSERT INTO Location
	(LocNo, FacNo, Locname)
VALUES ('L9999998', 'C9999999', 'Locker Room');

--Graded 4
UPDATE Location
	SET LocName = 'Gate'
	WHERE LocName = 'Door';
	
--Graded 5
DELETE FROM Location
WHERE LocName = 'L9999998';


--SQL Statements with Errors and Poor Formatting

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
--5 correct
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
 
 
 