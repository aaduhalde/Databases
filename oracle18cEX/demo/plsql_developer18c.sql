

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID 
FROM HR.EMPLOYEES
/
SELECT FIRST_NAME First, LAST_NAME last, DEPARTMENT_ID DepT
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 90
/

--Selecting Data that Satisfies Specified Conditions
SELECT FIRST_NAME "Given Name", LAST_NAME "Family Name"
FROM HR.EMPLOYEES
WHERE LAST_NAME LIKE 'Ma%'
/
SELECT FIRST_NAME "Given Name", LAST_NAME "Family Name"
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN (100, 110, 120)
/
SELECT FIRST_NAME, LAST_NAME, SALARY, COMMISSION_PCT "%"
FROM HR.EMPLOYEES
WHERE (SALARY >= 11000) AND (COMMISSION_PCT IS NOT NULL)
/

--Sorting Selected Data
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM HR.EMPLOYEES
ORDER BY LAST_NAME
/
SELECT FIRST_NAME, HIRE_DATE
FROM HR.EMPLOYEES
ORDER BY LAST_NAME
/

--Selecting Data from Multiple Tables
SELECT FIRST_NAME "First",
LAST_NAME "Last",
DEPARTMENT_NAME "Dept. Name"
FROM HR.EMPLOYEES, HR.DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
ORDER BY DEPARTMENT_NAME, LAST_NAME;

SELECT FIRST_NAME "First",
LAST_NAME "Last",
DEPARTMENT_NAME "Dept. Name"
FROM HR.EMPLOYEES e, HR.DEPARTMENTS d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_NAME, e.LAST_NAME
/
--Selecting Data from Two Tables (Joining Two Tables)
PROMPT ***** Joining

SELECT EMPLOYEES.FIRST_NAME "First",
EMPLOYEES.LAST_NAME "Last",
DEPARTMENTS.DEPARTMENT_NAME "Dept. Name"
FROM HR.EMPLOYEES, HR.DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
ORDER BY DEPARTMENTS.DEPARTMENT_NAME, EMPLOYEES.LAST_NAME;

--Using Operators and Functions in Queries
--Arithmetic Operators in Queries
--Numeric Functions in Queries
--Concatenation Operator in Queries
--Character Functions in Queries
--Datetime Functions in Queries
--Conversion Functions in Queries
--Aggregate Functions in Queries
--NULL-Related Functions in Queries
--CASE Expressions in Queries
--DECODE Function in Querie
PROMPT ***** 

SELECT LAST_NAME,
SALARY "Monthly Pay",
SALARY * 12 "Annual Pay"
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 90
ORDER BY SALARY DESC;
