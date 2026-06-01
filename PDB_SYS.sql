-- 사용자 계정 생성
-- 사용자를 생성하기 위해서는 DBA만 사용자를 생성할 수 있다. 그래서 최고권한자(SYSDBA)인 SYS로 졉속해야 한다.
-- 구문: create user 사용자명 identified by 비밀번호; (비밀번호는 대소문자 구문합니다)
CREATE USER javauser IDENTIFIED BY java1234;


-- 비밀번호 변경 시
ALTER USER javauser IDENTIFIED BY java1234;


-- 사용자 권한 부여
-- 오라클은 사용자 생성시 어떤한 권한도 가지고 있지 않기에 건한 부여를 해주어야 한다.
-- 구문 : GRANT 권한 TO 사용자명;
GRANT CREATE SESSION TO javauser;

-- 구문 : GRANT 롤 TO 사용자명;
GRANT CONNECT, RESOURCE TO javauser;

-- RESOURCE : 사용자 계정으로 TABLE을 생성 이용할 수 있는 권한
-- CONNECT : 사용자가 DB에 접속할 수 있는 권한


ALTER USER javauser
DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;

-- CONNECT 롤에 포함된 권한 - CREATE SESSION 권한이 없으면 해당 유저로 접속이 되지 않음
SELECT * FROM role_sys_privs
WHERE role = 'CONNECT';

-- RESOURCE 롤에 포함된 권한
SELECT * FROM role_sys_privs
WHERE role = 'RESOURCE';
-- CREATE 트리거, 시퀀스, 타입, 프로시저, 테이블 등 8가지 권한이 부여되어 있음

-- 먼저 javauser에게 부여된 롤 확인
SELECT * FROM dba_role_privs
WHERE GRANTEE = 'JAVAUSER';

















