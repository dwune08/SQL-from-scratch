

-- 현재 날짜를 기본 형식과 문자 형식으로 출력하기
SELECT SYSDATE AS 현재날짜,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS 날짜형식,
        TO_CHAR(SYSDATE, 'DL') AS 긴날짜형식
FROM DUAL;


-- 현재 날짜에서 연도, 월, 일만 각각 출력하기
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY'),
        TO_CHAR(SYSDATE, 'MM'),
        TO_CHAR(SYSDATE, 'DD')
FROM DUAL;


-- 직원들의 입사일에서 연도만 출력하기
SELECT employee_id AS 사원번호,
        first_name AS 사원명,
        salary AS 급여,
        TO_CHAR(hire_date, 'YYYY') AS 입사연도
FROM employees
WHERE department_id = 30;


-- 입사일을 한글 날짜 형식으로 출력하기
SELECT first_name 사원명,
    TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일" DAY') AS 입사일
FROM employees
WHERE department_id = 30;


-- 입사일을 월 이름과 요일 약어 형식으로 출력하기
SELECT TO_CHAR(hire_date, 'YYYY/MON/DD DY')
FROM employees
WHERE department_id = 30;


-- 오늘 날짜의 일수, 주차, 분기 출력하기
SELECT TO_CHAR(SYSDATE, 'DDD') AS 올해일수,
    TO_CHAR(SYSDATE, 'WW') AS 올해주차,
    TO_CHAR(SYSDATE, 'Q') AS 분기
FROM DUAL;


-- 현재 시간 출력하기
SELECT TO_CHAR(SYSDATE, 'PM') AS 오전오후,
    TO_CHAR(SYSDATE, 'PM HH:MI:SS') AS 시간12시간형식,
    TO_CHAR(SYSDATE, 'HH24"시"MI"분"SS"초"') AS 시간24시간형식
FROM DUAL;


-- 오늘 날짜와 시간을 함께 출력하기
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS 현재일시
FROM DUAL;


--숫자에 천 단위 구분 기호 적용하기
SELECT TO_CHAR(1234, '9,999') AS 숫자형식1,
    TO_CHAR(123467, 'FM999,999') AS 숫자형식2,
    TO_CHAR(123467890, 'FM999,999,999') AS 숫자형식3,
    TO_CHAR(4, 'FM9.0') AS 소수형식
FROM DUAL;


-- 0 형식과 FM 형식 비교하기
SELECT TO_CHAR(1, '00') AS 기본형식,
    TO_CHAR(1, 'FM00') AS 공백제거형식
FROM DUAL;


-- 9형식과 FM 형식 비교하기
SELECT TO_CHAR(1, '99') AS 기본형식,
    TO_CHAR(1, 'FM99') AS 공백제거형식
FROM DUAL;


-- 직원 급여를 통화 형식으로 출력하기
SELECT first_name AS 사원명,
    salary AS 급여,
    TO_CHAR(salary, 'FM$999,999') AS 급여형식
FROM employees
WHERE department_id =30;


-- 특정 입사일의 직원 조회하기
-- 2005년 12월 24일 입사한 지원의 이름과 입사일 조회
--권장하지 않는 쿼리
SELECT first_name, hire_date FROM employees
WHERE hire_date = '05/12/24';


-- TO_DATE 이용
SELECT first_name AS 사원명,
    hire_date AS 입사일
FROM employees
WHERE hire_date = TO_DATE('20051224', 'YYYYMMDD');

-- 날짜 리터럴 사용
SELECT first_name AS 사원명,
    hire_date AS 입사일
FROM employees
WHERE hire_date = DATE '2005-12-24';


-- TRUNC로 시간 정보 제거하고 날짜 부부남ㄴ 비교
SELECT first_name AS 사원명,
    hire_date AS 입사일
FROM employees
WHERE TRUNC(hire_date) = DATE '2005-12-24';


-- 문자열 날짜를 원하는 날짜 형식으로 출력하기
-- 문자열 데이터 '210505'를 날짜로 변환한 후, 2021년 05월 05일 형식으로 출력

-- 잘못된 쿼리
SELECT TO_CHAR('210505', 'YYYY"년" MM"월" DD"일"')
FROM DUAL;


-- 올바른 버전
SELECT TO_CHAR(TO_DATE('210505', 'YYMMDD'), 'YYYY"년" MM"월" DD"일"') AS 날짜
FROM DUAL;


-- 날짜에서 앞자리 0 제거하기
SELECT TO_CHAR(
    TO_DATE('210505', 'YYMMDD'), 
    'YYYY"년" FMMM"월" DD"일"') AS 날짜
FROM DUAL;


-- 일반 문자 숫자를 숫자형으로 변환
SELECT TO_NUMBER('12345') AS 결과
FROM DUAL;


-- 콤마가 포함된 문자숫자를 숫자형으로 변환
SELECT TO_NUMBER('12,345', '99,999') AS 결과
FROM DUAL;


-- 소수점이 포함된 문자 숫자를 숫자형으로 변환
SELECT TO_NUMBER('12345.67', '99999.99') AS 결과
FROM DUAL;


-- 수치 형태의 문자 값을 숫자로 변환하여 계산하기
SELECT '10,000' + '20,000' FROM DUAL;
-- error. 수치가 부적합합니다.


-- TO_NUMBER로 숫자형 변환 후 계산하기
SELECT TO_NUMBER('10,000', '999,999') + 
    TO_NUMBER('20,000', '999,999') AS 합계
FROM DUAL;


-- 계산 결과를 다시 문자 형식으로 출력하기
SELECT TO_CHAR(
    TO_NUMBER('10,000', '999,999') + TO_NUMBER('20,000', '999,999'),
    'FM999,999') AS 합계
FROM DUAL;


-- 커미션 금액 포함 사원 정보 조회
SELECT first_name, salary, commission_pct, job_id
FROM employees
ORDER BY job_id;


-- NVL 함수를 이용 커미션 안 받는 경우 0으로
SELECT first_name, salary, NVL(commission_pct, 0), job_id
FROM employees
ORDER BY job_id;


-- 커미션 금액과 총 급여를 포함한 사원 정보 조회
SELECT first_name AS 사원명,
    salary AS 급여,
    commission_pct AS 커미션비율,
    salary*commission_pct AS 커미션금액,
    salary+(salary*commission_pct) AS 총급여,
    job_id AS 직무코드
FROM employees
ORDER BY job_id;


-- NVL 함수를 이용해 NULL을 제거
SELECT first_name AS 사원명,
    salary AS 급여,
    NVL(commission_pct, 0) AS 커미션비율,
    salary*NVL(commission_pct, 0) AS 커미션금액,
    salary+(salary*NVL(commission_pct, 0)) AS 총급여,
    job_id AS 직무코드
FROM employees
ORDER BY job_id;


-- 식 변형
SELECT first_name AS 사원명,
    salary AS 급여,
    NVL(commission_pct, 0) AS 커미션비율,
    salary*NVL(commission_pct, 0) AS 커미션금액,
    salary*(1+NVL(commission_pct, 0)) AS 총급여,
    job_id AS 직무코드
FROM employees
ORDER BY job_id;


-- 커미션 비율이 NULL이 아니면 급여 + 커미션 금액을
-- 커미션 비율이 NULL이면 급여만 출력
SELECT first_name AS 사원명,
    salary AS 급여,
    commission_pct AS 커미션비율,
    NVL2(commission_pct, salary*(1+commission_pct), salary) AS 총급여,
    job_id AS 직무코드
FROM employees
ORDER BY job_id;


-- 상사가 있는 사원은 직원으로, 상사가 없는 사원은 최상위 관리자로 구부하여 출력
SELECT last_name AS 성,
    first_name AS 이름,
    NVL2(manager_id, '직원', '최상위 관리자') AS 구분
FROM employees;


-- 예제 1. 상관이 없는 대표이사만 출력하되, MANAGER_ID 값이 NULL이면 'CEO'로 출력
SELECT last_name AS 성,
    first_name AS 이름,
    NVL(TO_CHAR(manager_id), 'CEO') AS 구분
FROM employees
WHERE manager_id IS NULL;



-- 예제 2. 직원의 이름, 급여, 커미션 비율을 조회하되,
--         커미션 비율이 없는 직원은 커미션 비율 대신 '<커미션 없음>'을 출력
SELECT first_name AS 이름, salary AS 급여,
    NVL(TO_CHAR(commission_pct, 'FM0.99'),'<커미션 없음>') AS 커미션비율
FROM employees;


-- 입사연도에 따라 근속 구분하기
SELECT first_name AS 사원명,
    hire_date AS 입사일,
    TO_CHAR(hire_date, 'YYYY') AS 입사연도,
    DECODE(TO_CHAR(hire_date, 'YYYY'),
        '2001', '장기근속',
        '2002', '장기근속',
        '2003', '중간근속',
        '2004', '중간근속',
        '일반근속') AS 근속구분
FROM employees;


-- 커미션 여부 출력하기
SELECT first_name AS 사원명,
    salary AS 급여,
    commission_pct AS 커미션비율,
    DECODE(commission_pct,
        NULL, '커미션 없음',
        '커미션 있음') AS 커미션여부
FROM employees;



-- 직무코드에 따라 직무 구분 출력하기
SELECT first_name, job_id,
    DECODE(job_id,
            'AD_PRES', '대표',
            'AD_VP', '임원',
            'IT_PROG', '개발자',
            'SA_REP', '영업사원',
            'ST_CLERT', '재고담당',
            '기타') AS 직무구분
FROM employees
ORDER BY job_id;


-- 급여에 따라 급여 등급 출력하기
SELECT first_name, salary, 
    CASE
        WHEN salary >= 15000 THEN '고액급여'
        WHEN salary >= 10000 THEN '중간급여'
        WHEN salary >= 5000 THEN '일반급여'
        ELSE '낮은급여'
    END AS 급여등급
FROM employees;


-- 직무코드에 따라 인상률 적용하기
SELECT first_name AS 사원명,
    job_id AS 직무코드,
    salary AS 급여,
    CASE 
        WHEN job_id = 'IT_PROG' THEN '10%'
        WHEN job_id = 'SA_REP' THEN '15%'
        WHEN job_id = 'ST_CLERK' THEN '5%'
        ELSE '3%'
    END AS 인상률,
    TRUNC(
        CASE 
            WHEN job_id = 'IT_PROG' THEN salary*1.1
            WHEN job_id = 'SA_REP' THEN salary*1.5
            WHEN job_id = 'ST_CLERK' THEN salary*1.05
            ELSE salary*1.03
        END
    ) AS 인상후급여
FROM employees;



-- 예제 1. 부서명에 따라 급여를 인상하여 조회
SELECT employee_id AS 직원번호,
    first_name AS 직원명,
    job_title AS 직급,
    department_id AS 부서번호,
    department_name AS 부서명,
    salary AS 현재급여,
    CASE 
        WHEN  department_name = 'Marketing' THEN '5%'
        WHEN  department_name = 'Purchasing' THEN '10%'
        WHEN  department_name = 'Human Resources' THEN '15%'
        WHEN  department_name = 'IT' THEN '20%'
        ELSE '인상 없음'
    END AS 인상률,
    TRUNC(
        CASE 
            WHEN  department_name = 'Marketing' THEN salary*1.05
            WHEN  department_name = 'Purchasing' THEN salary*1.1
            WHEN  department_name = 'Human Resources' THEN salary*1.15
            WHEN  department_name = 'IT' THEN salary*1.2
            ELSE salary
        END
    ) AS "인상 후 급여"
FROM employees INNER JOIN departments USING(department_id)
               INNER JOIN jobs USING(job_id);

        
-- 예제 1. 좀 더 깔끔하게 정리
SELECT employee_id AS 직원번호,
    first_name AS 직원명,
    job_title AS 직급,
    department_id AS 부서번호,
    department_name AS 부서명,
    salary AS 현재급여,
    CASE department_name
        WHEN  'Marketing'       THEN '5%'
        WHEN  'Purchasing'      THEN '10%'
        WHEN  'Human Resources' THEN '15%'
        WHEN  'IT'              THEN '20%'
        ELSE '인상 없음'
    END AS 인상률,
    TRUNC(
        CASE department_name
            WHEN  'Marketing'       THEN salary*1.05
            WHEN  'Purchasing'      THEN salary*1.1
            WHEN  'Human Resources' THEN salary*1.15
            WHEN  'IT'              THEN salary*1.2
            ELSE salary
        END
    ) AS "인상 후 급여"
FROM employees JOIN departments USING(department_id)
               JOIN jobs USING(job_id);



-- 직원의 총 급여 구하기 - SUM 함수
SELECT SUM(salary) FROM employees;


-- 급여의 합계를 통화 형식으로 출력
SELECT TO_CHAR(SUM(salary), 'FM$999,999,999') FROM employees;


-- 직원의 평균 급여 구하기 - AVG 함수
SELECT AVG(salary) AS "평균 급여" FROM employees;

SELECT ROUND(AVG(salary), 1) AS "평균 급여 반올림" FROM employees;

SELECT FLOOR(AVG(salary)) AS "평균 급여 버림" FROM employees;


-- 가장 최근 입사일과 가장 오래된 입사일 출력하기 - MAX / MIN 함수
SELECT TO_CHAR(MAX(hire_date), 'YYYY.MM.DD') AS 최근입사일,
    TO_CHAR(MIN(hire_date), 'YYYY.MM.DD') AS 최초입사일
FROM employees;      


-- 전체 사원 수와 커미션을 받는 사원 수 구하기 - COUNT 함수
SELECT COUNT(*) AS "전체 사원 수",
    COUNT(employee_id) AS "사원번호 개수",
    COUNT(commission_pct) AS "커미션 수령 사원 수"
FROM employees;

select distinct job_id
from employees;


-- 예제 1. job의 종류가 몇 개인지 즉, 중복되지 않은 직업의 개수를 구해보자.
SELECT COUNT(DISTINCT job_id)
FROM employees;


-- 컬럼과 그룹 함수를 같이 사용할 때 유의
SELECT employee_id, first_name, min(salary)
FROM employees;
-- ORA-00937 오류


-- 사원들을 부서번호를 기준으로 그룹화하여, 같은 부서번호를 가진 사원들이
-- 하나의 그룹으로 묶이는 것을 확인
SELECT department_id
FROM employees 
GROUP BY department_id
ORDER BY department_id;


-- 부서번호를 기준으로 그룹화한 후, 각 부서별 최대 급여와 최소 급여를 구하기
SELECT department_id,
    MAX(salary) AS "최대 급여",
    MIN(salary) AS "최소 급여"
FROM employees
GROUP BY department_id
ORDER BY department_id;


-- 사원들을 DEPARTMENT_ID 값을 기준으로 부서별로 그룹화한 후,
-- 각 부서에 소속된 사원들의 급여 합계와 급여 평균을 구한다.
SELECT department_id,
    SUM(salary) AS "급여의 합",
    ROUND(AVG(salary), 1) AS "급여의 평균"
FROM employees
GROUP BY department_id
ORDER BY department_id;


-- 예제 1. 부서별로 직원의 수와 커미션을 받는 직원의 수를 카운트해 보자.
SELECT department_id AS 부서번호,
    COUNT(employee_id) AS "직원 수",
    COUNT(commission_pct) AS "커미션 받는 직원 수"
FROM employees
GROUP BY department_id
ORDER BY department_id;


-- 예제 2. 부서별 같은 업무를 담당하는 사원의 수를 카운트해 보자.
SELECT department_id AS 부서번호, job_id AS 업무ID, count(employee_id) AS "사원 수"
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;


-- 예제 3. 30번 부서에 소속된 사원 중
--        가장 오래 근무한 사원의 입사일을 YYYY-MM-DD 형식으로 출력하시오.
SELECT department_id AS 부서번호,
    TO_CHAR(MIN(hire_date), 'YYYY-MM-DD') AS 입사일
FROM employees
WHERE department_id = 30
GROUP BY department_id;


-- 그룹별 평균 급여
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;


-- 평균 급여가 5000 이상인 부서만 조회하기
SELECT department_id, TRUNC(AVG(salary)) AS "평균 급여"
FROM employees
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id;


-- 부서별 최대 급여와 최소 급여를 구하고, 최대 급여가 5000을 초과하는 부서만 조회
SELECT department_id AS 부서번호, 
    MAX(salary) AS "최대 급여", MIN(salary) AS "최소 급여"
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 5000
ORDER BY department_id;


-- 추가 예제, 부서명별로 사원 수 조회
SELECT department_name, COUNT(employee_id)
FROM departments JOIN employees USING(department_id)
GROUP BY department_name;


-- 모든 부서에 대해 조회
SELECT department_id, department_name, COUNT(employee_id)
FROM departments LEFT OUTER JOIN employees USING(department_id)
GROUP BY department_id, department_name;

-- 부서가 없는 사원도 조회
SELECT department_id, department_name, COUNT(employee_id)
FROM departments RIGHT OUTER JOIN employees USING(department_id)
GROUP BY department_id, department_name;


-- 부서별 인원 수가 4명 초과하는 부서만 출력
SELECT department_name, COUNT(employee_id)
FROM departments JOIN employees USING(department_id)
GROUP BY department_name
HAVING COUNT(employee_id) > 4;



-- 예제 1. 부서별 사원 수를 구하여 사원 수가 4명을 초과하는 부서를 조회하시오.
-- 단, 부서번호와 사원 수를 출력하고, 부서번호를 기준으로 오름차순 정렬하시오.
SELECT department_id 부서번호, COUNT(employee_id) AS "사원 수"
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) > 4
ORDER BY department_id;


-- 예제 2. 부서별 급여 합계를 구하여 급여 합계가 30000 이상인 부서를 조회.
-- 단, 부서번호와 급여 합계를 출력하고, 급여 합계가 높은 순서로 정렬하시오.
SELECT department_id 부서번호, SUM(salary) AS "급여 합계"
FROM employees
GROUP BY department_id
HAVING SUM(salary) >= 30000
ORDER BY SUM(salary) DESC;


-- 예제 3. 직무별 사원 수를 구하여 그 인원수가 5명 이상인 직무를 조회.
-- 단, 직무ID와 사원 수를 출력하고, 직무 ID를 기준으로 오름차순 정렬하시오.
SELECT job_id 직무ID, COUNT(employee_id) AS "사원 수"
FROM employees
GROUP BY job_id
HAVING COUNT(employee_id) >= 5
ORDER BY job_id;




-- 부서 내에서 같은 직무를 담당하는 사원들의 급여 합계와 사원 수
SELECT department_id, job_id, COUNT(employee_id) AS 사원수, SUM(salary) AS "급여 합계" 
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;


-- 부서별 급여 합계와 사원 수
SELECT department_id, NULL AS job_id, COUNT(employee_id) AS 사원수, SUM(salary) AS "급여 합계" 
FROM employees
GROUP BY department_id
ORDER BY department_id;


-- 전체 사원의 급여 합계와 사원 수
SELECT NULL AS department_id, NULL AS job_id, COUNT(employee_id) AS 사원수, SUM(salary) AS "급여 합계" 
FROM employees;



-- ROLLUP 으로 작성한 경우
SELECT department_id, job_id, COUNT(*) AS 사원수, SUM(salary) AS "급여 합계"
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id, job_id;


-- 직무별로 각 부서에 소속된 사원의 수와 급여 합계를 구하고, 직무별 소계와 전체 합계를 조회
SELECT job_id, department_id, COUNT(*) AS 사원수, SUM(salary) AS "급여 합계"
FROM employees
GROUP BY ROLLUP(job_id, department_id)
ORDER BY job_id, department_id;


-- CUBE 
SELECT department_id, job_id, COUNT(*) AS 사원수, SUM(salary) AS 급여합계
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id, job_id;



-- 부서별-직무별로 사원 수와 급여 합계 구하기
SELECT department_id, job_id, COUNT(*) AS 사원수, SUM(salary) AS 급여합계
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;


-- GROUPING SETS절 사용
SELECT department_id, job_id, COUNT(*) AS 사원수, SUM(salary) AS 급여합계
FROM employees
GROUP BY GROUPING SETS(department_id, job_id)
ORDER BY department_id;


DROP TABLE exp_goods_asia PURGE;

-- 한국과 일본의 10대 수출품 테이블 
CREATE TABLE exp_goods_asia (  
       country VARCHAR2(10),  -- 나라명
       seq     NUMBER,        -- 번호
       goods   VARCHAR2(80)   -- 상품명 
);
       
INSERT INTO exp_goods_asia VALUES ('한국', 1, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('한국', 2, '자동차');
INSERT INTO exp_goods_asia VALUES ('한국', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('한국', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('한국', 5,  'LCD');
INSERT INTO exp_goods_asia VALUES ('한국', 6,  '자동차부품');
INSERT INTO exp_goods_asia VALUES ('한국', 7,  '휴대전화');
INSERT INTO exp_goods_asia VALUES ('한국', 8,  '환식탄화수소');
INSERT INTO exp_goods_asia VALUES ('한국', 9,  '무선송신기 디스플레이 부속품');
INSERT INTO exp_goods_asia VALUES ('한국', 10,  '철 또는 비합금강');


INSERT INTO exp_goods_asia VALUES ('일본', 1, '자동차');
INSERT INTO exp_goods_asia VALUES ('일본', 2, '자동차부품');
INSERT INTO exp_goods_asia VALUES ('일본', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('일본', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('일본', 5, '반도체웨이퍼');
INSERT INTO exp_goods_asia VALUES ('일본', 6, '화물차');
INSERT INTO exp_goods_asia VALUES ('일본', 7, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('일본', 8, '건설기계');
INSERT INTO exp_goods_asia VALUES ('일본', 9, '다이오드, 트랜지스터');
INSERT INTO exp_goods_asia VALUES ('일본', 10, '기계류');

SELECT * FROM exp_goods_asia;
COMMIT;


SELECT * 
FROM exp_goods_asia
WHERE country = '한국';

SELECT * 
FROM exp_goods_asia
WHERE country = '일본';


-- UNION
SELECT goods
FROM exp_goods_asia
WHERE country = '한국'
UNION
SELECT goods
FROM exp_goods_asia
WHERE country = '일본';


-- UNION ALL
SELECT goods
FROM exp_goods_asia
WHERE country = '한국'
UNION ALL
SELECT goods
FROM exp_goods_asia
WHERE country = '일본';


-- INTERSECT
SELECT goods
FROM exp_goods_asia
WHERE country = '한국'
INTERSECT
SELECT goods
FROM exp_goods_asia
WHERE country = '일본';


-- MINUS
SELECT goods
FROM exp_goods_asia
WHERE country = '한국'
MINUS
SELECT goods
FROM exp_goods_asia
WHERE country = '일본';


-- 공지 테이블 생성 및 데이터 입력
CREATE TABLE notice (
    no NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name NVARCHAR2(10) NOT NULL,
    title NVARCHAR2(100) NOT NULL,
    contents NVARCHAR2(2000) NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT notice_no_pk PRIMARY KEY(no)
);

INSERT INTO notice (name, title, contents)
VALUES ('관리자', '[필독]사이트 이용 방법', '저희 사이트를 방문해 주셔서 감사합니다.');

INSERT INTO notice (name, title, contents)
VALUES ('관리자', '[배송안내]자바 프로그래밍 서적 일괄 배송', '자바 프로그래밍 서적을 구입해주신 분들께 진심으로 감사드
립니다.');

SELECT * FROM notice;


-- 자유게시판 테이블 생성 및 데이터 입력
CREATE TABLE free (
    no NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name NVARCHAR2(10) NOT NULL,
    title NVARCHAR2(100) NOT NULL,
    contents NVARCHAR2(2000) NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT free_no_pk PRIMARY KEY(no)
);

INSERT INTO free (name, title, contents)
VALUES (
    '홍길동',
    '노력과 열정에 대한 명언',
    '나의 유일한 경쟁자는 어제의 나다. 두 배로 생각하라. 두 배로 노력하라. 그것이 가진 것 없는 보통 사람이 성공하는 비결이다.'
);

INSERT INTO free (name, title, contents)
VALUES (
    '김철수',
    '노력과 열정에 대한 명언',
    '가장 큰 영광은 한번도 실패하지 않음이 아니라 실패할 때마다 다시 일어서는 데에 있다.'
);
SELECT * FROM free;


--둘을 UNION ALL
SELECT '공지게시판' AS 게시판구분,
    no AS 글번호,
    name AS 작성자,
    title AS 제목,
    TO_CHAR(regdate, 'YYYY-MM-DD') AS 작성일
FROM NOTICE
UNION ALL
SELECT '자유게시판' AS 게시판구분,
    no AS 글번호,
    name AS 작성자,
    title AS 제목,
    TO_CHAR(regdate, 'YYYY-MM-DD') AS 작성일
FROM FREE;