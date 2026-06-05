-- EMPLOYEES 테이블의 사원명과 부서ID 조회
SELECT employee_id, first_name, department_id
FROM employees;

-- DEPARTMENTS 테이블의 부서ID와 부서명 조회
SELECT department_id, department_name
FROM departments;

-- EMPLOYEES 테이블과 DEPARTMENTS 테이블을 DEPARTMENT_ID로 조인(Equi Join)하여 조회
SELECT first_name, department_name, d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;


-- DEPARTMENT_ID 기준으로 조인된 두 테이블에서 이름이 Susan인 직원의 정보 조회
SELECT first_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND first_name = 'Susan';

DROP TABLE salarygrade PURGE;
-- 급여 등급 테이블 SALARYGRADE 생성
CREATE TABLE salarygrade (
    grade       NUMBER PRIMARY KEY,
    minsalary   NUMBER NOT NULL,
    maxsalary   NUMBER NOT NULL
);


-- 값 입력
INSERT INTO salarygrade(grade, minsalary, maxsalary) VALUES(1,2000,3000);
INSERT INTO salarygrade(grade, minsalary, maxsalary) VALUES(2,3001,4500);
INSERT INTO salarygrade(grade, minsalary, maxsalary) VALUES(3,4501,6000);
INSERT INTO salarygrade(grade, minsalary, maxsalary) VALUES(4,6001,8000);
INSERT INTO salarygrade(grade, minsalary, maxsalary) VALUES(5,8001,10000);
INSERT INTO salarygrade(grade, minsalary, maxsalary) VALUES(6,10001,13000);
INSERT INTO salarygrade(grade, minsalary, maxsalary) VALUES(7,13001,20000);
INSERT INTO salarygrade(grade, minsalary, maxsalary) VALUES(8,20001,30000);

COMMIT;

SELECT * FROM salarygrade;


-- SALARY 기준으로 두 테이블을 조인하여 조회
SELECT e.first_name, e.salary, s.grade
FROM employees e, salarygrade s
WHERE e.salary BETWEEN s.minsalary AND s.maxsalary;


-- 같은 조건은 다음과 같이 비교 연산자를 사용해서 작성할 수도 있다.
SELECT e.first_name, e.salary, s.grade
FROM employees e, salarygrade s
WHERE e.salary >= s.minsalary AND e.salary <= s.maxsalary;


-- 사원 테이블과 부서 테이블을 조인하여 사원 이름과 부서번호와 부서명을 출력
SELECT e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
ORDER BY d.department_id DESC;

SELECT * FROM departments;
-- 소속된 사원이 없는 부서들이 노출되지 않는 걸 확인


-- E.DEPARTMENT_ID에 (+)를 붙여 Outer Join 하여 조회
SELECT e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;



-- 2007년도 상반기에 입사한 사원 조회
SELECT employee_id, first_name, hire_date, department_id
FROM employees
WHERE hire_date >= DATE '2007-01-01'
AND   hire_date < DATE '2007-07-01';


-- EMPLOYEES 테이블과 DEPARTMENTS 테이블을 DEPARTMENT_ID 기준으로 조인하여
-- 2007년도 상반기에 입사한 사원의 사원번호, 사원명, 입사일, 부서명을 조회
SELECT employee_id, first_name, hire_date, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.hire_date >= DATE '2007-01-01'
AND e.hire_date < DATE '2007-07-01';
-- DEPARTMENT_ID가 NULL인 사원은 결과에서 제외됨


-- D.DEPARTMENT_ID에 (+)를 붙여 Outer Join
SELECT employee_id, first_name, hire_date, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+)
AND e.hire_date >= DATE '2007-01-01'
AND e.hire_date < DATE '2007-07-01';


SELECT * FROM jobs;
SELECT * FROM employees;
SELECT * FROM departments;


-- 사원명, 직무ID, 직무명, 부서번호, 부서명 출력
SELECT e.first_name 사원명, j.job_id 직무ID, j.job_title 직무명, e.department_id 부서번호, d.department_name 부서명
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id(+)
AND e.department_id = d.department_id(+);


-- EMPLOYEES 테이블 조회
SELECT employee_id, first_name, manager_id
FROM employees;

SELECT employee_id, first_name
FROM employees
ORDER BY employee_id;


-- EMPLOYEES 테이블을 두번 사용하여 사원명과 관리자 명을 함께 조회
SELECT emp.first_name AS 사원명, mgr.first_name AS 매니저명
FROM employees emp, employees mgr
WHERE emp.manager_id = mgr.employee_id;

SELECT RPAD(emp.first_name, 11, ' ') || '의 매니저는 ' || mgr.first_name || '이다.' AS "그 사원의 매니저"
FROM employees emp, employees mgr
WHERE emp.manager_id = mgr.employee_id;


-- INNER JOIN 예시
SELECT first_name, department_name
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id;


-- INNER JOIN을 사용하여 Susan의 부서명을 조회
SELECT first_name, department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
WHERE first_name = 'Susan';


SELECT e.first_name 사원명, j.job_id 직무ID, j.job_title 직무명, e.department_id 부서번호, d.department_name 부서명
FROM employees e INNER JOIN jobs j ON e.job_id = j.job_id
                 INNER JOIN departments d ON 
AND e.department_id = d.department_id(+);



-- USING문을 사용하여 JOIN
SELECT first_name, department_name
FROM employees INNER JOIN departments
USING(department_id)
WHERE first_name = 'Susan';

SELECT first_name, department_name, department_id
FROM employees INNER JOIN departments
USING(department_id);


-- 사원 테이블과 부서 테이블을 LEFT OUTER JOIN
SELECT first_name, e.department_id, department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;
-- 107행

-- 사원 테이블과 부서 테이블을 RIGHT OUTER JOIN
SELECT first_name, d.department_id, department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;
-- 122행

-- 사원 테이블과 부서 테이블을 FULL OUTER JOIN
SELECT first_name, d.department_id, department_name
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id;
-- 123행


-- 2007년 상반기에 입력된 사원정보 조회
SELECT e.employee_id, e.first_name, e.hire_date, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.hire_date >= DATE '2007-01-01' 
AND e.hire_date < '2007-07-01';

DESC employees;




-- 예제 1, Sales 부서에 소속된 사원의 이름과 입사일
SELECT first_name, hire_date
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
WHERE department_name = 'Sales';
-- 34행


-- 예제 2, 커미션을 받는 사원의 이름, 커미션 비율, 부서명
SELECT first_name, commission_pct, department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE commission_pct IS NOT NULL;
-- 34행


-- 예제 3, IT 부서에서 근무하고 있는 사원의 사원번호, 이름, 직무명, 부서명
SELECT employee_id, 
    first_name,
    job_title, 
    department_name
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
                 INNER JOIN jobs j ON e.job_id = j.job_id
WHERE department_name = 'IT';
-- 5행


-- 예제 4, Guy와 동일한 부서에서 근무하는 동료들의 이름과 부서번호
--         단,Guy는 제외
SELECT e.first_name AS "Guy 동료", department_id
FROM employees g INNER JOIN employees e
USING(department_id)
WHERE g.first_name = 'Guy'
AND e.first_name <> 'Guy';
-- 5행





