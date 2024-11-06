--Part 1:
--Use ITI

-- Retrieve the number of students with a value in their age
SELECT COUNT(*) FROM Student
WHERE St_Age IS NOT NULL;

-- Display the number of courses for each topic name
SELECT t.Top_Name [Topic name], COUNT(c.Crs_Id) [Number of courses]
FROM Topic t
LEFT JOIN Course C ON t.Top_Id = c.Top_Id
GROUP BY t.Top_Name;

-- Select Student first name and the data of his supervisor  *** Self relationshop between the table student and supervisor

SELECT s1.St_Fname AS Student_Name, s2.St_Fname AS Supervisor_Name, 
s2.St_Lname AS Supervisor_Lname, s2.St_Address AS Supervisor_Address, 
s2.St_Age AS Supervisor_Age
FROM Student s1
LEFT JOIN Student s2 ON s1.St_super = s2.St_Id

/*Display student with the following Format (use isNull function)
Student ID
Student Full Name
Department name
*/

Select  ISNULL(S.St_Id, 'No ID' ) [Student ID],
		ISNULL(S.St_Fname + ' '+ S.St_Lname, 'NO Name') [Student Full Name],
		ISNULL(D.Dept_Name , 'No Data') [Department Name]
From Student S LEFT JOIN Department D ON S.Dept_Id = D.Dept_Id;


-- Select instructor name and his salary but if there is no salary display value ‘0000’ . “use one of Null Function”
SELECT i.Ins_Name [Instructor Name], COALESCE(i.Salary, '0000') Salary
FROM Instructor i;

---- Select Supervisor first name and the count of students who supervises on them
SELECT s.St_super, COUNT(*) AS [Num Students]
FROM Student AS s
GROUP BY s.St_super;

-- Display max and min salary for instructors
SELECT MIN(i.Salary) AS [Min Salary], MAX(i.Salary) AS [Max Salary]
FROM Instructor AS i;

-- Select Average Salary for instructors
SELECT AVG(I.Salary) AS [Avg Salary]
FROM Instructor AS I;