SELECT e.manager_id AS "Emp #", e.first_name AS "Employee",e.last_name AS "Employee",e.job_id AS "Job",e.hire_date AS "Hire Date"
FROM employees e;

SELECT DISTINCT manager_id
FROM employees;

SELECT *
FROM departments
WHERE manager_id = 201;

SELECT last_name,salary
FROM employees
WHERE salary < 6000;

SELECT last_name,salary,department_id
FROM employees
WHERE employee_id=124;

SELECT last_name,job_id,hire_date
FROM employees
ORDER BY hire_date ASC;

SELECT last_name,department_id
FROM employees
WHERE department_id = 20
ORDER BY last_name ASC;

SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct = 0.2;

---------------------------------------------

SELECT l.location_id,l.street_address, l.city
FROM locations l NATURAL JOIN countries c;

SELECT e.last_name,e.department_id,d.department_name
FROM employees e
LEFT JOIN departments d ON (e.department_id = d.department_id)
ORDER BY e.last_name DESC;

SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d ON (e.department_id = d.department_id)
LEFT JOIN locations l ON (d.location_id = l.location_id)
WHERE l.city = 'Oxford';

SELECT e.last_name AS "Employee", e.employee_id AS "Emp#",m.last_name AS "Manager", m.manager_id AS "Mgr#"
FROM employees e
INNER JOIN employees m ON (e.manager_id = m.manager_id);

SELECT e.last_name,e.salary
FROM employees e
JOIN job_grades j ON e.salary > j.lowest_sal
WHERE j.grade_level = 'E';

SELECT e.last_name,e.job_id,d.department_name
FROM employees e
LEFT JOIN departments d ON (e.department_id = d.department_id)
WHERE e.salary > 5000;

------------------------------------------------------------------

SELECT job_id
FROM jobs
MINUS (SELECT job_id
       FROM employees);

SELECT country_id, country_name
FROM countries
minus (SELECT country_id, country_name
       FROM locations
       INNER JOIN countries USING (country_id));
       
SELECT employee_id
FROM employees
WHERE manager_id > 0
UNION
SELECT employee_id
FROM job_history;

SELECT employee_id , job_id , hire_date
FROM employees
INTERSECT
SELECT employee_id , job_id , start_date AS hire_date
FROM job_history;
