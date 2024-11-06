USE Library
--Q1
Select CONCAT(Fname, ' ', Lname) As [Employee Name]
from Employee
where Len(Fname) > 3;

--Q2
SELECT COUNT(B.Id) As 'Programming Book'
from Book B join Category C on B.Cat_id = C.Id
WHERE c.Cat_name = 'Programming'

--Q3
SELECT COUNT(*) As 'Books by Harper'
FROM Book b right join Publisher P on b.Publisher_id = P.Id
where P.Name = 'HarperCollins'

--Q4
SELECT U.SSN,U.[User_Name], B.Borrow_date, B.Due_date
from Users U JOIN Borrowing B on U.SSN = B.User_ssn
WHERE b.Due_date < '2022-07-01'

--Q5:
SELECT CONCAT('[',B.Title,']', ' is written by [', A.Name, ']') As [Book and Author]
from Book B join Book_Author BA on B.Id = BA.Book_id 
join Author A on BA.Author_id = A.Id

--Q6:
SELECT U.[User_Name]
From Users U
WHERE U.[User_Name] Like '%A%'

--Q7:
SELECT Top(1) COUNT(*) 'Number of Borrowing' , B.User_ssn
from Borrowing B
GROUP by User_ssn
ORDER by 'Number of Borrowing' DESC

--Q8:

SELECT Sum(B.Amount)
from Borrowing B
group by B.User_ssn


--Q9: **
SELECT C.Cat_name
from Book B JOIN Category C on B.Cat_id  =C.Id
join Borrowing BR on b.Id = BR.Book_id


--Q10 
SELECT ISNULL(E.Email, E.Address), E.DOB
from Employee E

--Q11:
SELECT C.Cat_name, COUNT(B.Id) As [Number of Books]
From Book B join Category C on B.Cat_id = C.Id
GROUP by C.Cat_name


--Q12
SELECT B.Id
from Book B join Shelf S on B.Shelf_code = S.Code
join floor F on S.Floor_num = F.Number
where f.Number != 1 and s.Code != 'A1'

--Q13
SELECT COUNT(E.Id) As [Number of Employee] , f.Number as [Floor Number] , f.Num_blocks as [Number of Blooks]
from Employee E join floor F on E.Floor_no = F.Number
GROUP by F.Number,F.Num_blocks

--Q14
SELECT bb.Title, u.[User_Name]
from Borrowing B join Users U on B.User_ssn = U.SSN
join Book BB on bb.Id = B.Book_id
where B.Borrow_date BETWEEN '2022-03-01' and '2022-10-01';

--Q15

SELECT CONCAT(E.Fname, ' ', E.Lname) As EmployeeName , CONCAT(Es.Fname, ' ', Es.Lname) As SupervisorName
from Employee E RIGHT join Employee ES on E.Id = Es.Super_id 

--Q16
SELECT CONCAT(E.Fname, ' ', E.Lname) As EmployeeName , ISNULL(E.Salary, E.Bouns) AS 'Salary'
from Employee E

--Q17
Select MAX(E.Salary) As 'Max Salary', MIN(E.Salary) As 'Min Salary'
FROM Employee E

--Q18
GO
CREATE FUNCTION IsEven (@number int)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @msg VARCHAR(20)
    IF (@number % 2 = 0)
        BEGIN
            set @msg = 'Even'
        END
    ELSE
        BEGIN
            set @msg = 'Odd'
        END
    RETURN @msg
END

GO
Select dbo.IsEven(35)

--Q19
go
CREATE FUNCTION GetBookCateg (@category VARCHAR(30))
RETURNS TABLE
AS
RETURN
(
    SELECT B.Title
    From Category C join Book B on C.Id = B.Cat_id
    WHERE C.Cat_name = @category
);

GO
select * from dbo.GetBookCateg('Programming')

--Q20
go
CREATE FUNCTION BorrowingInfo(@PhoneNumber VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT b.Amount , b.Due_date, U.[User_Name], Bo.Title
    from User_phones UP join Users U on UP.User_ssn = U.SSN
    join Borrowing B on B.User_ssn = U.SSN
    join Book BO on Bo.Id = B.Book_id
    where UP.Phone_num = @PhoneNumber
);

go 
select * from dbo.BorrowingInfo('0120255444');

--Q21
go
CREATE FUNCTION duplicatedUserName(@UserName VARCHAR(max))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Count int, @msg VARCHAR(max)
    SELECT @Count = COUNT(*)
    from Users U WHERE U.USER_NAME = @UserName
    if @Count > 1
        set @msg = 'Username is duplicated'
    ELSE if @Count = 1
        set @msg = 'Username isnot duplicated'
    ELSE
        set @msg = 'Username is not found'
    
    RETURN @msg
END

go
select dbo.duplicatedUserName('Nasr Salem')


--Q22
GO
CREATE FUNCTION formatDate (@Date Date, @format VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN FORMAT(@Date, @format)
END


--Q23
go
CREATE PROCEDURE GetBooksPerCategory
AS
BEGIN
    SELECT C.Cat_name, COUNT(B.Id) As [Number of Books]
    From Book B join Category C on B.Cat_id = C.Id
    GROUP by C.Cat_name
END

--Q24
GO
CREATE PROCEDURE ReplaceFloorManager
    @OldEmpId INT,
    @NewEmpId INT,
    @FloorNumber INT
AS
BEGIN
    UPDATE Floor
    SET MG_ID = @NewEmpId
    WHERE Number = @FloorNumber AND MG_ID = @OldEmpId
END


--Q25
go
CREATE VIEW AlexAndCairoEmp AS
SELECT *
FROM Employee
WHERE Address = 'Alex' OR Address = 'Cairo'

--Q26
go
CREATE VIEW V2 AS
SELECT 
    S.Code,
    COUNT(B.Id) AS 'Number of Books'
FROM Shelf S
LEFT JOIN Book B ON S.Code = B.Shelf_code
GROUP BY S.Code


--Q27
go
CREATE VIEW V3 AS
SELECT 
    Code
FROM V2
WHERE [Number of Books] = (SELECT MAX([Number of Books]) FROM V2)


--Q28
GO
CREATE TABLE ReturnedBooks (
    USER_SSN INT,
    Book_Id INT,
    Due_Date Date,
    Return_Date Date,
    Fees DECIMAL(10,2)
)
GO
CREATE TRIGGER tr_InsertReturnBooks
on ReturnedBooks
INSTEAD of INSERT
AS
BEGIN
    DECLARE @ReturnDate Date, @Due_Date Date, @Fees DECIMAL(10,2), @user INT, @Book_ID INT
    SELECT @ReturnDate = i.Return_Date, @Due_Date = i.Due_Date, @user =i.USER_SSN, @Book_ID = i.Book_Id
    from inserted i

    if @ReturnDate =@Due_Date
        BEGIN
            SELECT @Fees = b.Amount
            from Borrowing B
            WHERE b.User_ssn = @user and @Book_ID = b.Book_id

            SET @Fees = 1.2 * @Fees
            INSERT into ReturnedBooks
            SELECT * , @Fees from inserted
        END
    ELSE
        BEGIN
            set @Fees = 0
            INSERT into ReturnedBooks
            select * , @Fees from inserted
        END
END

--Q29:
INSERT into [Floor] (Num_blocks,Number, MG_ID, Hiring_Date) VALUES (2, 7, 20, GETDATE())

go
EXEC dbo.ReplaceFloorManager 5, 12, 6

--Q30:
go
CREATE VIEW v_2006_check
AS
SELECT 
    f.MG_ID AS 'Manager Id',
    f.Number AS 'Floor Number', 
    f.Num_blocks AS 'Number of Blocks',
    f.Hiring_Date AS 'Hiring Date'
FROM Floor F
WHERE f.Hiring_Date BETWEEN '2022-03-01' AND '2022-05-31'

-- Attempt to insert data
go
INSERT INTO v_2006_check ([Manager Id], [Floor Number], [Number of Blocks], [Hiring Date])
VALUES 
    (2, 6, 2, '2023-08-07'),  -- Duplicated Floor number 6 
    (4, 7, 1, '2022-08-04')

/*Violation of PRIMARY KEY constraint 'PK_Floor'. Cannot insert duplicate key in object 'dbo.Floor'. The duplicate key value is (6).
*/


--Q31
GO
CREATE TRIGGER Tr_InsertInEmployee
on Employee
INSTEAD of INSERT, UPDATE, delete
AS
Begin
    print 'You are not allowed to take action on the Employee table.'
End

--Q32:

--1. 
insert into User_phones (Phone_num, User_ssn) VALUES (767567573, 50)
/*The INSERT statement conflicted with the FOREIGN KEY constraint "FK_User_phones_User". The conflict occurred in database "Library", table "dbo.Users", column 'SSN'.
*/

--2
UPDATE Employee
set Id = 21 where id = 20
/*You are not allowed to take action on the Employee table.
Rejected because the trigger created in Q31
(1 row affected)*/ 

--3
DELETE from Employee
WHERE id = 12
/*Rejected because the trigger created in Q31
But without the trigger it would be rejected the foreign key constraints referencing the Emp_Id column in other tables*/

--Q33:
CREATE LOGIN NourLogin WITH PASSWORD = 'NourLogin123'

CREATE USER MyUser FOR LOGIN NourLogin
GRANT SELECT, INSERT ON dbo.Employee TO MyUser
GRANT SELECT, INSERT ON dbo.Floor TO MyUser
DENY DELETE, UPDATE ON dbo.Employee TO MyUser
DENY DELETE, UPDATE ON dbo.Floor TO MyUser
