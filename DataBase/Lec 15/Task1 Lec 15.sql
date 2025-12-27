--  Create Table DOCTOR

CREATE TABLE DOCTOR  (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary  NUMBER,
    address VARCHAR2(100)
);

--====================================================================================================================================================================================================

--  Insert 10 Row With Data

INSERT INTO DOCTOR (id,name,salary, address)
VALUES (1,'Mina Essam', 10000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (2,'Ahmed Essam', 20000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (3,'Mina Kero', 25000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (4,'Ahmed Ali', 15000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (5,'Mohamed Ali', 30000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (6,'Sara Mohamed', 40000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (7,'Sara Ali', 30000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (8,'Aya Ahmed', 40000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (9,'Aya Mohamed', 35000, 'alex' );
INSERT INTO DOCTOR (id,name,salary, address)
VALUES (10,'Eslam Mohamed', 20000, 'alex' );

--======================================================================================================================================

-- Update record number 3 

UPDATE Doctor SET salary = 20000 WHERE id = 3;

--======================================================================================================================================

--Delete record number 9

DELETE  DOCTOR WHERE id = 9;

--======================================================================================================================================

--Concatenation all name with salary  of all rows

SELECT name || ' - ' || salary AS name_salary FROM Doctor;

--======================================================================================================================================

--Display all record with salary * 2

SELECT id, name, salary * 2 AS double_salary, address FROM Doctor;

--======================================================================================================================================

--Select all data with salary

SELECT * FROM Doctor WHERE salary IN (20000, 40000, 60000);

--=====================================================================================================================================

--Rename table Doctor to PRD_DOCTOR

ALTER TABLE Doctor RENAME TO PRD_DOCTOR;

DROP TABLE PRD_DOCTOR ;
