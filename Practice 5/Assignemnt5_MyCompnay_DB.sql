Use MyCompany


--Project Name and Total Hours per Week:

SELECT P.Pname [Project Name], SUM(W.Hours) AS [Total Hours]
FROM Project P
JOIN Works_for W ON P.Pnumber = W.Pno
GROUP BY P.Pname;


--Department Salary Statistics:
SELECT D.Dname, MAX(E.Salary) AS [Max Salary], MIN(E.Salary) AS [Min Salary], AVG(E.Salary) AS [Avg Salary]
FROM Departments D
JOIN Employee E ON D.Dnum = E.Dno
GROUP BY D.Dname;

--Employee Projects

SELECT E.Fname, E.Lname, P.Pname
FROM Employee E
JOIN Works_for W ON E.SSN = W.Essn
JOIN Project P ON W.Pno = P.Pnumber
ORDER BY E.Dno, E.Lname, E.Fname;

--Insert New Department:
INSERT INTO Departments (Dname, Dnum, MgrSSN, [MGRStart Date])
VALUES ('DEPT IT', 100, 112233, '2006-11-01');

--Update Noha Mohamed's Department and Manager:

UPDATE Departments
SET MgrSSN = 112233,[MGRStart Date] = '2006-11-01'
WHERE Dnum = 100;

UPDATE Employee
SET Dno = 100
WHERE SSN = 968574;


--Update Your Record (SSN = 102672):

UPDATE Employee
SET Dno = 20
WHERE SSN = 102672;


--Update Employee 102660's Supervisor:


UPDATE Employee
SET SuperSSN = 102672
WHERE SSN = 102660;

--Delete Kamel Mohamed (SSN = 223344):
--Check dependent Tablw 
SELECT * FROM Dependent WHERE ESSN = 223344;

DELETE FROM Dependent
WHERE Dependent_name = 'Ahmed Kamel Shawki';

-- Check department table
SELECT * FROM Departments WHERE MgrSSN = 223344;

SELECT * FROM Works_for WHERE Essn = 223344;

UPDATE Project
SET Dnum = 20
WHERE Dnum = 10;

SELECT * FROM Employee WHERE SuperSSN = 223344;

UPDATE Employee
SET Superssn = 512463 WHERE Superssn = 223344;

UPDATE Works_for
SET ESSn = 512463 WHERE ESSn = 223344 and Pno != 500;

UPDATE Works_for
SET ESSn = 112233 WHERE ESSn = 223344 and Pno = 500;

UPDATE Works_for
SET ESSn = 112233 WHERE ESSn = 223344 and Pno = 500;


UPDATE Employee
SET Dno = 20
WHERE Dno = 10;

DELETE FROM Departments
WHERE  MgrSSN = 223344;

DELETE FROM Employee WHERE SSN = 223344;



--Employees Supervised by Kamel Mohamed:
SELECT E.Fname, E.Lname
FROM Employee E
WHERE E.SuperSSN = 223344;


--Manager Data:

SELECT E.Fname, E.Lname, D.Dname, D.MGRSSN, D.[MGRStart Date]
FROM Employee E
JOIN Departments D ON E.Dno = D.Dnum
WHERE E.SSN = D.MgrSSN;

--Employees and Projects (Sorted by Project):

SELECT E.Fname, E.Lname, P.Pname
FROM Employee E
JOIN Works_for W ON E.SSN = W.Essn
JOIN Project P ON W.Pno = P.Pnumber
ORDER BY P.Pname;


--Cairo Projects and Department Information:
SELECT P.Pnumber, D.Dname, E.Lname, E.Address, E.Bdate
FROM Project P
JOIN Departments D ON P.Dnum = D.Dnum
JOIN Employee E ON D.MgrSSN = E.SSN
WHERE P.City = 'Cairo';

--Employees and Dependents (Including No Dependents):
SELECT E.Fname, E.Lname, D.Dname, Dep.Dependent_name, Dep.Sex, Dep.Bdate
FROM Employee E
LEFT JOIN Departments D ON E.Dno = D.Dnum
LEFT JOIN Dependent Dep ON E.SSN = Dep.ESSN;