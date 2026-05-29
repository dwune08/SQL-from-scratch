-- DML / INSERT, UPDATE, DELETE
SELECT * FROM tabs;

-- 실습을 위한 DEPT 테이블 생성
CREATE TABLE DEPT(
DEPTNO NUMBER(2),
DNAME VARCHAR2(14),
LOC VARCHAR2(13)
);


DESC DEPT;
SELECT * FROM DEPT;


-- 컬럼 DEPTNO에 10번 부서, DNAME에는 'ACCOUNTING', LOC에는 'NEW YORK' 추가
INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(10, 'ACCOUNTING', 'NEWYORK');


-- 컬럼명에 기술된 목록 수보다 괄호안에 기술한 값의 개수가 적으면 에러
INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES (10, 'ACCOUNTING');


-- 컬럼명에 기술된 목록 수보다 괄호안에 기술한 값의 개수가 많으면 에러
INSERT INTO DEPT(DEPTNO, DNAME)
VALUES(10, 'ACCOUNTING', 'NEW YORK', 20);


-- 컬럼명이 잘못 입력되어도 에러
INSERT INTO DEPT(NUM, DNAME, LOC)
VALUES(10, 'ACCOUNTING', 'NEW YORK');


-- 컬럼과 입력할 값의 데이터 타입이 맞지 않는 경우에도 에러
INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(10, ACCOUNTING, 'NEW YORK');


-- 컬럼명을 생략한 INSERT 구문
INSERT INTO DEPT
VALUES (20, 'RESEARCH', 'DALLAS');


-- DEPTNO가 NULL을 허용하지 않도록 수정
ALTER TABLE dept
MODIFY(deptno NUMBER(2) NOT NULL);


-- DNAME이 NULL을 허용하지 않도록 수정
ALTER TABLE dept
MODIFY(dname VARCHAR2(14) NOT NULL);


-- 암시적으로 NULL값 삽입하기
INSERT INTO dept(deptno, dname)
VALUES (30, 'SALES');


-- 명시적으로 NULL 값 삽입
INSERT INTO dept
VALUES (40, 'OPERATIONS', NULL);


-- dept 테이블의 기존 데이터를 삭제
DELETE FROM dept;

-- DEPARTMENTS 테이블의 컬럼과 자릿수를 일치하도록 테이블을 수정
ALTER TABLE dept
MODIFY(deptno NUMBER(4), dname VARCHAR2(30));

-- DEPARTMENTS 테이블로부터 데이터를 복사해서 넣기
INSERT INTO dept
SELECT department_id, department_name, location_id
FROM departments;


SELECT * FROM dept;




-- INSERT ALL


-- 직원 기본 정보를 저장할 테이블 생성
CREATE TABLE emp_basic
AS
SELECT employee_id, first_name, department_id
FROM employees
WHERE 1 = 0;

SELECT * FROM emp_basic;

-- 직원 급여 정보를 저장할 테이블 생성
CREATE TABLE emp_salary
AS
SELECT employee_id, salary, commission_pct
FROM employees
WHERE 1 = 0;

SELECT * FROM emp_salary;



-- 부서번호가 50인 직원들의 기본 정보는 EMP_BASIC 테이블에,
-- 급여 정보는 EMP_SALARY 테이블에 삽입
INSERT ALL
    INTO emp_basic(employee_id, first_name, department_id)
    VALUES (employee_id, first_name, department_id)
    
    INTO emp_salary(employee_id, salary, commission_pct)
    VALUES (employee_id, salary, commission_pct)

SELECT employee_id, first_name, department_id, salary, commission_pct
FROM employees
WHERE department_id = 50;
    

-- EMPLOYYES 테이블의 구조를 복사하여, 사번, 이름, 입사일, 급여를 저장할 수 있는
-- 테이블 EMP_OLD 생성
CREATE TABLE emp_old
AS
SELECT employee_id, first_name, hire_date, salary
FROM employees
WHERE 1 > 2;

SELECT * FROM emp_old;


-- EMPLOYEES 테이블의 구조를 복사하여 사번, 이름, 입사일, 급여를 저장할 수 있는
-- 테이블 EMP_NEW 생성
CREATE TABLE emp_new
AS
SELECT employee_id, first_name, hire_date, salary
FROM employees
WHERE 1 > 3;

SELECT * FROM emp_new;


-- EMPLOYEES 테이블의 입사일을 기준으로
-- 2006년 1월 1일 전에 입사한 사원은 EMP_OLD 테이블에,
-- 2006년 1월 1일 이후에 입사한 사원은 EMP_NEW 테이블에 삽입
INSERT ALL
    WHEN hire_date < DATE '2006-01-01' THEN
    INTO emp_old(employee_id, first_name, hire_date, salary)
    VALUES (employee_id, first_name, hire_date, salary)
    
    WHEN hire_date >= DATE '2006-01-01' THEN
    INTO emp_new(employee_id, first_name, hire_date, salary)
    VALUES (employee_id, first_name, hire_date, salary)

SELECT employee_id, first_name, hire_date, salary
FROM employees;


SELECT * FROM emp_old ORDER BY hire_date DESC;
SELECT * FROM emp_new ORDER BY hire_date;


--DROP TABLE EMP;
-- EMPLOYEES 테이블을 복사하여 EMP 테이블 생성
CREATE TABLE EMP
AS
SELECT * FROM EMPLOYEES;

SELECT * FROM EMP;


-- EMP 테이블의 모든 사원 부서번호를 30번으로 변경
UPDATE EMP
SET DEPARTMENT_ID = 30;


-- 모든 사원의 급여를 10% 인상
UPDATE EMP
SET salary = salary*1.1;


-- 모든 사원의 입사일을 오늘로 변경
UPDATE emp
SET hire_date = SYSDATE;


-- EMP 테이블에서 부서번호가 10인 사원들의 부서번호를 30으로 변경
UPDATE emp
SET department_id = 30
WHERE department_id = 10;


-- EMP 테이블에서 급여가 3000 이상인 사원만 급여를 10% 인상
UPDATE emp
SET salary = salary * 1.1
WHERE salary >= 3000;


SELECT * FROM emp WHERE first_name = 'Susan';


-- EMP 테이블에서 Susan 사원의 부서 번호를 20으로, 직급을 FI_MGR로 변경
UPDATE emp
SET department_id = 20, job_id = 'FI_MGR'
WHERE employee_id = 203;


SELECT * FROM emp WHERE last_name = 'Russell';


-- EMP 테이블에서 LAST_NAME이 'Russell'인 사원의 급여를 17000으로, 커미션 비율을 0.45로 인상하시오.
UPDATE emp
SET salary = 17000, commission_pct = 0.45
WHERE last_name = 'Russell';


SELECT * FROM emp WHERE employee_id = 108;


UPDATE emp
SET first_name = '상혁', last_name = '이', salary = 388021, commission_pct = 0.9, job_id = 'T1_MID'
WHERE employee_id = 108;



SELECT * FROM dept;

-- DEPT 테이블의 데이터 전체 삭제
DELETE FROM dept;


-- DEPT 테이블에서 부서번호가 30번인 부서 정보를 삭제
DELETE FROM dept
WHERE deptno = 30;
                           
                                                                                                                                                                                                                                             
--DROP TABLE TB_ADD_CUSTOMER;


-- 외부에게서 전달받은 고객데이터 TB_ADD_CUSTOMER 생성
CREATE TABLE tb_add_customer (
CUSTOMER_CD     CHAR(7 BYTE)        NOT NULL, -- 고객코드
CUSTOMER_NM     VARCHAR2(10 BYTE)   NOT NULL, -- 고객명
GENDER          CHAR(1 BYTE)        NOT NULL, -- 성별구분
BIRTH_DAY       CHAR(8 BYTE)        NOT NULL, -- 생일
PHONE_NUMBER    VARCHAR2(16 BYTE),  -- 전화번호
CONSTRAINT TB_ADD_CUSTOMER_CUSTOMER_CD_PK PRIMARY KEY(CUSTOMER_CD)
);


-- 고객 데이터 입력
INSERT INTO TB_ADD_CUSTOMER
    (CUSTOMER_CD, CUSTOMER_NM, GENDER, BIRTH_DAY, PHONE_NUMBER)
VALUES
    ('2017108','박승대','M','19711230','010-2580-9919');

INSERT INTO TB_ADD_CUSTOMER
    (CUSTOMER_CD, CUSTOMER_NM, GENDER, BIRTH_DAY, PHONE_NUMBER)
VALUES 
    ('2019302','전미래','W','19740812','010-8864-0232');


SELECT * FROM tb_add_customer;
SELECT * FROM tb_customer;



-- TB_ADD_CUSTOMER 테이블의 데이터를 TB_CUSTOMER 테이블에 반영한다.
-- 고객코드가 이미 존재하면 고객명, 성별, 생일, 전화번호를 수정하고, 
-- 존재하지 않으면 새로운 고객으로 추가한다.
MERGE INTO TB_CUSTOMER C
USING TB_ADD_CUSTOMER A
ON (C.CUSTOMER_ID = A.CUSTOMER_CD)
WHEN MATCHED THEN
    UPDATE SET C.CUSTOMER_NAME = A.CUSTOMER_NM,
        C.GENDER        = A.GENDER,
        C.BIRTH_DATE    = TO_DATE(A.BIRTH_DAY, 'YYYYMMDD'),
        C.PHONE_NUMBER  = A.PHONE_NUMBER
WHEN NOT MATCHED THEN
    INSERT (
        CUSTOMER_ID,
        CUSTOMER_NAME,
        GENDER,
        BIRTH_DATE,
        PHONE_NUMBER
    )
    VALUES (
        A.CUSTOMER_CD,
        A.CUSTOMER_NM,
        A.GENDER,
        TO_DATE(A.BIRTH_DAY, 'YYYYMMDD'),
        A.PHONE_NUMBER
    );



-- 예제, EMP01 테이블 생성
CREATE TABLE emp01 (
    empno       NUMBER(4)       NOT NULL PRIMARY KEY,   -- 사원번호
    ename       VARCHAR2(10)    NOT NULL,               -- 사원명
    job         VARCHAR2(9),                            -- 직급
    mgrno       NUMBER(4),                              -- 관리자번호
    hiredate    DATE            NOT NULL,               -- 입사일
    sal         NUMBER(7,2)     NOT NULL,               -- 급여
    comm        NUMBER(7,2),                            -- 커미션
    deptno      NUMBER(2)       NOT NULL                -- 부서번호
);


-- EMP01 테이블에 데이터 추가
INSERT ALL
    INTO emp01
    VALUES(7369, 'SMITH', 'CLEAK', 7839, TO_DATE('2019/12/17', 'YYYY/MM/DD'), 800, NULL, 20)
    INTO emp01
    VALUES(7499, 'ALLEN', 'SALESMAN', 7839, TO_DATE('2000/12/20', 'YYYY/MM/DD'), 1600, 300, 30)
    INTO emp01
    VALUES(7839, 'KING', 'PRESIDENT', NULL, TO_DATE('1980/02/08', 'YYYY/MM/DD'), 5000, NULL, 10)
SELECT *
FROM DUAL;


SELECT * FROM EMP01;




SELECT * FROM MEMBER;
DESC MEMBER;

-- 데이터 입력 예제
-- [문제1] MEMBER 테이블에 데이터 추가하기
INSERT INTO member
VALUES (1, '홍길동', TO_DATE('19701001', 'YYYYMMDD'), '010-5690-2510', '서울특별시 동작구 흑석 3동 140-3');

INSERT INTO member
VALUES (2, '김철수', TO_DATE('19990528', 'YYYYMMDD'), '010-7825-1983', '평택시 비전 1동 118-36');

INSERT INTO member
VALUES (3, '이희진', TO_DATE('19951111', 'YYYYMMDD'), '010-6724-2412', '인천광역시 남동구 간석동 264-11');



-- [문제2] BOOK 테이블에 데이터 추가하기
DESC BOOK;

INSERT INTO book
VALUES (1001, '마흔에 읽는 쇼펜하우어', 7, 17000, '유노북스');

INSERT INTO book
VALUES (1002, '삶이 흔들릴 때 뇌과학을 읽습니다', 5, 18000, '힉스');

INSERT INTO book
VALUES (1003, '무엇이 나를 행복하게 만드는가', 10, 19200, '북플레저');

SELECT * FROM book;



-- [문제3] BOOK_ODDER 테이블에 데이터를 추가,
-- ORDER_ID 컬럼의 자료형을 VARCHAR2(20) 으로 변경 후 입력을 진행한다.

DESC book_order;

ALTER TABLE book_order
MODIFY order_id VARCHAR2(20); 

INSERT INTO book_order
VALUES ('202411260010001', 1, 1002, 1, SYSDATE);

INSERT INTO book_order
VALUES ('202411260010002', 2, 1003, 1, SYSDATE);

INSERT INTO book_order
VALUES ('202411260010003', 2, 1001, 1, SYSDATE);

SELECT * FROM book_order;


-- [문제4] BOOK_REVIEW 테이블에 데이터를 추가

DESC book_review;

INSERT INTO book_review
VALUES (1, 1, 1001, 5, '생각을 정리하는데 도움이 되는 책입니다.', SYSDATE);

INSERT INTO book_review
VALUES (2, 2, 1002, 4, '뇌과학 내용을 쉽게 설명해서 읽기 좋았습니다.', SYSDATE);

INSERT INTO book_review
VALUES (3, 3, 1003, 5, '행복에 대해 다시 생각해 볼 수 있는 책입니다.', SYSDATE);

SELECT * FROM book_review;

SELECT * FROM tabs;


