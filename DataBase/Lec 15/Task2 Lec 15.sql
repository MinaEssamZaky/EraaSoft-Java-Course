

--Create Employees Table

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Department VARCHAR2(50),
    Salary NUMBER
);

--======================================================================================================================================

--Insert Records

INSERT ALL
    INTO Employees VALUES (101, 'John1', 'Doe1', 'HR', 20000)
    INTO Employees VALUES (102, 'John2', 'Doe2', 'IT', 50000)
    INTO Employees VALUES (103, 'John3', 'Doe3', 'CS', 40000)
    INTO Employees VALUES (104, 'John4', 'Doe4', 'IT', 10000)
    INTO Employees VALUES (105, 'John5', 'Doe5', 'ZX', 30000)
SELECT * FROM dual;


--======================================================================================================================================

--Update Salary for EmployeeID = 101

UPDATE Employees SET Salary = 600000 WHERE EmployeeID = 101;


--======================================================================================================================================

--Delete Record Where Department = '101'

DELETE FROM Employees
WHERE Department = 'HR';



--======================================================================================================================================

--Retrieve All Employees in IT Department

SELECT *
FROM Employees
WHERE Department = 'IT';

--======================================================================================================================================

--Select All Data With FirstName + LastName Concatenated

SELECT EmployeeID, FirstName || ' ' || LastName AS FullName, Department, Salary
FROM Employees;




