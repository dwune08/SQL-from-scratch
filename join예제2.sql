SELECT * FROM student;
SELECT * FROM subject;
SELECT * FROM course;
SELECT * FROM enrollment;


-- 예제 1. 학생의 학번, 학생명, 학과번호, 학과명을 조회
SELECT sd_num, sd_name, s_num, s_name
FROM student std JOIN subject sbj
USING(s_num);


-- 예제 2. 전체 학과번호, 학과명과 각 학과에 소속된 학생명, 아이디를 조회
SELECT s_num, s_name, sd_name, sd_id
FROM subject sbj LEFT OUTER JOIN student std
USING(s_num)
ORDER BY s_num;


-- 예제 3-1. 수강 신청한 학생명, 과목명, 등록일(2-18.12.28 형태)을 조회
SELECT sd_name, c_name, TO_CHAR(e_date, 'YYYY.MM.DD') AS e_date
FROM enrollment e INNER JOIN student std USING(sd_num)
                  INNER JOIN course c USING(c_num)
            
