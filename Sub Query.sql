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
SELECT employee_id, first_name, job_id, salary
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
                
                
                
                
                
                