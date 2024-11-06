--Part 1:
USE MyCompany

--1.	Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT *
FROM Departments d
WHERE d.Dnum = (
    SELECT MIN(Dnum)
    FROM Departments
)


--2.	List the last name of all managers who have no dependents.

SELECT E.Lname
FROM Employee E
WHERE E.Superssn NOT IN (SELECT d.ESSN FROM Dependent d)


--3.	For each department-- if its average salary is less than the average salary of all employees, display its number, name and number of its employees.

SELECT D.Dnum , D.Dname, COUNT(E.SSN)
FROM Departments D
JOIN Employee E ON D.Dnum = E.Dno
GROUP BY D.Dnum, D.Dname
HAVING AVG(E.Salary) < (SELECT AVG(Salary) FROM Employee)

--4.	Try to get the max 2 salaries using subquery

SELECT Salary
FROM (
  SELECT Salary, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS Rank
  FROM Employee
) AS newtable
WHERE Rank <= 2

--5.	Display the employee number and name if he/she has at least one dependent (use exists keyword) self-study.

SELECT E.SSN, CONCAT(E.Fname, E.Lname) As [Full Name]
FROM Employee E
WHERE EXISTS (SELECT 1 FROM Dependent D WHERE D.Essn = E.Ssn);