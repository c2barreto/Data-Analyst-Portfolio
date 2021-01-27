/* List all columns of the EventRequest table for events costing more than $4000. 
Order the result by the event date (DateHeld). */
SELECT *
FROM EventRequest
WHERE EstCost > 4000
ORDER BY DateHeld;

/* List the event number, the event date (DateHeld), and the estimated audience number with
approved status and audience greater than 9000 or with pending status and audience greater
than 7000. */
SELECT EventNo, DateHeld, EstAudience, Status
FROM EventRequest
WHERE (Status = 'Approved' AND EstAudience > 9000)
	OR (Status = 'Pending' AND EstAudience > 7000);
	
/* List the event number, event date (DateHeld), customer number and customer name of 
events placed in January 2018 by customers from Boulder. */
SELECT ER.EventNo, ER.DateHeld, ER.CustNo, CU.CustName, CU.City
FROM EventRequest as ER INNER JOIN Customer as CU
ON ER.CustNo = CU.CustNo
WHERE (ER.DateHeld BETWEEN '2018-12-01' AND '2018-12-31')
	AND (CU.City = 'Boulder');
	
/* List the average number of resources used (NumberFld) by plan number. Include only 
location number L100. */
SELECT PlanNo, AVG(NumberFld) AS AvgNumResources
FROM EventPlanLine
WHERE LocNo = 'L100'
GROUP BY PlanNo;

/* List the average number of resources used (NumberFld) by plan number. Only include 
location number L100. Eliminate plans with less than two event lines containing location
number L100. */
SELECT PlanNo, AVG(NumberFld) AS AvgNumResources, 
	COUNT(*) AS NumEventLines
FROM EventPlanLine
WHERE LocNo = 'L100'
GROUP BY PlanNo
HAVING COUNT(*) > 1;


--List the name, department, phone number, and email address of employees with a phone number beginning with “3-”
SELECT EmpName, Department, Phone, Email
FROM Employee
WHERE Phone Like '3%';

--List all columns of the resource table with a rate between $10 and $20. Sort the result by rate.
SELECT *
FROM ResourceTbl
WHERE Rate BETWEEN '10' AND '20'  
ORDER BY Rate;

/*List the event requests with a status of “Approved” or “Denied” and an authorized date in 
July 2018. Include the event number, authorization date, and status in the output. */
SELECT EventNo, DateAuth, Status
FROM EventRequest
WHERE (Status = 'Approved' OR Status = 'Denied')
	AND (DateAuth BETWEEN '2018-07-01' AND '2018-07-31');

/* List the location number and name of locations that are part of the “Basketball arena”. */
SELECT LocNo, LocName
FROM Location, Facility
WHERE FacName = 'Basketball arena';

/* For each event plan, list the plan number, count of the event plan lines, and sum of the 
number of resources assigned. only need to consider event plans that have at least one line. */
SELECT PlanNo, SUM(NumberFld) AS SumNumResources,
	COUNT(*) AS NumEventLines
FROM EventPlanLine 
GROUP BY PlanNo
HAVING COUNT(*) > 1;




