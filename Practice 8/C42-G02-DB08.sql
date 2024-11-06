
--=================================================================================================
--===============================================Part (1)==================================================

--1. Create a view "V1" that displays student data for students who live in Alex or Cairo:
go
create View V1
AS
    SELECT * from Student s
    WHERE s.St_Address = 'Alex' or s.St_Address = 'Cairo'
    with check option


/*
1.Create view named “v_dept” that will display the
department# and department name
2. using the previous view try enter new department data
where dept# is ’d4’ and dept name is ‘Development’
*/

go
CREATE VIEW v_dept
as
    SELECT d.DeptName, d.DeptNo from Department d

go
insert into v_dept (DeptName, DeptNo) VALUES ('development', 4)  --It failed,



/*Create view name “v_2006_check” that will display
employee Number, the project Number where he works and
the date of joining the project which must be from the first of
January and the last of December 2006.this view will be
used to insert data so make sure that the coming new data
must match the condition */
go
create view v_2006_check
AS
    Select w.EmpNo, w.ProjectNo, W.Enter_Date from dbo.Works_on W
    WHERE w.Enter_Date between '2006-01-01' and '2006-12-01'



--=================================================================================================
--=============================================== Part (2) ==================================================


/*Part 02
1. Create a stored procedure to show the number of students per
department.[use ITI DB]*/
go
CREATE PROC GetStudentPerDept
AS
BEGIN
    SELECT count(*) As [Student Number], d.Dept_Name
    from Student S join Department d on d.Dept_Id = s.Dept_Id
    GROUP by d.Dept_Name
End

GO
EXEC GetStudentPerDept 


/*2. Create a stored procedure that will check for the Number of employees in
the project 100 if they are more than 3 print message to the user “'The
number of employees in the project 100 is 3 or more'” if they are less
display a message to the user “'The following employees work for the
project 100'” in addition to the first name and last name of each one.
[MyCompany DB]*/

--Project number = 100 ==> number of Employee > 3 ==> msg

go
CREATE PROC ProjectNumberOFEmplpyeeMsg
AS
BEGIN
    DECLARE @number int

    SELECT @number = count(*) from Works_for w where w.Pno = 100;

    if @number > 3
    begin
        print'The number of employees in the project 100 is 3 or more'
    END
    ELSE
    BEGIN
        print ' The following employees work for the project 100'
        SELECT E.Fname, E.Lname  FROM Works_for w join Employee E on W.ESSn =E.SSN where w.Pno = 100
    END
End

/*3. Create a stored procedure that will be used in case an old employee has left
the project and a new one becomes his replacement. The procedure should
take 3 parameters (old Emp. number, new Emp. number and the project
number) and it will be used to update works_on table. [MyCompany DB]*/

GO
CREATE or Alter PROCEDURE Update_EmployeeInfo
@OldEmpSSN INT,
@NewEmpSSN INT,
@ProjectNum INT
AS
BEGIN
    UPDATE Works_for set ESSn = @NewEmpSSN from Employee join Works_for on Employee.SSN = Works_for.ESSn
    where SSN = @OldEmpSSN and Pno = @ProjectNum;
END

go
EXEC Update_EmployeeInfo  223344,669956, 100

-- =================================================================================================
-- =============================================== Part (3) ==================================================

/*
1. Create a stored procedure that calculates the sum of a given range
of numbers
*/
--start number -- end number -- sum --
go
CREATE PROC sumOfRangeOfnumbers
@startNumber int,
@EndNumber int
AS
BEGIN
DECLARE @SumOfNumbers INT
    set @SumOfNumbers = 0
    while @startNumber <= @EndNumber
    BEGIN
        set @SumOfNumbers = @startNumber + @SumOfNumbers
        set @startNumber = @startNumber + 1
    END

    SELECT @SumOfNumbers As sum
END


go
exec sumOfRangeOfnumbers 1, 3

--2. Create a stored procedure that calculates the area of a circle given its radius

go
CREATE or ALTER PROC AreaOfCircle
@r DECIMAL
AS
BEGIN
    DECLARE @Area DECIMAL
    set @Area = @r * @r * 3.14
    SELECT @Area As [Area of circle]
END

go
EXEC AreaOfCircle 1

/*3. Create a stored procedure that calculates the age category based on
a person's age ( Note: IF Age < 18 then Category is Child and if
Age >= 18 AND Age < 60 then Category is Adult otherwise
Category is Senior)*/

go
CREATE PROC AgeGroup
@Age INT
AS
BEGIN
    if @Age < 18
        print 'This age category is Child'
    ELSE IF @Age >= 18 and @Age < 60
        PRINT 'This age category is  Adult'
    ELSE
        PRINT 'This age category is Senior'
END

go
exec AgeGroup 90

/*
4. Create a stored procedure that determines the maximum,
minimum, and average of a given set of numbers ( Note : set of
numbers as Numbers = '5, 10, 15, 20, 25')
*/



--=================================================================================================
--===============================================Part 4==================================================


/*
Use ITI DB
1. Create a trigger to prevent anyone from inserting a new record in the
Department table ( Display a message for user to tell him that he can’t
insert a new record in that table )
*/
go
CREATE or ALTER TRIGGER PreventInsertIntoDeptTable
on ITI.dbo.Department
INSTEAD of INSERT
AS
    DECLARE @depName VARCHAR(20)
    BEGIN
        SELECT @depName=i.Dept_Name  from inserted i
        print 'You cannot insert'+ @depName +'a new department into this table';
    END;


/*Create a table named “StudentAudit”. Its Columns are (Server User Name ,
Date, Note)
Server User Name Date Note*/

CREATE TABLE StudentAudit
(
ServerUserName VARCHAR(50), --Return type for SUSER_NAME
[DATE] DATETIME,
Note VARCHAR(max)
)

/*
2. Create a trigger on student table after insert to add Row in
StudentAudit table
• The Name of User Has Inserted the New Student
• Date
• Note that will be like ([username] Insert New Row with Key =
[Student Id] in table [table name]
*/
go
CREATE or ALTER trigger tr_AfterInsert_StudentAudit
on student
after INSERT
AS
BEGIN
DECLARE @note VARCHAR(max)
   select @note = CONCAT(SYSTEM_USER, ' inserted new Row with Key =', i.St_Id , ' in Table Student  ')
   from inserted i insert into StudentAudit
   VALUES (SUSER_NAME(),GETDATE(), @note)  -- using user_name only showed dbo but this function showd my signed in username
END

select * from StudentAudit

insert into student(St_Id, St_Fname)
VALUES (4535, 'Nour')
/*
3. Create a trigger on student table instead of delete to add Row in
StudentAudit table
○ The Name of User Has Inserted the New Student
○ Date
○ Note that will be like “try to delete Row with id = [Student Id]”*/

GO
CREATE TRIGGER tr_deleteFromStudent
on student
INSTEAD OF DELETE
AS
BEGIN
DECLARE @note VARCHAR(max)
    SELECT @note = CONCAT('try to delete Row with id = ', d.St_Id)
    from deleted d INSERT into StudentAudit
    VALUES (SUSER_NAME(), GETDATE(), @note)
END


DELETE from Student
where St_Id = 4535

SELECT * from StudentAudit

/*
Use MyCompany DB:
4. Create a trigger that prevents the insertion Process for
Employee table in March*/

GO
CREATE TRIGGER tr_preventInsertionEmp
on MyCompany.dbo.Employee
INSTEAD of INSERT
AS
    BEGIN
        DECLARE @month varchar, @employeeID int
        select @month = Month(GETDATE()) from inserted
        if @month = 3
            BEGIN
                PRINT 'You cannot insert month in March'
            END
        ELSE
            BEGIN
               insert into Employee SELECT *
               from inserted
            END
    END