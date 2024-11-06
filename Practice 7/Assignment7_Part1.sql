--Create a scalar function that takes a date and returns the Month name of that date. 
/*
CREATE FUNCTION GetMonthName (@date date)
RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @monthName VARCHAR(20);

    SET @monthName = DATENAME(MONTH, @date);

    RETURN @monthName;
END;
*/
 -- select dbo.GetMonthName('10-10-2024')


--=============================================================================================================================
--Create a Table function that takes 2 integers and returns the values between them. Example Function(1 , 5) output : 2 , 3 , 4 
/*
CREATE FUNCTION GetValuesBetweenNumbers (@number1 INT, @number2 INT)
RETURNS @result TABLE (n INT)
AS
BEGIN
    DECLARE @currentNumber INT = @number1;

    WHILE @currentNumber <= @number2
    BEGIN
        INSERT INTO @result (n) VALUES (@currentNumber);
        SET @currentNumber = @currentNumber + 1;
    END;

    RETURN;
END; */

-- SELECT * FROM dbo.GetValuesBetweenNumbers(3, 7);

--=============================================================================================================================
 --Create a table-valued function that takes Student Number and returns Department Name with Student full name.

/* CREATE FUNCTION GetStudentInfo (@StudentNumber INT)
RETURNS @result TABLE (DepartmentName VARCHAR(50), StudentFullName VARCHAR(100))
AS
BEGIN
    INSERT INTO @result
    SELECT  d.Dept_Name [Department Name], s.St_Fname + ' ' + s.St_Lname AS [Student Full name] 
    FROM Student s
    INNER JOIN Department d ON s.Dept_Id = d.Dept_Id
    WHERE s.St_Id = @StudentNumber;

    RETURN;
END;*/

--select * from dbo.GetStudentInfo(1)
--=============================================================================================================================
/*--Create a scalar function that takes Student ID and returns a message to user 
--If first name and Last name are null then display 'First name & last name are null'
--If First name is null then display 'first name is null'
If Last name is null then display 'last name is null'
Else display 'First name & last name are not null' */

/*CREATE FUNCTION GetMessageForStudent (@StudentID INT)
RETURNS VARCHAR(max)
AS
BEGIN
    DECLARE @FirstName VARCHAR(50), @LastName VARCHAR(50), @Msg VARCHAR(50);

    SELECT @FirstName = s.St_Fname, @LastName = s.St_Lname
    FROM Student s
    WHERE s.st_id = @StudentID;

    IF @FirstName IS NULL AND @LastName IS NULL
        SET @Msg = 'First name & last name are null';
    ELSE IF @FirstName IS NULL
        SET @Msg = 'First name is null';
    ELSE IF @LastName IS NULL
        SET @Msg = 'Last name is null';
    ELSE
        SET @Msg = 'First name & last name are not null';

    RETURN @Msg;
END;*/

--SELECT dbo.GetMessageForStudent(1) AS Message;



--=============================================================================================================================
/*Create a function that takes an integer which represents the format of the Manager hiring date and displays department name, Manager Name and hiring date with this format. */


-- USE MyCompany
/*CREATE FUNCTION GetManagerInfo (@Format int)
RETURNS @result TABLE (DepartmentName VARCHAR(50), ManagerName VARCHAR(100), HiringDate VARCHAR(50))
AS
BEGIN
    INSERT INTO @result
    SELECT 
        d.Dname,
        e.Fname + ' ' + e.Lname AS ManagerName,
        CASE @Format
            WHEN 1 THEN CONVERT(VARCHAR, d.[MGRStart Date] , 101)  -- MM/dd/yyyy
            WHEN 2 THEN CONVERT(VARCHAR, d.[MGRStart Date], 102)  -- yyyy.MM.dd
            WHEN 3 THEN CONVERT(VARCHAR, d.[MGRStart Date], 103)  -- dd/MM/yyyy
            WHEN 4 THEN CONVERT(VARCHAR, d.[MGRStart Date], 104)  -- dd-MM-yyyy
            WHEN 5 THEN CONVERT(VARCHAR, d.[MGRStart Date], 105)  -- dd-mm-yyyy
            ELSE CONVERT(VARCHAR, d.[MGRStart Date], 120)  -- yyyy-mm-dd
        END AS HiringDate
    FROM Employee e
    INNER JOIN Departments d ON e.Dno = d.Dnum;

    RETURN;
END;


SELECT * FROM MyCompany.dbo.GetManagerInfo(5);*/
--=============================================================================================================================

/*Create multi-statement table-valued function that takes a string
If string='first name' returns student first name
If string='last name' returns student last name 
If string='full name' returns Full Name from student table  (Note: Use “ISNULL” function)
*/
/*CREATE FUNCTION GetStudentName (@string VARCHAR(50))
RETURNS @result TABLE (StudentName VARCHAR(100))
AS
BEGIN
    IF @string = 'first name'
        INSERT INTO @result
        SELECT ISNULL(St_Fname, '') AS StudentName
        FROM Student;
    ELSE IF @string = 'last name'
        INSERT INTO @result
        SELECT ISNULL(St_Lname, '') AS StudentName
        FROM Student;
    ELSE IF @string = 'full name'
        INSERT INTO @result
        SELECT ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '') AS StudentName
        FROM Student;

    RETURN;
END;
*/

--=============================================================================================================================
/*Create function that takes project number and display all employees in this project (Use MyCompany DB)*/

/*CREATE FUNCTION GetEmployeesInProject (@projectNumber INT)
RETURNS @result TABLE (EmployeeID INT, EmployeeName VARCHAR(100))
AS
BEGIN
    INSERT INTO @result
    SELECT e.SSN, e.Fname + ' ' + e.Lname AS EmployeeName
    FROM Employee e
    INNER JOIN Project p ON p.Dnum = e.Dno
    WHERE p.Pnumber = @projectNumber;

    RETURN;
END;
*/
--select * from MyCompany.dbo.GetEmployeesInProject(400)