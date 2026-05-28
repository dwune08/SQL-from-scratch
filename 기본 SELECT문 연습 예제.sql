

-- 예제 1번
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE salary >= 3000;

-- 예제 2번
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE job_id = 'ST_MAN';

-- 예제 3번
SELECT employee_id, first_name, job_id, salary, hire_date, department_id
FROM employees
WHERE hire_date >= TO_DATE('2006-01-01', 'YYYY-MM-DD');

-- 예제 4번
SELECT first_name, job_id, salary, department_id
FROM employees
WHERE salary BETWEEN 3000 AND 5000;

-- 예제 5번
SELECT employee_id, first_name, job_id, salary, hire_date, department_id
FROM employees
WHERE hire_date >= TO_DATE('2005-01-01', 'YYYY-MM-DD')
AND hire_date <  TO_DATE('2006-01-01', 'YYYY-MM-DD');

-- 예제 6번
SELECT employee_id, first_name || ' ' || last_name AS "Name", 
      salary, job_id, hire_date, manager_id
FROM employees;

-- 예제 7번
SELECT first_name || ' ' || last_name AS "Name", 
        job_id AS "Job", 
        salary AS "Salary", 
        salary*12+100 AS "Increased Ann_Salary", 
        (salary+100)*12 AS "Increased Salary" 
FROM employees;

-- 예제 8번
SELECT first_name || ': 1 Year Salary = $' || Salary*12 AS "1 Year Salary"
FROM employees;

-- 예제 9번
SELECT DISTINCT department_id, job_id
FROM employees
ORDER BY department_id;

-- 예제 10번
SELECT first_name || ' ' || last_name AS "Name", salary
FROM employees
WHERE salary NOT BETWEEN 7000 AND 10000
ORDER BY salary;

-- 예제 11번
SELECT first_name || ' ' || last_name AS "Name", employee_id, hire_date
FROM employees
WHERE hire_date BETWEEN TO_DATE('2006-05-20', 'YYYY-MM-DD') 
      AND TO_DATE('2007-05-20', 'YYYY-MM-DD')
ORDER BY hire_date;

-- 예제 12번
SELECT first_name || ' ' || last_name AS "Name", salary, job_id, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;


