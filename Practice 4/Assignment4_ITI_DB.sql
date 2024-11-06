--Get all instructors Names without repetition
SELECT Ins_Name [Instructor Name]
from instructor


--Display instructor Name and Department Name Note: display all the instructors if they are attached to a department or not
SELECT I.Ins_Name [Instructor Name] , d.Dept_Name
from Instructor I LEFT join Department d
on i.Dept_Id = d.Dept_Id

--Display student full name and the name of the course he is taking
--For only courses which have a grade  
SELECT s.St_Fname + ' ' + s.St_Lname [Full name], cr.Crs_Name  from  Course cr, Student s join Stud_Course st on s.St_Id = st.St_Id WHERE Grade is not null


print @@VERSION

/*Started executing query at Line 16
Microsoft SQL Server 2022 (RTM-CU12-GDR) (KB5036343) - 16.0.4120.1 (X64) 
	Mar 18 2024 12:02:14 
	Copyright (C) 2022 Microsoft Corporation
	Developer Edition (64-bit) on Linux (Ubuntu 22.04.4 LTS) <X64>


the version of the SQL Server */

print  @@SERVERNAME --sql --> the actual name of the server