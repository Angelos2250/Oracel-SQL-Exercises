SELECT MAX(salary) AS "Maximum", MIN(salary) AS "Minimum", SUM(salary) as "Summe", AVG(salary) AS "Durchschnitt"
FROM employees
WHERE job_ID = 'SA_REP';

SELECT COUNT(*) AS "Mitarbeiteranzahl"
FROM employees
WHERE department_ID = 50;

SELECT COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 3;

SELECT MAX(salary) AS "Maximum", MIN(salary) AS "Minimum", SUM(salary) as "Summe", ROUND(AVG(salary),-3) AS "Durchschnitt"
FROM employees
GROUP BY job_ID;

SELECT department_id, department_name, avg(salary)
FROM employees INNER JOIN departments USING (department_id)
GROUP BY department_id, department_name
ORDER BY AVG(salary) ASC;

SELECT job_id, SUM(salary)
FROM employees
GROUP BY job_id
HAVING SUM(salary) > 20000;

SELECT department_id, department_name, COUNT(*)
FROM employees INNER JOIN departments USING(department_id)
GROUP BY department_id, department_name
HAVING COUNT(*) > 1;

--------------------------------------------------------------------------------------

SELECT employee_id,last_name
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees)
ORDER BY salary ASC;

SELECT employee_id,last_name
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees)
AND department_id = 80
ORDER BY salary ASC;

SELECT employee_id,last_name, department_id
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE salary > 5000)
ORDER BY salary ASC;

SELECT employee_id,last_name, department_id
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE salary > 5000)
AND department_id = 90
ORDER BY salary ASC;

SELECT e.department_id,e.first_name,e.last_name
FROM employees e
WHERE 6000 <(SELECT AVG(salary)
              FROM employees
              GROUP BY department_id
              HAVING department_id = e.department_id);
              
SELECT last_name, department_id, job_id
FROM employees e
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE location_id = 1800);
                        
SELECT last_name, salary
FROM employees
WHERE manager_id IN (SELECT employee_id
                     FROM employees
                     WHERE last_name= 'Hunold' );
                     
SELECT ALL last_name, job_id, salary
FROM employees
WHERE salary > (SELECT MAX(salary)
                FROM employees
                WHERE job_id = 'SA_MAN')
ORDER BY salary DESC;

SELECT e1.last_name
FROM employees e1
WHERE NOT EXISTS (SELECT *
                  FROM employees e2
                  WHERE e2.manager_id = e1.manager_id);
                  
SELECT e1.last_name
FROM employees e1
WHERE e1.employee_id NOT IN (SELECT manager_id
                              FROM employees);

SELECT job_id , job_title, AVG(salary)
FROM employees JOIN jobs USING ( job_id )
GROUP BY job_id, job_title
HAVING AVG(salary) = (SELECT MAX(AVG(salary))
                      FROM employees
                      GROUP BY job_id);
                      
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 143);
        
SELECT e.employee_id,e.last_name
FROM employees e
WHERE 2 <= (SELECT COUNT(*)
            FROM job_history
            GROUP BY e.employee_id);
           
SELECT MIN(salary)
FROM employees;

SELECT last_name, salary, department_id
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);