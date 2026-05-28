SELECT department_id, department_name
FROM departments;

SELECT (first_name ||' '|| last_name) AS NAME, salary, hire_date
FROM employees;

SELECT DEPARTMENT_ID AS DepartmentNo, DEPARTMENT_NAME AS DepartmentName
FROM DEPARTMENTS;

SELECT DEPARTMENT_ID "Department No", DEPARTMENT_NAME "Department Name"
FROM DEPARTMENTS;

SELECT DEPARTMENT_ID 부서번호, DEPARTMENT_NAME 부서명
FROM DEPARTMENTS;

SELECT first_name || '의 직급은' || job_id || '입니다' AS 직급
FROM employees;

SELECT (first_name ||' '|| last_name) AS 이름, salary 급여, hire_date 입사일
FROM employees;

SELECT (first_name ||' '|| last_name || '운 ' || hire_date || '에 ' || '입사했습니다.') 입사일
FROM employees;

SELECT DISTINCT job_id
FROM employees;

SELECT DISTINCT department_id
FROM employees;

DESC employees

SELECT *
FROM employees
WHERE department_id = 110;

SELECT employee_id, first_name ||' '|| last_name employee_name, salary
FROM employees
WHERE salary < 5000;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME='Lex';

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, job_id
FROM EMPLOYEES
WHERE FIRST_NAME='John';

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2008/01/01';

SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100 AND JOB_ID = 'FI_MGR';

SELECT *
FROM employees
WHERE salary >= 5000 AND salary <= 10000;

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= TO_DATE('2008/01/01', 'YYYY/MM/DD');

SELECT *
FROM employees
WHERE employee_id = 134 OR employee_id = 201 OR employee_id = 107;

SELECT *
FROM employees
WHERE employee_id IN (134, 201, 107);

SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE NOT DEPARTMENT_ID = 100;

SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID != 100;

SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID <> 100;

SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE NOT JOB_ID = 'FI_MGR';

SELECT employee_id, first_name, salary
FROM employees
WHERE salary BETWEEN 2000 AND 3000;

SELECT employee_id, first_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 4500;

SELECT employee_id, first_name, salary
FROM employees
WHERE salary >= 2500 AND salary <= 4500;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID=177 OR EMPLOYEE_ID=101 OR EMPLOYEE_ID=184;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(177, 101, 184);

SELECT employee_id, first_name, salary
FROM employees
WHERE department_id IN (10,20,30);

SELECT employee_id, first_name, salary
FROM employees
WHERE department_id = 10 OR department_id = 20 OR department_id = 30;

SELECT employee_id, first_name, job_id
FROM employees
WHERE job_id = 'SA_MAN' OR job_id = 'ST_MAN' OR job_id = 'PU_MAN' OR job_id = 'AC_MGR';


SELECT employee_id, first_name, job_id
FROM employees
WHERE job_id IN ('SA_MAN', 'ST_MAN', 'PU_MAN', 'AC_MGR');

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'K%';

SELECT EMPLOYEE_ID, LOWER(FIRST_NAME) AS Lower_name
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) LIKE '%k%';

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%k';

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '_d%';

SELECT * 
FROM EMPLOYEES
WHERE JOB_ID LIKE '__\_P%' ESCAPE '\';

SELECT *
FROM EMPLOYEES
WHERE JOB_ID LIKE '__@_P%'ESCAPE '@';

SELECT employee_id, first_name
FROM employees
WHERE NOT first_name LIKE '%a%';

SELECT employee_id, first_name
FROM employees
WHERE NOT LOWER(first_name) LIKE '%a%';

SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, JOB_ID
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

SELECT first_name || ' ' || last_name "전체이름", employee_id, job_id
FROM employees
WHERE manager_id IS NULL;

SELECT EMPLOYEE_ID 사원번호, FIRST_NAME 이름, salary 급여, COMMISSION_PCT 수당율, salary*commission_pct 수당금액
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID ASC;

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID DESC;

SELECT employee_id, first_name, salary, department_id
FROM employees
ORDER BY salary DESC, employee_id DESC;

SELECT employee_id, first_name, hire_date
FROM employees
ORDER BY hire_date DESC;

SELECT first_name, department_id, salary
FROM employees
WHERE department_id IN (20, 50)
ORDER BY first_name ASC;






