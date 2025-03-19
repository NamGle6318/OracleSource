-- RDBMS
-- 기본단위 : 테이블

-- EMP(사원 정보 테이블)
----------------------
-- empno(사원 번호)
-- ename(사원 명)
-- job(직책)
-- mgr(직속상관 사원번호)
-- hiredate(입사일)
-- sal(급여)
-- comm(추가수당)
-- deptno(부서번호)
-----------------------


-- DEPT(부서 테이블)
-------------------
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)
-------------------

-- SALGRADE(급여 테이블)
-------------------
-- grade(급여등급)
-- losal(최저급여)
-- hisal(최대급여)
-------------------
-- RDB 타입
-- NUMBER(4, 0) : 전체 자리수 4자리(소수점 자리수 0)
-- VARCHAR2(10) : 문자열 10byte / "VAR" : 가변 - 7byte 문자열 저장했다면 7byte 공간만 사용
--				  10byte-> 영어 10문자, 한글 2byte, utf-8 3byte 할당
-- DATE : 날짜
---------------------------

-- 개발자 : (CRUD CREATE READ UPDATE DELECT)
-- CRUD -> SQL(Structured Query Language : 구조질의언어) RDBMS 데이터를 다루는 언어
-- GUI : DBeaver / CUI : SQL PLUS
-- sql은 한문장씩??????
-- 1. 조회(SELECT) - READ
-- 사원정보 조회
SELECT * FROM EMP e ; -- 전체 조회

-- 별칭사용 deptno(부서번호) 조회
SELECT e.DEPTNO FROM EMP e; -- e : 별칭, 있는게 편함
SELECT deptno FROM emp;

SELECT e.EMPNO, e.DEPTNO FROM emp e; -- 사원번호, 부서번호 조회

-- 중복 데이터 제외하고 조회 (DISTINCT)
SELECT DISTINCT deptno FROM emp;
SELECT DISTINCT job, deptno FROM emp; -- job, deptno 둘 다 중복되는것만 제외

-- 연산 후 조회(+ 별칭 짓시)
SELECT ename, sal, (sal*12 + comm) AS annsal, comm FROM EMP ; -- AS 생략가능
SELECT ename "사 원 명", sal "급 여", (sal*12 + comm) "aNnSaL", comm FROM EMP ; -- "" 강조가능 (쌍따옴표사용시 무조건 대문자 X, 공백 포함 가능)

-- 원하는 순서대로 출력 데이터를 정렬
SELECT e.*  FROM EMP e ORDER BY e.sal ASC; -- emp 테이블의 모든 열을 급여 기준(ORDER BY)으로 오름차순(ASC) 조회
SELECT e.*  FROM EMP e ORDER BY e.sal ASC; -- 오름차순 ASC는 생략 가능
SELECT e.*  FROM EMP e ORDER BY e.sal DESC; -- emp 테이블의 모든 열을 급여 기준(ORDER BY)으로 내림차순(DESC) 조회

-- 사번, 이름, 직무만 급여 기준으로 내림차순 조회
SELECT e.EMPNO, e.ENAME, e.JOB FROM EMP e ORDER BY e.sal DESC;

-- 정렬 기준 복수 지정 (부서번호의 오름차순 정렬 후 급여의 내림차순 정렬)
SELECT e.* FROM EMP e ORDER BY e.deptno ASC, e.sal DESC; -- 정렬 순서에 영향을 끼침

-- 실습 각 열의 별칭을 바꿔서 조회, 부서번호를 내림차순으로 정렬 후 이름을 오름차순으로 
SELECT // ctrl+f 로 정리가능
	e.EMPNO "EMPLOYEE_NO",
	e.ENAME "EMPLOYEE_NAME",
	e.MGR "MANAGER",
	e.SAL "SALARY",
	e.COMM "COMMISSION",
	e.DEPTNO "DEPARTMENT_NO"
FROM
	EMP e
ORDER BY
	e.DEPTNO DESC,
	e.ENAME ASC;

-- 필요한 데이터만 출력 (WHERE : 조회 시 조건 부여)
-- 부서번호가 30번인 사원들을 조회
SELECT
	e.ENAME,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 30;

-- 사번이 7782인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.empno = 7782;

-- 부서번호가 30, 직책이 salesman 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 30 AND e.JOB = 'SALESMAN'; -- 오라클에서 문자는 ''만 가능 / 문자는 대소문자 구분함
	
-- 사원번호 7499 이고 부서번호가 30인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499
	AND e.DEPTNO = 30;

-- 사원번호 7499 이거나 부서번호가 30인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499
	OR e.DEPTNO = 30;

-- WHERE 에서도 쓸 수 있는 산술 연산자
-- 1. 산술연산자 +, -, *, /
-- 2. 비교연산자 >, <, >=, <=
-- 3. 등가비교연산자 =, 같지않다 (!= or <> or ^=)
-- 4. 논리부정연산자 NOT
-- 5. 			 IN
-- 6. 범위 연산자 BETWEEN A AND B
-- 7. 검색 LIKE 연산자와 와일드카드(_, %)
-- 8. IS NULL NULL과 같다
-- 9. 집합연산자 UNION, MINUS, INTERSECT
-- 연봉이 36000인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL * 12 = 36000;

-- 급여가 3000 이상인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.sal > 3000;

-- 급여가 2500 이상, 직원이 ANALYST인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.sal >= 2500 AND e.job = 'ANALYST';

-- 문자 대소비교

-- 급여가 3000이 아닌 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.sal ^= 3000; -- ^= != <>, NOT e.sal = 3000
	
-- 사원이름의 시작이 F보다 뒤에 있는 사원만 조회


SELECT
	*
FROM
	EMP e
WHERE
	e.ENAME >= 'F'
ORDER BY
	e.ENAME ASC;

-- JOB이 MANAGER 이거나, SALESMAN이거나, CLERK 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB = 'MANAGER'
	OR e.JOB = 'SALESMAN'
	OR e.JOB = 'CLERK';

-- -- JOB이 MANAGER 이거나, SALESMAN이거나, CLERK 사원 조회 (IN 사용)
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- JOB이 (MANAGER, SALESMAN, CLERK)가 아닌 사원 조회 (IN 사용)
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- BETWEEN A AND B : A와 B 사이
-- 급여가 2000~3000 사이인 사원을 조회
SELECT * FROM EMP e WHERE e.SAL BETWEEN 2000 AND 3000;

-- 급여가 2000~3000 사이가 아닌 사원 조회
SELECT * FROM EMP e WHERE e.SAL NOT BETWEEN  2000 AND 3000;

-- 검색(LIKE) 연산자와 와일드카드(_, %)
-- _ : 어떤 값이든 상관없이 한 개의 문자열 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자열 데이터를 의미

-- 사원명이 S로 시작하는 사원을 조회
SELECT * FROM EMP e WHERE e.ename LIKE 'S%' ;

-- 사원 이름의 두번째 글자가 L인 사원 조회
SELECT * FROM EMP e WHERE e.ename LIKE '_L%' ;

-- 사원명에 AM이 포함된 사원 조회
SELECT * FROM EMP e WHERE e.ename LIKE '%AM%' ;
-- 사원명에 AM이 포함되지 않은 사원 조회

-- NULL 확인
SELECT * FROM EMP e WHERE e.ename NOT LIKE '%AM%' ;

-- MANAGER_ID가 NULL 인 사원 조회
SELECT * FROM EMP e WHERE e.MGR IS NULL;

-- MANAGER_ID가 NULL이 아닌 사원 조회
SELECT * FROM EMP e WHERE e.MGR IS NOT NULL;

-- 부서번호 10, 20 사원을 조회
SELECT * FROM EMP e WHERE e.deptno IN (10, 20);
SELECT * FROM EMP e WHERE e.deptno = 10 OR e.DEPTNO = 20;

-- 집합연산자 (UNION : 합집합) 
-- UNION(A와 C 그리고 A,C의 집합인 B를 출력 = A, B, C 출력)
-- UNION(A와 C를 출력, A와C의 집합은 B) = A, B, B, C 출력) 
-- 타입 일치 만 확인 => 타입이 맞는다면 연결

SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.deptno = 10
UNION
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.deptno = 20;

SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.deptno = 10
UNION ALL
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.deptno = 10;

SELECT e.ENAME, e.EMPNO, e.SAL FROM EMP e WHERE e.deptno = 10
UNION
SELECT e.ENAME, e.SAL, e.EMPNO FROM EMP e WHERE e.deptno = 20;

SELECT e.EMPNO, e.ENAME, e.SAL FROM EMP e WHERE e.deptno = 10
UNION
SELECT e.EMPNO, e.ENAME, e.SAL FROM EMP e WHERE e.deptno = 10;

SELECT e.EMPNO, e.ENAME, e.SAL FROM EMP e WHERE e.deptno = 10
UNION ALL
SELECT e.EMPNO, e.ENAME, e.SAL FROM EMP e WHERE e.deptno = 10;

-- MINUS(차집합)
SELECT e.EMPNO, e.ENAME, e.SAL, e.deptno FROM EMP e
MINUS
SELECT e.EMPNO, e.ENAME, e.SAL, e.deptno FROM EMP e WHERE e.deptno = 10;
-- INTERSECT(교집합)
SELECT e.EMPNO, e.ENAME, e.SAL, e.deptno FROM EMP e
INTERSECT 
SELECT e.EMPNO, e.ENAME, e.SAL, e.deptno FROM EMP e WHERE e.deptno = 10;

-- 오라클 함수
--  내장함수
--   문자함수
-- 문자의 길이를 구하는 함수 : LENGTH()
-- 대소문자를 바꿔주는 함수 :upper(), lower(), initcap()
-- 사원이름을 대문자, 소문자, 첫문자만 대문자로변경
SELECT
	e.ENAME,
	upper(e.ename),
	lower(e.ename),
	initcap(e.ENAME)
FROM
	EMP e;
-- 제목 oracle 검색
SELECT *
FROM board
WHERE upper(title) = upper('oracle');

SELECT e.ENAME, LENGTH(e.ename) FROM EMP e ;

-- 사원명이 5글자 이상인 사원 조회
SELECT * FROM EMP e WHERE LENGTH(e.ename) >= 5;

-- sql 구문 실행 순서 from - where - select - order by
SELECT * FROM EMP e WHERE LENGTHB(e.ename) >= 5;

-- lengthb() : 문자열 바이트 수 반환
-- XE 버전 : 한글에 3byte 적용
-- dual이란 : sys 소유 테이블(임시 연산이나 함수의 결과값 확인 용도로 사용)
-- 문자열 일부 추출 : substr(문자열데이터, 시작위치, 추출길이)


SELECT length('한글'), LENGTHB('한글')
FROM dual;


SELECT e.JOB, SubStr(e.job, 1, 2), substr(E.JOB, 5) FROM EMP e;
-- 시작위치 지정  시 양수(왼쪽), 음수(오른쪽부터) : 맨 끝부터 -1
SELECT
	e.JOB
    , SubStr(e.job, -length(e.job))
	, SubStr(e.job, -length(e.job), 2)
	, SubStr(e.job, -3)
FROM 
	EMP e;

-- 문자열 데이터 내에서 특정 문자 위치 찾기 : INSTR(대상 문자열, 위치를 찾으려는 문자, 시작위치에서 찾으려는 문자가 몇 번째인지)
SELECT 
INSTR('HELLO ORACLE!', 'L') AS INSTR_1, -- 1번부터 탐색 시작
INSTR('HELLO ORACLE!', 'L', 5) AS INSTR_2, -- 5번부터 탐색 시작
INSTR('HELLO ORACLE!', 'L', 2, 2) AS INSTR_3 -- 2번부터 탐색 시작, 2번째로 찾는 걸 리턴
FROM DUAL;

SELECT e.ENAME, INSTR(lower(e.ENAME), 'a') AS "a_name"
FROM EMP e;

-- 사원 이름에 S가 있는 사원 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE '%S%';

-- INSTR 사용
SELECT *
FROM EMP e 
WHERE INSTR(e.ENAME, 'S') > 0;


-- REPLACE(원본문자열, 찾을문자열, 변경문자열) - 특정문자를 다른 문자로 변경
-- 날짜양식을 00-00-00에서 00/00/00로 기호를 변경하여 조회
SELECT e.HIREDATE , REPLACE(E.HIREDATE , '-', '/') 
FROM EMP e

-- 전화번호에서 '-'를 찾아 공백으로 변경
SELECT
'010-1234-5678' AS REPLACE_BEFORE,
REPLACE('010-1234-5678', '-', ' ') AS REPLACE1, -- 변경
REPLACE('010-1234-5678', '-') AS REPLACE2 -- 제거
FROM DUAL;

-- 두 문자열을 합치기 
-- 1. CONCAT(문자열1, 문자열2) - 2개씩밖에 못 합침
-- 2. 문자열1||문자열2||문자열a|| - 2개 이상의 문자열도 합칠 수 있음
-- 사번 : 사원명 조회
SELECT
CONCAT(e.EMPNO, CONCAT(' : ', e.ENAME))
FROM EMP e ;

SELECT
e.EMPNO || ' : ' || e.ENAME
FROM EMP e ;

-- 특정 문자 제거 
	-- 	1.TRIM(삭제옵션(선택), 삭제할 문자(선택)) FROM 원본문자열(필수) : 
	-- 	2.LTRIM(): 
	-- 	3.RTRIM(): 
-- TRIM의 옵션
	-- LEADING : 왼쪽 = LTRIM
	-- TRAILING : 오른쪽 = RTRIM
	-- BOTH : 둘다

-- TRIM()
SELECT
'[' || TRIM(' __Oracle__ ') || ']'  AS trim,
'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']'  AS trim_Leading,
'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS trim_trailing,
'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS trim_both
FROM 
	DUAL;

SELECT
'[' || TRIM ('    __Oracle__    ') || ']'  AS TRIM,
'[' || LTRIM('     __Oracle__   ') || ']'  AS LTRIM,
'[' || RTRIM('     __Oracle__   ') || ']' AS RTRIM,
'[' || RTRIM('<__Oracle__>', '>_') || ']' AS TRIM_BOTH2
FROM 
	DUAL;

-- 숫자함수
-- 반올림 : ROUND()
-- 버림 : TRUNC()
-- 가장 큰 정수 : CEIL()
-- 가장 작은 정수 : FLOOR()
-- 나머지 : MOD()

-- ROUND 반올림
SELECT -- 소수에서 '.'기준 음수는 왼쪽, 양수는 오른쪽
ROUND(1234.5678) AS ROUND,
ROUND(1234.5678, 0) AS ROUND0,
ROUND(1234.5678, 1) AS ROUND1,
ROUND(1234.5678, 2) AS ROUND2,
ROUND(1234.5678, -1) AS "ROUND-1",
ROUND(1234.5678, -2) AS "ROUND-2"
FROM DUAL;

-- TRUNC 버림
SELECT
TRUNC(1234.5678) AS TRUNC1,
TRUNC(1234.5678, 0) AS TRUNC2,
TRUNC(1234.5678, 1) AS TRUNC3,
TRUNC(1234.5678, 2) AS TRUNC4,
TRUNC(1234.5678, -1) AS "TRUNC5",
TRUNC(1234.5678, -2) AS "TRUNC6"
FROM DUAL;

SELECT -- CEIL() 가장 큰 정수, FLOOR() 가장 작은 정수 , 올림과 내림하는 듯
CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

-- MOD() 나머지
SELECT 
MOD(15,6), 
MOD(10,2), 
MOD(11,2)
FROM DUAL;

-- 날짜함수
-- SYSDATE: 오늘 날짜/시간 조회 : 
-- ADD_MONTHS() : 몇개월 이후 날짜 구하기
-- MONTHS_BETWEEN() : 두 날짜 간의 개월 수 차이 구하기
-- NEXT_DAY() : 돌아오는 요일 구하기
-- LAST_DAY() : 달의 마지막 날짜 구하기
SELECT SYSDATE, SYSDATE - 1 YESTERDAY , SYSDATE - 2 YESTERYESTERDAY, SYSDATE - 3 YESTERYESTERYESTERDAY,
SYSDATE + 1 TOMARROW, SYSDATE + 2 TOMORRROW, SYSDATE +3 TOMORRRROW
FROM DUAL;

SELECT SYSDATE, CURRENT_DATE AS CURRENT_DATE, CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP
FROM DUAL;

-- 오늘 날짜를 기준으로 3개월 이후의 날짜
SELECT ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사한지 40년 넘은 사원 조회
SELECT *
FROM EMP e
WHERE SYSDATE > ADD_MONTHS(E.HIREDATE, 480);

-- 날짜 차이 MONTHS_BETWEEN()
-- 오늘날짜와 입사일자의 차이 구하기
SELECT
e.DEPTNO,
e.ENAME,
e.HIREDATE,
SYSDATE,
MONTHS_BETWEEN(SYSDATE, e.HIREDATE ) AS MONTH1,
MONTHS_BETWEEN(e.HIREDATE, SYSDATE ) AS MONTH2,
TRUNC(MONTHS_BETWEEN(SYSDATE, e.HIREDATE)) AS MONTH3
FROM EMP e ; 

-- NEXTDAY
SELECT sysdate, NEXT_DAY(SYSDATE, '월'), LAST_DAY(SYSDATE)
FROM DUAL;

-- 자료형을 변환하는 형변환 함수 
	-- TO_CHAR() : 문자열로 반환
	-- TO_NUMBER() : 숫자로 반환
	-- TO_DATE() : 날짜로 반환

SELECT 
E.EMPNO, E.ENAME, E.EMPNO + '500' -- number 타입 + '숫자' = 숫자 자동형변환
FROM EMP e
WHERE E.ENAME = 'SMITH';
 

SELECT SYSDATE, 
TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
TO_CHAR(SYSDATE, 'MON'),
TO_CHAR(SYSDATE, 'MONTH'),
TO_CHAR(SYSDATE, 'DD'),
TO_CHAR(SYSDATE, 'DY'),
TO_CHAR(SYSDATE, 'DAY'),
TO_CHAR(SYSDATE, 'DD-MM-DY')
FROM DUAL;

SELECT SYSDATE,
TO_CHAR(SYSDATE, 'HH24:MI:SS'),
TO_CHAR(SYSDATE, 'HH12:MI:SS AM'),
TO_CHAR(SYSDATE, 'HH:MI:SS PM'),
TO_CHAR(SYSDATE, 'HH:MI:SS')
FROM DUAL;