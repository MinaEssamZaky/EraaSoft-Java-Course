--------------------------------------------
-- TASK 1 : TRIM , LTRIM , RTRIM
--------------------------------------------

CREATE TABLE emp_test (
    name VARCHAR2(50)
);

INSERT INTO emp_test VALUES ('   Ahmed   ');
INSERT INTO emp_test VALUES ('***Mona***');
INSERT INTO emp_test VALUES ('   Ali');
INSERT INTO emp_test VALUES ('Sara   ');

-- Q2
SELECT name, TRIM(name) AS trimmed FROM emp_test;

-- Q3
SELECT name, LTRIM(name) AS ltrimmed FROM emp_test;

-- Q4
SELECT name, RTRIM(name) AS rtrimmed FROM emp_test;

-- Q5
SELECT name, TRIM('*' FROM name) AS removed_star FROM emp_test;



--------------------------------------------
-- TASK 2 : REPLACE , LPAD , RPAD
--------------------------------------------

-- Q1
SELECT REPLACE('database','a','@') FROM dual;

-- Q2
SELECT REPLACE('this is old system','old','new') FROM dual;

-- Q3
CREATE TABLE product (
    product_name VARCHAR2(30)
);

INSERT INTO product VALUES ('Laptop');
INSERT INTO product VALUES ('Mouse');
INSERT INTO product VALUES ('Keyboard');

-- Q4
SELECT LPAD(product_name,15,'*') FROM product;

-- Q5
SELECT RPAD(product_name,15,'#') FROM product;



--------------------------------------------
-- TASK 3 : TO_CHAR
--------------------------------------------

SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY') FROM dual;
SELECT TO_CHAR(SYSDATE,'Month YYYY') FROM dual;
SELECT TO_CHAR(12345.67,'99,999.99') FROM dual;
SELECT TO_CHAR(5000,'$99,999') FROM dual;



--------------------------------------------
-- TASK 4 : CASE
--------------------------------------------

CREATE TABLE students (
    name VARCHAR2(30),
    marks NUMBER
);

INSERT INTO students VALUES ('Ali',95);
INSERT INTO students VALUES ('Mona',85);
INSERT INTO students VALUES ('Sara',75);
INSERT INTO students VALUES ('Omar',60);
INSERT INTO students VALUES ('Hana',50);

SELECT name, marks,
CASE
  WHEN marks >= 90 THEN 'A'
  WHEN marks >= 80 THEN 'B'
  WHEN marks >= 70 THEN 'C'
  ELSE 'F'
END AS grade
FROM students;



--------------------------------------------
-- TASK 5 : DECODE
--------------------------------------------

CREATE TABLE orders (
    status CHAR(1)
);

INSERT INTO orders VALUES ('P');
INSERT INTO orders VALUES ('S');
INSERT INTO orders VALUES ('D');

SELECT status,
DECODE(status,
 'P','Pending',
 'S','Shipped',
 'D','Delivered'
) AS status_name
FROM orders;



--------------------------------------------
-- TASK 7
--------------------------------------------

CREATE TABLE customers (
    full_name VARCHAR2(50)
);

INSERT INTO customers VALUES ('  Ahmed ');
INSERT INTO customers VALUES ('##Mona##');
INSERT INTO customers VALUES (' Sara  ');

SELECT TRIM(full_name) FROM customers;
SELECT LTRIM(full_name) FROM customers;
SELECT RTRIM(full_name) FROM customers;
SELECT TRIM('#' FROM full_name) FROM customers;

SELECT REPLACE('promotion','o','0') FROM dual;
SELECT REPLACE('This is a basic course','basic','advanced') FROM dual;

CREATE TABLE departments (
    dept_name VARCHAR2(30)
);

INSERT INTO departments VALUES ('HR');
INSERT INTO departments VALUES ('IT');
INSERT INTO departments VALUES ('Sales');

SELECT LPAD(dept_name,15,'*') FROM departments;
SELECT RPAD(dept_name,15,'-') FROM departments;

SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY') FROM dual;
SELECT TO_CHAR(SYSDATE,'Day, Month YYYY') FROM dual;
SELECT TO_CHAR(123456.78,'999,999.99') FROM dual;
SELECT TO_CHAR(7000,'$99,999') FROM dual;
SELECT TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS') FROM dual;



--------------------------------------------
-- TASK 8 : AGGREGATE FUNCTIONS
--------------------------------------------

-- 1
SELECT AVG(salary) FROM employees;

-- 2
SELECT COUNT(*) FROM employees;

-- 3
SELECT MAX(salary) FROM employees;

-- 4
SELECT MIN(salary) FROM employees;

-- 5
SELECT SUM(salary) FROM employees;

-- 6
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

-- 7
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;

-- 8
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 50000;

-- 9
SELECT AVG(commission_pct)
FROM employees
WHERE commission_pct IS NOT NULL;

-- 10
SELECT COUNT(*)
FROM employees
WHERE salary > 10000;

-- 11
SELECT job_id, MAX(salary), MIN(salary)
FROM employees
GROUP BY job_id;

-- 12
SELECT manager_id, SUM(salary)
FROM employees
GROUP BY manager_id;

-- 13
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id;

-- 14
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) > 5;

-- 15
SELECT department_id,
COUNT(*),
AVG(salary),
MAX(salary),
MIN(salary)
FROM employees
GROUP BY department_id;

-- 16
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 8000 AND COUNT(*) < 10;

-- 17
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY SUM(salary) DESC
FETCH FIRST 1 ROW ONLY;

-- 18
SELECT department_id,
SUM(salary) AS total_salary,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;

COMMIT;
