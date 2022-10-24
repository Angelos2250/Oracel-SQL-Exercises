SELECT last_name,hire_date
FROM employees
WHERE hire_date BETWEEN TO_DATE('1.1.1999','dd.mm.yyyy') AND TO_DATE('31.12.1999','dd.mm.yyyy');

SELECT salary, last_name, commission_pct, ADD_MONTHS(hire_date,24)
FROM employeeAs
WHERE commission_pct IS NOT NULL;

SELECT last_name,EXTRACT(year FROM hire_date) -EXTRACT(year FROM (SELECT hire_date
                                                        FROM employees
                                                        WHERE last_name = 'King')) AS DIF
FROM employees
WHERE department_id = 20 OR department_id = 50
ORDER BY DIF ASC;

SELECT last_name,hire_date
FROM employees
WHERE EXTRACT(year FROM hire_date) > EXTRACT(year FROM (SELECT hire_date
                                                        FROM employees
                                                        WHERE last_name = 'Davies'));
                                                        
------------------------------------------------------------------------------------------

SELECT last_name
FROM employees
WHERE last_name LIKE '%e_';

SELECT last_name
FROM employees
WHERE REGEXP_LIKE(last_name,'e.$');
                                                        
SELECT last_name
FROM employees
WHERE REGEXP_LIKE(last_name,'(a|e)');

SELECT employee_id,first_name,last_name, UTL_MATCH.JARO_WINKLER_SIMILARITY(LOWER(last_name),'unhold') AS x
FROM employees
ORDER BY x DESC;

SELECT employee_id,first_name,last_name, UTL_MATCH.JARO_WINKLER_SIMILARITY(LOWER(CONCAT(first_name,last_name)),'Evgeni Lotsy') AS x
FROM employees
ORDER BY x DESC;

--------------------------------------------------------------------------------------

SELECT country_id, COUNT(employee_id)
FROM Locations
JOIN departments  USING (location_id) 
JOIN employees USING (department_id)
WHERE salary NOT BETWEEN 5000 AND 12000
GROUP BY country_id;

SELECT last_name,job_id,salary
FROM employees
WHERE salary NOT IN (2500,3500,7500)
AND REGEXP_LIKE(job_id,'SA_REP|ST_CLERK');

SELECT last_name AS "Employee",salary AS "Monthly Salary"
FROM employees
WHERE REGEXP_LIKE(job_id,'(IT|AC)')
AND salary BETWEEN 5000 AND 12000;

SELECT d.department_name, j.grade_level, COUNT(e.employee_id) AS "Employee Count"
FROM departments d 
JOIN employees e ON d.department_id = e.department_id 
JOIN job_grades j ON e.salary >= j.lowest_sal AND e.salary <= j.highest_sal
GROUP BY d.department_name,j.grade_level;

SELECT d.department_name,NVL(e.last_name,'position vacant')
FROM departments d
LEFT JOIN employees e ON d.manager_id = e.manager_id;

SELECT last_name, salary
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE REGEXP_LIKE(last_name,'(Fay|Gietz)'))
AND salary > 10000;

SELECT department_id, department_name,location_id
FROM departments
JOIN employees USING (department_id)
WHERE job_id != 'SA_REP';

SELECT department_id
FROM departments
JOIN employees USING (department_id)
WHERE job_id=job_id;

SELECT e.last_name,e.job_id,e.department_id
FROM employees e
WHERE e.department_id IN (SELECT c.department_id
                          FROM employees c
                          WHERE c.employee_id IN (103,142)
                          AND e.job_id = c.job_id);
                          
SELECT (e.last_name||', '||e.job_id) AS "Employee And Title"
FROM employees e
ORDER BY (SELECT AVG(salary)
          FROM employees
          GROUP BY e.department_id) DESC;
          
SELECT department_id,department_name,COUNT(*)
FROM departments 
JOIN employees USING(department_id)
GROUP BY department_id,department_name
HAVING COUNT(*) < 3;

SELECT department_id, department_name, count(*)
FROM departments JOIN employees USING (department_id)
GROUP BY department_id, department_name
HAVING count(*) = (SELECT max(count(*))
                    FROM employees
                    GROUP BY department_id);

SELECT department_id, department_name, count(*)
FROM departments JOIN employees USING (department_id)
GROUP BY department_id, department_name
HAVING count(*) IN (SELECT min(count(*))
                    FROM employees
                    GROUP BY department_id);