-- Display all the employees Data.
SELECT * from Employee

-- Display the employee First name, last name, Salary and Department number.
SELECT e.Fname [First name], E.Lname [Last name], e.Salary [Salary], E.Dno [Department number]
from Employee E

-- Display all the projects names, locations and the department which is responsible for it.
SELECT Pname [Project name], Plocation [locations] , Dnum [department]
from Project 

-- If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary .Display each employee full name and his annual commission in an ANNUAL COMM column (alias).
SELECT Fname+' '+Lname [Full name] , (salary*12) * 0.10 As [commission] from Employee


-- Display the employees Id, name who earns more than 1000 LE monthly.
SELECT e.SSN [Employee ID], Fname+' '+Lname [Full name]  from Employee E WHERE Salary > 1000


-- Display the employees Id, name who earns more than 10000 LE annually.
SELECT e.SSN [Employee ID], Fname+' '+Lname [Full name]  from Employee E WHERE (Salary * 12) > 10000

-- Display the names and salaries of the female employees 
SELECT Fname+' '+Lname [Full name] , Salary, sex from Employee WHERE Sex = 'F' 

-- Display each department id, name which is managed by a manager with id equals 968574.
SELECT Dname [Department name], Dnum [Department Id] from Departments WHERE MGRSSN = 968574

--Display the ids, names and locations of  the projects which are controlled with department 10.
select p.Pnumber [project Id], p.Pname [project name], p.Plocation [Project location] from Project p WHERE Dnum = 10

-- Part 4: Using MyCompany Database and try to  create the following Queries:
-- Display the Department id, name and id and the name of its manager.
SELECT d.Dname, d.Dnum, e.Fname from Departments d  join Employee e on d.Dnum = e.Dno where e.SSN = d.MGRSSN

-- Display the name of the departments and the name of the projects under its control.
SELECT d.Dname [Department name], p.Pname[project name] from Departments d join Project p on d.Dnum = p.Dnum 

-- Display the full data about all the dependence associated with the name of the employee they depend on .
SELECT e.Fname + ' ' + e.Lname [manager name], d.Dependent_name, d.ESSN, d.Sex from Dependent d  JOIN Employee e on d.ESSN = e.Superssn

--    Display the Projects full data of the projects with a name starting with "a" letter.
-- display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
-- Retrieve the names of all employees in department 10 who work more than or equal 10 hours per week on the "AL Rabwah" project.
-- Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
-- For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
