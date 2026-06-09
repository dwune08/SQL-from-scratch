-- 이름이 Susan인 직원이 소속된 부서명 조회하기

-- 우선 해당 직원의 부서 번호 조회
SELECT department_id 
FROM employees
WHERE first_name = 'Susan';
-- 실행결과, 부서 코드는 40

-- 부서코드가 40인 부서명을 조회
SELECT department_name
FROM departments
WHERE department_id = 40;

-- 서브 쿼리로 작성
SELECT department_name
FROM departments
WHERE department_id = (SELECT department_id 
                        FROM employees
                        WHERE first_name = 'Susan');
                        
-- employees 테이블에서 Lex와 같은 부서에 근무하는 모든 사원의 이름과 입사일자 조회

-- Lex가 소속된 부서번호 조회
SELECT department_id
FROM employees
WHERE first_name = 'Lex';
-- 90

-- 부서 번호가 90인 사원들의 이름과 입사일자 조회
SELECT first_name, hire_date
FROM employees
WHERE department_id = 90;

-- 서브 쿼리로 작성
SELECT first_name, hire_date
FROM employees
WHERE department_id = (SELECT department_id
                        FROM employees
                        WHERE first_name = 'Lex');

                        
-- 예제 1. EMPLOYEES 테이블에서 CEO에게 보고하는 직원의 모든 정보를 조회
SELECT *
FROM employees
WHERE manager_id = (SELECT employee_id
                    FROM employees
                    WHERE manager_id IS NULL);
                    
                    
-- EMPLOYEES 테이블에서 Guy와 같은 부서에서 근무하는 사원 중
-- Guy를 제외한 사원들의 사원번호, 이름, 직무ID, 급여, 커미션 비율, 입사일자를 조회
-- 단, Guy의 부서번호는 서브 쿼리로 조회하고, 커미션 비율이 NULL이면 0으로 출력,
-- 입사일자는 YYYY.MM.DD 형식으로 출력
SELECT employee_id 사원번호, 
        first_name 이름, 
        job_id 직무ID,
        salary 급여, 
        NVL(commission_pct, 0) AS "커미션 비율",
        TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
FROM employees
WHERE department_id = (SELECT department_id
                        FROM employees
                        WHERE first_name = 'Guy')
AND first_name <> 'Guy';          



-- 전체 사원의 평균 급여 조회
SELECT AVG(salary)
FROM employees;

-- 평균 급여보다 더 많은 급여를 받는 사원 조회
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees);



-- 예제 1. EMPLOYEES 테이블에서 LAST_NAME이 Kochhar인 사원보다 급여를 많이 받는 사원의
-- 사원번호, 이름, 담당업무, 급여를 조회
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Kochhar');
                
-- 예제 2. 가장 적은 급여를 받는 사원의 사원번호, 이름, 급여 출력
SELECT employee_id, first_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);
                
-- 예제 3. 가장 많은 급여를 받는 사원의 이름, 핸드폰 번호 출력
SELECT employee_id, first_name, phone_number
FROM employees
WHERE salary = (SELECT MAX(salary)
                FROM employees);
                
-- 예제 4. 가장 오랜 기간 근무한 사원의 이름, 이메일, 담당업무, 입사일을 출력
SELECT first_name, email, job_id, hire_date
FROM employees
WHERE hire_date = (SELECT MIN(hire_date)
                FROM employees);
                
                
                
-- IN 연산자
-- 급여가 14000 이상인 사원이 소속된 부서의 사원들을 조회
SELECT first_name, salary, department_id
FROM employees
WHERE department_id IN (SELECT DISTINCT department_id
                        FROM employees
                        WHERE salary >= 14000)
ORDER BY department_id;


-- EMPLOYEES 테이블에서 Susan 또는 Lex와 월급이 같은 직원의이름, 업무, 급여를 조회
-- 단 Susan, Lex는 제외
SELECT first_name, job_id, salary
FROM employees
WHERE salary IN (SELECT salary
                 FROM employees
                 WHERE first_name IN ('Susan', 'Lex'))
AND first_name NOT IN ('Susan', 'Lex');


-- EMPLOYEES 테이블에서 다른 직원을 관리하는 사원의 직원번호, 이름, 업무, 부서번호를 조회
SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE employee_id IN (SELECT DISTINCT manager_id
                      FROM employees
                      WHERE manager_id IS NOT NULL);
                
select * from locations;

-- 예제 1. EMPLOYEES 테이블에서 Acoounting 부서에서 근무하는 직원과
-- 같은 업무를 담당하는 직원의 이름과 업무명을 출력
SELECT first_name, job_title
FROM employees JOIN jobs USING(job_id)
WHERE job_id IN (SELECT job_id
                 FROM employees JOIN departments USING(department_id)
                 WHERE department_name = 'Accounting');
                 
-- 예제 2. 지역이 'Toronto'에 있는 부서에 소속된 사원의 모든 정보
SELECT *
FROM employees          
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE location_id IN (SELECT location_id
                                             FROM locations
                                             WHERE city = 'Toronto'));
                                             
                                             
-- 30번 부서에 소속된 직원들 중 가장 많은 급여를 받는 사원보다
-- 더 많은 급여를 받는 사원의 이름과 급여를 출력
SELECT first_name, salary
FROM employees
WHERE salary > ALL (SELECT salary
                    FROM employees
                    WHERE department_id = 30);
                    
                    
-- 110번 부서에 소속된 사원들의 급여 중 가장 작은 급여보다 많은 급여를 받는
-- 사원의 이름과 급여 출력
SELECT FIRST_NAME,
SALARY
FROM EMPLOYEES
WHERE SALARY > ANY ( SELECT SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 110
);


-- 예제 1. 직급이 'ST_MAN'인 직원이 받는 최소 급여보다
-- 많이 받는 직원들의 이름과 급여를 출력하되, 부서번호 20은 제외
SELECT first_name, salary
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'ST_MAN')
AND department_id <> 20;     


-- EXISTS 사용 예시
SELECT employee_id, first_name, e.job_id, job_title
FROM employees e JOIN jobs j
ON e.job_id = j.job_id
WHERE EXISTS (SELECT 1
              FROM job_history
              WHERE employee_id = e.employee_id)
ORDER BY e.employee_id;              


-- 테이블에 소속 사원이 존재하는 부서의 부서번호와 부서명
SELECT department_id, department_name
FROM departments d
WHERE EXISTS (SELECT 1
              FROM employees e
              WHERE e.department_id = d.department_id)
ORDER BY department_id;


-- 사원명과 부서명 조회 - JOIN 사용
SELECT first_name, department_name
FROM employees JOIN departments USING(department_id);

-- 사원명과 부서명 조회 - 스칼라 서브 쿼리 사용
SELECT first_name,
    (SELECT department_name
     FROM departments d
     WHERE d.department_id = e.department_id)
FROM employees e
ORDER BY department_id;


-- 사원번호, 사원명, 관리자번호, 관리자명 조회
SELECT employee_id, first_name, manager_id,
    NVL((SELECT first_name
     FROM employees e2
     WHERE e2.employee_id = e1.manager_id), '없음') AS manager_name
FROM employees e1
ORDER BY e1.employee_id;
           

-- EMPLOYEES 테이블에서 급여가 자신이 속한 부서의 평균보다 많이 받는 사원의
-- 부서번호, 사원명, 급여를 출력
SELECT department_id, first_name, salary
FROM employees e1
WHERE e1.salary > (SELECT AVG(salary)
                FROM employees e2
                WHERE e1.department_id = e2.department_id)
ORDER BY e1.department_id, e1.salary DESC;


-- 예제 1. EMPLOYEES 테이블에서 가장 많은 사원이 속해 있는 부서번호와 사원수를 출력하시오.
SELECT department_id, COUNT(employee_id) AS 사원수
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) >= ALL (SELECT COUNT(*)
                                 FROM employees
                                 GROUP BY department_id);

 
                                                     
-- 예제 2. EMPLOYEES 테이블에서 부서별 최고 급여를 받는
-- 직원의 이름, 직급, 부서, 급여를 출력하시오.
SELECT first_name, job_id, department_id, salary
FROM employees e1
WHERE e1.salary = (SELECT MAX(salary)
                   FROM employees e2
                   WHERE e1.department_id = e2.department_id)
ORDER BY e1.department_id;                   
                    
           


           
           
           
                    
                