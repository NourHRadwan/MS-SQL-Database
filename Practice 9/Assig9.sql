--=================================================================
--========================Part(1)=========================================
/*Create the following tables with all the required information and load
the required data as specified in each table using insert statements[at
least two rows]*/

USE RouteCompany
-- 1

CREATE TABLE Department (
    DeptNo INT PRIMARY Key,
    DeptName VARCHAR(20),
    Location VARCHAR(20)
)

INSERT into Department (DeptNo, DeptName, Location)
VALUES (1 , 'Research', 'NY'),
(2, 'Accounting', 'DS'),
(3, 'Marketing', 'KW');

-- 2

Create TABLE Employee (

    EmpNo int PRIMARY key,
    Emp_Fname VARCHAR(50) NOT NULL,
    Emp_Lname VARCHAR(50) NOT NULL,
    DeptNo INT FOREIGN key REFERENCES Department (DeptNo),
    Salary money UNIQUE
)


INSERT into Employee VALUES 
    (25348, 'Mathew', 'Smith', 3, 2500),
    (10102, 'Ann', 'Jones', 3, 3000),
    (18316, 'John', 'Barrymore', 1, 2400),
    (29346, 'James', 'James', 2, 2800),
    (9031, 'Lisa', 'Bertoni', 2, 4000),
    (2581, 'Elisa', 'Hansel', 2, 3600),
    (28559, 'Sybl', 'Moser', 1, 2900);

--3 -- 
INSERT INTO Project (ProjectNo, ProjectName, Budget)
VALUES
(1, 'Apollo', 120000.00),
(2, 'Gemini', 95000.00),
(3, 'Mercury', 185600.00);


-- 4
INSERT INTO works_on (EmpNo, ProjectNo, Job, Enter_Date)
VALUES
(10102, 1, 'Analyst', '2006-10-01'),
(10102, 3, 'Manager', '2012-01-01'),
(25348, 2, 'Clerk', '2007-02-15'),
(18316, 2, NULL, '2007-06-01'),
(29346, 2, NULL, '2006-12-15'),
(2581, 3, 'Analyst', '2007-10-15'),
(9031, 1, 'Manager', '2007-04-15'),
(28559, 1, NULL, '2007-08-01'),
(28559, 2, 'Clerk', '2012-02-01'),
(9031, 3, 'Clerk', '2006-11-15'),
(29346, 1, 'Clerk', '2007-01-04');

/*
1-Add new employee with EmpNo =11111 In the works_on table [what will
happen]
2-Change the employee number 10102 to 11111 in the works on table [what
will happen]
3-Modify the employee number 10102 in the employee table to 22222. [what
will happen]
4-Delete the employee with id 10102*/

INSERT into works_on (EmpNo, ProjectNo, Job, Enter_Date) VALUES (11111, 1, 'Engineer', '2006-01-01')
--Error  is :The INSERT statement conflicted with the FOREIGN KEY constraint "FK_works_on_EmpNo". The conflict occurred in database "RouteCompany", table "dbo.Employee", column 'EmpNo'.
-- This is because the Employee table is Missing Employee Record with id number 11111, we have to create the employee record with EmpNo = 11111 first.

-- Update the employee number from 10102 to 11111 in the works_on table
UPDATE works_on
SET EmpNo = 11111
WHERE EmpNo = 10102; 

-- Failed, as the employee number is forgien key for the employee table. Can't make action to the child table if no action premitted by the parent table

-- Update the employee number from 10102 to 22222 in the Employee table
UPDATE Employee
SET EmpNo = 22222
WHERE EmpNo = 10102; -- Failed because the foreign key constraints were violated.

-- Delete the employee with EmpNo = 10102 from the Employee table
DELETE FROM Employee
WHERE EmpNo = 10102;  --Failed because the foreign key constraints were violated.

--Add TelephoneNumber column to the employee table[programmatically]

ALTER TABLE Employee
ADD TelephoneNumber VARCHAR(20) NULL;

--2-drop this column[programmatically]
ALTER TABLE Employee
DROP COLUMN TelephoneNumber;

--3-Build A diagram to show Relations between tables

GO
CREATE SCHEMA Company;

GO
ALTER SCHEMA Company TRANSFER dbo.Department
ALTER SCHEMA Company TRANSFER dbo.Project

GO
CREATE SCHEMA HumanResource;

GO
ALTER SCHEMA HumanResource TRANSFER dbo.Employee

-- Increase the budget of the project where the manager number is 10102
-- by 10%.

    UPDATE Company.project
    set budget =  budget * 1.10
    WHERE projectNo in (
        SELECT projectNo
        from dbo.works_on
        where EmpNo = 10102
    )

-- 4. Change the name of the department for which the employee named
-- James works.The new department name is Sales.

    UPDATE Company.department 
    set deptName = 'Sales'
    where DeptNo in (
        select DeptNo
        from HumanResource.Employee
        where Emp_Fname = 'James'
    )

-- 5. Change the enter date for the projects for those employees who work in
-- project p1 and belong to department ‘Sales’. The new date is 12.12.2007.

    UPDATE dbo.works_on
    set Enter_Date = '12.12.2007'
    where ProjectNo = 1 and EmpNo in 
    (select EmpNo from HumanResource.Employee where deptNo in (
        select DeptNo from Company.department where deptName = 'Sales'
    ))

-- 6. Delete the information in the works_on table for all employees who
-- work for the department located in KW.

DELETE from works_on where EmpNo in (
    select EmpNo from HumanResource.Employee where deptNo in 
    (
        SELECT deptNo from company.department where location = 'Kw'
    )
)

--2.Create an Audit table with the following structure
CREATE TABLE BudgetAudit (
    ProjectNo INT NOT NULL,
    UserName VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
    Budget_Old DECIMAL(10,2) NULL,
    Budget_New DECIMAL(10,2) NULL
);

INSERT INTO BudgetAudit (ProjectNo, UserName, ModifiedDate, Budget_Old, Budget_New)
VALUES (2, 'Dbo', '2008-01-31', 95000, 200000);

GO
CREATE or ALTER TRIGGER tr_UpdateBudget
on HR.Project
After Update
AS
BEGIN
    IF UPDATE(Budget)
    BEGIN
        INSERT INTO BudgetAudit (ProjectNo, UserName, ModifiedDate, Budget_Old, Budget_New)
        SELECT i.ProjectNo, SYSTEM_USER, GETDATE(), d.Budget, i.Budget
        FROM inserted i
        INNER JOIN deleted d ON i.ProjectNo = d.ProjectNo;
    END
END

--===========================================================================================
--==========================================Part 2===========================================
GO
USE ITI
--1
CREATE CLUSTERED INDEX IX_Dept_Hiredate ON Department (Manager_hiredate);
--Failed , there is already a clustered index named PK_Department on This table. As default index with the primary key.
--  Cannot create more than one clustered index on table 'Department'. 

--2
CREATE UNIQUE INDEX IX_St_Age ON Student (St_Age);
--Failed as The age column allow null. 
--Null is a unique value so there are already one or more rows in the table with 
--the same NULL value for the Age column.

-- 3. Try to Create Login Named(RouteStudent) who can
-- access Only student and Course tables from ITI DB
-- then allow him to select and insert data into tables
-- and deny Delete and update

-- Create login
go
CREATE LOGIN RouteStudent WITH PASSWORD = 'RouteStudent123';
go
CREATE USER RouteStudent FOR LOGIN  RouteStudent;

-- Grant select and insert permissions on Student table
GRANT SELECT, INSERT ON ITI.dbo.Student TO RouteStudent;
-- Grant select and insert permissions on Course table
GRANT SELECT, INSERT ON Course TO RouteStudent;

-- Deny delete and update permissions on Student table
DENY DELETE, UPDATE ON Student TO RouteStudent;

-- Deny delete and update permissions on Course table
DENY DELETE, UPDATE ON Course TO RouteStudent;

