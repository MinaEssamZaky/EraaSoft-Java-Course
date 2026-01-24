

CREATE TABLE Player (
id NUMBER NOT NULL,
name VARCHAR2(100) UNIQUE,
age NUMBER,
CONSTRAINT uq_player_id UNIQUE (id)
);

CREATE TABLE Manager (
id NUMBER NOT NULL,
name VARCHAR2(100),
salary NUMBER(10,2),
CONSTRAINT uq_manager_id_name UNIQUE (id, name)
);



CREATE TABLE Manager_PK (
id NUMBER PRIMARY KEY,
name VARCHAR2(100),
age NUMBER
);

CREATE TABLE Doctor (
id NUMBER PRIMARY KEY,
name VARCHAR2(100),
salary NUMBER(10,2)
);

CREATE TABLE Patient (
id NUMBER PRIMARY KEY,
name VARCHAR2(100),
age NUMBER
);

CREATE TABLE Doctor_Patient (
doctor_id NUMBER,
patient_id NUMBER,
CONSTRAINT pk_doctor_patient PRIMARY KEY (doctor_id, patient_id),
CONSTRAINT fk_dp_doctor FOREIGN KEY (doctor_id) REFERENCES Doctor(id),
CONSTRAINT fk_dp_patient FOREIGN KEY (patient_id) REFERENCES Patient(id)
);

CREATE TABLE Language (
id NUMBER PRIMARY KEY,
name VARCHAR2(100)
);

CREATE TABLE Teacher (
id NUMBER PRIMARY KEY,
name VARCHAR2(100),
salary NUMBER(10,2),
language_id NUMBER,
CONSTRAINT fk_teacher_language FOREIGN KEY (language_id)
REFERENCES Language(id)
);


CREATE TABLE Employee (
id NUMBER PRIMARY KEY,
name VARCHAR2(100),
age NUMBER
);

CREATE TABLE Phone (
id NUMBER PRIMARY KEY,
phoneNumber VARCHAR2(20),
employee_id NUMBER UNIQUE,
CONSTRAINT fk_phone_employee FOREIGN KEY (employee_id)
REFERENCES Employee(id)
);

