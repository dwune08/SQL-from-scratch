-- EMP01 테이블 생성
CREATE TABLE EMP01 (
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20),
    SAL NUMBER(7,2)
);

-- EMP01 생성 확인
SELECT *
FROM TAB;

-- EMP01 내부 확인
SELECT *
FROM EMP01;

-- 테이블의 구조 확인
DESC EMP01;

-- CREATE TABLE AS SELECT문으로 복사하여 테이블 생성
CREATE TABLE employees02
AS
SELECT *
FROM employees;

SELECT * FROM employees02;

-- EMP01 테이블에 문자 타입의 직급 컬럼 JOB 추가
ALTER TABLE emp01
ADD(job VARCHAR2(9));

-- 변경 확인
DESC emp01;

-- <문제> EMP01 테이블에 입사일 칼럼(CREDATE)을 날짜형으로 추가
ALTER TABLE emp01
ADD(CREDATE DATE);

-- 직급을 최대 30자까지 입력할 수 있도록 크기 수정
-- NOT NULL 추가로 NULL값 허용하지 않기.
ALTER TABLE emp01
MODIFY(job VARCHAR2(30) NOT NULL); 

-- 입사일 컬럼의 이름을 CREDATE에서 REGDATE로 변경
ALTER TABLE emp01
RENAME COLUMN CREDATE TO REGDATE;

-- 직급 칼럼 삭제하기
ALTER TABLE emp01
DROP COLUMN job;

-- EMP01 테이블 삭제
DROP TABLE EMP01;

-- 삭제 확인
SELECT * FROM tab;

-- recyclebin 구조 확인
DESC recyclebin;

-- 휴지통(recyclebin) 보기
SELECT * FROM recyclebin;

-- 휴지통 비우기
-- PURGE recyclebin;

-- 삭제 취소
FLASHBACK TABLE emp01 TO BEFORE DROP;

-- 새로운 이름으로 복원
FLASHBACK TABLE emp01 TO BEFORE DROP
RENAME TO emp02;

-- 휴지통에 넣지 않고 바로 삭제
DROP TABLE emp02 purge;

-- 테이블 명 변경
RENAME employees02 TO employees01;

-- employees01의 모든 행을 제거
TRUNCATE TABLE employees01;

SELECT * FROM employees01;


SELECT * FROM tab;


-- 고객 테이블 구조 만들기
CREATE TABLE tb_customer(
    customer_id CHAR(7) NOT NULL PRIMARY KEY,
    customer_name VARCHAR2(15) NOT NULL,
    gender CHAR(1) NOT NULL,
    birth_date DATE NOT NULL,
    phone_number VARCHAR2(20),
    email VARCHAR2(50),
    total_point NUMBER(10) DEFAULT 0 NOT NULL,
    created_at DATE DEFAULT SYSDATE NOT NULL
);


-- 예제 1, 회원정보 테이블 MEMBER 만들기
CREATE TABLE member (
    member_id NUMBER(20) NOT NULL PRIMARY KEY,
    member_name VARCHAR2(20) NOT NULL,
    birth_date DATE NOT NULL,
    phone_number VARCHAR2(13) NOT NULL,
    address VARCHAR2(100) NOT NULL
);


-- 예제 2, 도서 정보 테이블 BOOK 만들기
CREATE TABLE book (
    book_id NUMBER(4) NOT NULL PRIMARY KEY,
    book_title VARCHAR2(100) NOT NULL,
    stock_quantity NUMBER(6) NOT NULL,
    price NUMBER(10) NOT NULL,
    publisher VARCHAR2(50) NOT NULL
);


-- 예제 3, 회원의 책 주문 정보를 저장하는 테이블 BOOK_ORDER 만들기
CREATE TABLE book_order (
    order_id VARCHAR2(10) NOT NULL PRIMARY KEY,
    member_id NUMBER(20) NOT NULL,
    book_id NUMBER(4) NOT NULL,
    order_quantity NUMBER(6) NOT NULL,
    order_date DATE NOT NULL
);


-- 예제 4, 회원이 작성한 도서 리뷰 테이블 BOOK_REVIEW 만들기
CREATE TABLE book_review (
    review_id NUMBER(10) NOT NULL PRIMARY KEY,
    member_id NUMBER(20) NOT NULL,
    book_id NUMBER(4) NOT NULL,
    rating NUMBER(1) NOT NULL,
    review_content VARCHAR2(1000) NOT NULL,
    review_date DATE NOT NULL
);






