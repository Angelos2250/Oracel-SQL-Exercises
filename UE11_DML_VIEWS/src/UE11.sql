CREATE TABLE MY_EMPLOYEE (
    id NUMBER(6) CONSTRAINT my_employee_id_pk PRIMARY KEY,
    last_name VARCHAR2(25) NOT NULL,
    first_name VARCHAR2(20) NOT NULL,
    userid VARCHAR2(8) NOT NULL,
    salary NUMBER(8,2) NOT NULL
);

CREATE TABLE MY_JOB_HISTORY (
    id NUMBER(6) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR2(10) NOT NULL,
    department_id NUMBER(4) NOT NULL
);

ALTER TABLE MY_JOB_HISTORY ADD (
    CONSTRAINT my_jhist_emp_id_st_date_pk PRIMARY KEY (id, start_date),
    CONSTRAINT my_jhist_job_fk FOREIGN KEY (job_id) REFERENCES jobs,
    CONSTRAINT my_jhist_emp_fk FOREIGN KEY (id) REFERENCES employees,
    CONSTRAINT my_jhist_dept_fk FOREIGN KEY (department_id) REFERENCES departments
);


--1.
INSERT INTO my_employee VALUES(1, 'Patel', 'Ralph', 'rpatel', '895');

--2.
INSERT INTO my_employee (ID, LAST_NAME, FIRST_NAME, USERID, SALARY)
  VALUES(2, 'Dancs', 'Betty', 'bdancs', '860');

--3.
COMMIT;

INSERT ALL
  INTO my_employee VALUES(3, 'Biri', 'Ben', 'bbiri', '1100')
  INTO my_employee VALUES(4, 'Newman', 'Chad', 'cnewman', '750')
  INTO my_employee VALUES(5, 'Ropeburn', 'Audrey', 'aropebur', '1550')
SELECT * FROM dual;

--4.
UPDATE my_employee SET last_Name = 'Drexler' WHERE ID = 3;

--5.
UPDATE my_employee SET salary = '1000' WHERE salary < 900;

--6.
DELETE FROM my_employee WHERE last_name = 'Dancs' AND first_name = 'Betty';
COMMIT;

--7.
DELETE FROM my_employee;
SELECT * FROM my_employee;

--8.
ROLLBACK;
SELECT * FROM my_employee;

--9.
INSERT INTO my_job_history(id, start_date, end_date, job_id, department_id)
SELECT employee_id, start_date, end_date, job_id, department_id
  FROM job_history;

COMMIT;

DELETE FROM my_job_history h
 WHERE start_date = (SELECT MIN(start_date)
                       FROM my_job_history j
                      WHERE h.id = j.id
                     GROUP BY j.id
                     HAVING COUNT(id) > 1);
SELECT *
FROM my_job_history;

--Aufgabe 2

MERGE INTO bonus b
USING employees e
ON (b.employee_id = e.employee_id)
WHEN MATCHED THEN
    UPDATE SET b.bonus = b.bonus *1.15
        WHERE e.salary < 11000
    DELETE WHERE e.salary >= 11000
    OR e.department_id = 50
WHEN NOT MATCHED THEN
    INSERT (employee_id,bonus)
    VALUES (e.employee_id, e.salary * 0.01)
    WHERE e.department_id !=50 AND e.salary < 11000;    

--AUFGABE 3

--1.
CREATE VIEW EMPLOYEES_VU AS
    SELECT employee_id AS ID, first_name || ' ' || last_name AS NAME, department_id AS DEPARTMENT_ID
      FROM employees;
SELECT *
  FROM EMPLOYEES_VU;

--2.
CREATE VIEW DEPT50 AS
    SELECT employee_id AS EMPNO, last_name AS employee, department_id as DEPTNO
      FROM employees
     WHERE department_id = 50
WITH CHECK OPTION;

SELECT *
  FROM DEPT50;

--3.
UPDATE DEPT50
   SET DEPTNO = 80
 WHERE employee = 'Matos';
 --Funktioniert nicht(wie gewollt): Fehlerbericht Verletzung der WHERE-Klausel einer View WITH CHECK OPTION

--4.
CREATE VIEW SALVU50 AS
    SELECT employee_id AS ID_NUMBER, last_name AS NAME, (salary * 12) AS ANN_SALARY
      FROM employees
     WHERE department_id = 50;

SELECT *
  FROM SALVU50;

--5.
CREATE VIEW DETAILEDDEP AS
    SELECT department_name AS NAME, MIN(salary) AS MINSAL, MAX(salary) AS MAXSAL, AVG(salary) AS AVGSAL
      FROM employees
    INNER JOIN departments USING (department_id)
     GROUP BY department_name;

SELECT *
  FROM DETAILEDDEP;

--6.
CREATE VIEW EMPVU10 AS
    SELECT employee_id, last_name, job_id
      FROM employees
     WHERE department_id = 10
WITH READ ONLY;

SELECT *
  FROM EMPVU10;

--7.
DELETE FROM EMPVU10
 WHERE employee_id = 10;

-- Aufgabe 4
--2.
 SELECT e.last_name, e.first_name, e.job_id, d.department_name
  FROM employees e JOIN departments d ON(e.department_id = d.department_id) 
      JOIN (SELECT job_id, AVG(salary) AS avg_salary
            FROM employees
            GROUP BY job_id) salaries
      ON e.job_id = salaries.job_id
  WHERE e.salary > salaries.avg_salary ;
