--Part 01
Use ITI
--1.	Display instructors who have salaries less than the average salary of all instructors.
SELECT * from Instructor WHERE Salary < (select AVG(Salary) from Instructor)

--2.	Display the Department name that contains the instructor who receives the minimum salary.
SELECT Dept_Name from Department WHERE Dept_Id = (Select Dept_Id from Instructor where salary = (Select MIN(Salary) from Instructor))

--3.	Select max two salaries in instructor table. 
SELECT top(2) salary from Instructor where salary is not null order by Salary DESC

--4.	Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”
SELECT Ins_Name, Ins_Id, salary ,Dept_Id, Rank from (
    select Ins_Name, Ins_Id,salary , Dept_Id, ROW_NUMBER() over (partition by Dept_Id order by salary desc) As Rank from Instructor  ) 
As Ranker where Rank in (1,2)

--5.	 Write a query to select a random  student from each department.  “using one of Ranking Functions
SELECT * from (
    select *, ROW_NUMBER() over (partition by Dept_Id order by newid()) Rank from Student where Dept_Id is not null) newTable WHERE Rank = 1 
