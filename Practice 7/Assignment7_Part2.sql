--Part 02 (Views)
--Note : # means number and for example d2 means department which has id or number 2

--Use ITI DB:
 --Create a view that displays the student's full name, course name if the student has a grade more than 50. 
/*CREATE VIEW StudentInformation
AS
SELECT s.St_Fname + ' ' + s.St_Lname as [Student full name], sc.Crs_Id
 from Stud_Course sc
 Inner join Student s on s.St_Id = sc.St_Id
 Inner join Course c on c.Crs_Id = sc.Crs_Id
 where sc.Grade > 50*/


--select * from StudentInformation

--=====================================================================================================================
-- Create an Encrypted view that displays manager names and the topics they teach. 
/*CREATE VIEW InstructorCourse
with encryption
    As  
    select I.Ins_Name [Instructor name], T.Top_Name [Topic name] from Instructor I
    join Ins_Course IC on i.Ins_Id = IC.Ins_Id
    join course c on c.Crs_Id = IC.Crs_Id
    join Topic T on t.Top_Id = c.Top_Id*/

--SELECT * from InstructorCourse
--=====================================================================================================================
--Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department “use Schema binding” 
--and describe what is the meaning of Schema Binding
/*WITH SCHEMABINDING specifies that the view is schema-bound, which means that the view is bound to the 
underlying tables and columns, 
and any changes to the tables or columns will affect the view.*/

/*CREATE VIEW dbo.InturctorDep
    WITH SCHEMABINDING
    AS
    SELECT i.Ins_Name, d.Dept_Name
    FROM dbo.Instructor i
    INNER JOIN dbo.Department d ON i.Dept_Id = d.Dept_Id
    WHERE d.Dept_Name IN ('SD', 'Java');

SELECT * from dbo.InturctorDep*/

--=====================================================================================================================
--Create a view that will display the project name and the number of employees working on it. (Use Company DB)

/*create view ProjectEmployeeInfo
AS
    select p.Pname [Project Name], COUNT(E.SSN) [Number of employees]
    from Project p 
    inner join Works_for w on w.Pno = p.Pnumber
    inner join Employee E on w.ESSn = E.SSN
    GROUP by  p.Pname

SELECT * from ProjectEmployeeInfo */

--=====================================================================================================================
--=====================================================================================================================

/*use CompanySD32_DB:
Create a view named   “v_clerk” that will display employee Number ,project Number, the date of hiring of all the jobs of the type 'Clerk'.
*/
/*CREATE VIEW v_clerk AS
SELECT e.EmpNo, p.ProjectNo, w.Enter_Date
FROM HR.Employee e
INNER JOIN Works_on w ON e.EmpNo = w.EmpNo
INNER JOIN HR.Project p ON w.ProjectNo = p.ProjectNo
WHERE w.Job = 'Clerk';
*/
--=====================================================================================================================

/*
 Create view named  “v_without_budget” that will display all the projects data without budget

CREATE VIEW v_without_budget AS
    SELECT *
    FROM HR.Project
    WHERE Budget IS NULL;

 */
 --=====================================================================================================================

/* 
Create view named  “v_count “ that will display the project name and the Number of jobs in it

CREATE VIEW v_count AS
SELECT p.ProjectName, COUNT(w.EmpNo) AS NumberOfJobs
FROM HR.Project p
INNER JOIN Works_on w ON p.ProjectNo = w.ProjectNo
GROUP BY p.ProjectName;

*/
--=====================================================================================================================

/* Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’ . (use the previously created view  “v_clerk”)
CREATE VIEW v_project_p2 AS
SELECT e.EmpNo
FROM v_clerk e
WHERE e.ProjectNo = 'p2';
*/
--=====================================================================================================================
/*
modify the view named  “v_without_budget”  to display all DATA in project p1 and p2. 
ALTER VIEW v_without_budget AS
SELECT *
FROM HR.Project P
WHERE p.ProjectNo IN ('p1', 'p2');
*/


--=====================================================================================================================
/*Delete the views  “v_ clerk” and “v_count”
DROP VIEW v_clerk;
DROP VIEW v_count;
*/

--=====================================================================================================================
--Create view that will display the emp# and emp last name who works on deptNumber is ‘d2’
/*CREATE VIEW v_dept_d2 AS
SELECT e.EmpNo, e.EmpLname
FROM HR.Employee e
INNER JOIN Company.Department d ON e.DeptNo = d.DeptNo
WHERE d.DeptNo = 2;*/

--SELECT * from v_dept_d2

-- There is not deptNumber with value d2
--=====================================================================================================================
--Display the employee  lastname that contains letter “J” (Use the previous view created in Q#7)
/*
SELECT d.EmpLname
FROM v_dept_d2 d
WHERE d.EmpLname LIKE '%J%';*/
--=====================================================================================================================

--Create view named “v_dept” that will display the department# and department name

/*CREATE VIEW v_dept AS
SELECT DeptNo, DeptName
FROM Company.Department;

SELECT * from v_dept*/
