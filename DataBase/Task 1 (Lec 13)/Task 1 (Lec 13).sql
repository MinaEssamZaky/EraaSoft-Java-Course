
-- إنشاء جدول1  Manger

CREATE TABLE Manger (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    age NUMBER,
    birth_date DATE,
    address VARCHAR2(200)
);

--=====================================================================================================================================
-- 2️ حذف عمود address

ALTER TABLE Manger
DROP COLUMN address;

--=====================================================================================================================================

-- 3️ إضافة أعمدة city_address و street

ALTER TABLE Manger
ADD (city_address VARCHAR2(100), street VARCHAR2(100));

--=====================================================================================================================================

-- 4️ تعديل اسم العمود name إلى full_name

ALTER TABLE Manger
RENAME COLUMN name TO full_name;

--=====================================================================================================================================

-- 5️ جعل الجدول للقراءة فقط باستخدام Trigger

CREATE OR REPLACE TRIGGER Manger_ReadOnly
BEFORE INSERT OR UPDATE OR DELETE ON Manger
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'This table is read-only');
END;
/

--=====================================================================================================================================

-- Test Trigger

INSERT INTO Manger (id, full_name, age, birth_date, city_address, street)
VALUES (1, 'Mina Essam', 23, TO_DATE('2002-12-11','YYYY-MM-DD'), 'Cairo', 'Tahrir Street');

--=====================================================================================================================================

-- 6️ إنشاء جدول Owner بنفس أعمدة Manger ولكن فقط id, name, birth_date

CREATE TABLE Owner AS
SELECT id, full_name AS name, birth_date
FROM Manger
WHERE 1=0; 

--=====================================================================================================================================

-- 7️ إعادة تسمية جدول Manger إلى Master

ALTER TABLE Manger
RENAME TO Master;

--=====================================================================================================================================

---- 8️ حذف جميع الجداول


DROP TABLE Owner CASCADE CONSTRAINTS;
DROP TABLE Master CASCADE CONSTRAINTS;
