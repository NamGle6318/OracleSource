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
CEIL(7.609), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
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

-- 돈 양식으로 변경 
-- 9 : 숫자 한 자리
-- 0 : 숫자 한자리, 빈자리는 0으로 채움
SELECT e.SAL, TO_CHAR(e.SAL, '$999,999')
FROM EMP e;

-- TO_NUMBER()
-- 문자열 데이터와 숫자 데이터 연산
SELECT 1300-'1500', 1300 + '1500'
FROM DUAL;
-- 문자열(숫자) 끼리의 연산
SELECT '1300' - '1500'
FROM DUAL;

-- TO_NUMBER('문자열 데이터', '인식할 숫자 형태')
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM DUAL;

SELECT 
TO_DATE('1988-02-25', 'YY-MM-DD') AS DATE1,
TO_DATE('1988-02-25', 'YY/MM/DD') AS DATE2,
TO_DATE('1988-02-25', 'YY/MM-DD') AS DATE3
FROM DUAL;

--NULL
-- NULL 포함시, 산술연산이나 비교연산자(IS NULL, IS NOT NULL)가 제대로 수행되지 않음

--1. NVL(널 여부를 검사할 데이터, 널일때 반환할 데이터)
--2. NVL2(널 여부를 검사할 데이터, 널이 아닐때 반환할 데이터 ,널일때 반환할 데이터)
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.COMM,
	e.SAL + e.COMM,
	NVL(e.COMM, 0),
	e.SAL + NVL(e.COMM, 0)
FROM
	EMP e; 

SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.COMM,
	e.SAL + e.COMM,
	NVL2(e.COMM, 'O', 'N/A'),
	NVL2(e.COMM, e.SAL * 12 + e.COMM,e.SAL*12) AS 연봉
FROM
	EMP e; 

-- 자바의 if, switch 구문과 유사
-- DECODE ( 조건식은 무조건 = 비교)
-- DECODE(검사대상이 될 데이터,
-- 조건1, 조건1 만족시 반환할 거, 
-- 조건2, 조건2 만족시 반환할 거,
-- 조건a, 조건a 만족시 반환할 거
-- 조건1~조건a 만족하지 않을 때 반환할 결과
-- )

-- CASE
-- DECODE검사대상이 될 데이터
-- WHEN 조건1 THEN 조건1 만족시 반환할 거 
-- WHEN 조건2 THEN 조건2 만족시 반환할 거
-- WHEN 조건a THEN 조건a 만족시 반환할 거
-- ELSE 조건1~조건a 만족하지 않을 때 반환할 결과
-- END

-- 직책이 MANAAGER 인 사원은 급여의 10% 인상
-- 직책이 SALESMAN 인 사원은 급여의 5% 인상
-- 직책이 ANALYST 인 사원은 급여의 동결
-- 나머지 직책의 사우너은 급여 3%인상

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(
	e.JOB, 
	'MANAGER', e.SAL * 1.1,
	'SALESMAN', e.SAL * 1.05,
	'ANALYST', e.SAL,
	e.SAL * 1.03
	) AS UPSAL
FROM
	EMP e;

SELECT
e.EMPNO,
e.ENAME,
e.MGR,
DECODE(SUBSTR(TO_CHAR(NVL(e.mgr,0)),1,2),
'0', '0000',
'75', '5555',
'76', '6666',
'77', '7777',
'78', '8888',
SUBSTR(TO_CHAR(E.MGR),1))
FROM EMP e;

-- case
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		e.JOB
		WHEN 'MANAGER'
		THEN e.SAL * 1.1
		WHEN 'SALESMAN'
		THEN e.SAL * 1.05
		WHEN 'ANALYST'
		THEN e.SAL
		ELSE e.SAL * 1.03
	END AS UPSAL
FROM
	EMP e;

-- COMM NULL인 경우 '해당사항없음'
-- COMM 0인 경우 '수당없음'
-- COMM > 0 인 경우 '수당 : 800'

-- 조건식을 그때 그때 붙혀도 됨
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		WHEN e.COMM IS NULL
		THEN '해당사항 없음'
		WHEN e.COMM = 0
		THEN '수당 없음'
		WHEN e.COMM > 0
		THEN '수당 : ' || e.COMM
	END AS COMM_TEXT
FROM
	EMP e;

-- [실습]
-- 1. empno : 9999 형태 => 9** 변환
--    ename : SMITH 형태 => S****(길이만큼)
-- 출력 : 원본 EMPNO, AFTER EMPNO, 원본 ENAME, AFTER ENAME
SELECT
	e.EMPNO,
	REPLACE(e.EMPNO , SUBSTR(e.EMPNO, 3) , '**') AS "AFTER EMPNO",
	e.ENAME,
	REPLACE(e.ENAME, SUBSTR(e.ENAME, 2), '****') AS "AFTER ENAME"
FROM
	EMP e;

-- 데이터의 공간을 특정 문자로 채우기 : LPAD(), RPAD()
-- (데이터, 데이터 자리수, 채울문자)

-- ORACLE -> 10 자리로 표현
SELECT
	'Oracle',
	LPAD('Oracle', 10, '#'),
	RPAD('Oracle', 10, '*'),
	LPAD('Oracle', 10),
	RPAD('Oracle', 10)
FROM DUAL;

SELECT
	e.EMPNO,
	RPAD(SUBSTR(e.EMPNO, 0, 2), 4, '*') AS "AFTER EMPNO",
	e.ENAME,
	RPAD(SUBSTR(e.ENAME, 1, 1), LENGTH(SUBSTR(e.ENAME,1)), '*') AS "AFTER ENAME"
FROM
	EMP e;


-- 2. EMP 테이블에서 사원의 월 평균 근무일수는 21일.
-- 하루 근무시간을 8시간으로 보았을때 사원의 하루 급여(DAY_PAY),
-- 시급(TIME_PAY) 를 계산하여 출력 ( 단 하루 급여는 소수 셋째자리에서 버리고,
-- 시급은 둘째자리에서 반올림)
-- 출력형태 empno,ename,sal,day_pay,time_pay
SELECT
e.EMPNO,
e.ENAME,
e.SAL,
TRUNC(e.SAL  / 21, 2) AS day_pay,
ROUND(e.SAL / 21 / 8, 1) AS time_pay
FROM EMP e;


-- 3. 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
--    사원이  정직원이 되는 날짜(R_JOB)을 'YYYY-MM-DD' 형식으로 출력
--    단 추가수당이 없는 사원의 추가수당은 N/A로 출력
--     출력형태 ) EMPNO,ENAME,HIREDAE,R_JOB,COMM

SELECT
e.EMPNO,
e.ENAME,
e.HIREDATE,
TO_CHAR(ADD_MONTHS(e.HIREDATE, 3), 'YYYY-MM-DD') AS r_job,
NVL(TO_CHAR(e.COMM), 'N/A') AS "COMM"
FROM EMP e;




-- 4. 직속상관의 사원번호가 없을 때 : 0000
--    직속상권의 사원번호 앞두자리가 75일 때 : 5555 
--    직속상권의 사원번호 앞두자리가 76일 때 : 6666
--    직속상권의 사원번호 앞두자리가 77일 때 : 7777
--    직속상권의 사원번호 앞두자리가 78일 때 : 8888
--    그 외 직속 상관의 사원번호일때 : 본래 직속상관 사원번호 출력
--    출력형태 EMPNO, ENAME, MGR, (CHG_MGR)
SELECT
e.EMPNO,
e.ENAME,
e.MGR,
CASE 
	WHEN TO_CHAR(e.MGR) IS NULL THEN '0000'
	WHEN SUBSTR(TO_CHAR(e.MGR), 1, 2) = '75' THEN '5555'
	WHEN SUBSTR(TO_CHAR(e.MGR), 1, 2) = '76' THEN '6666'
	WHEN SUBSTR(TO_CHAR(e.MGR), 1, 2) = '77' THEN '7777'
	WHEN SUBSTR(TO_CHAR(e.MGR), 1, 2) = '78' THEN '8888'
	ELSE TO_CHAR(e.MGR) 
END AS "CHG_MGR"
FROM EMP e;

SELECT
e.EMPNO,
e.ENAME,
e.MGR,
CASE 
	WHEN e.MGR IS NULL THEN 0000
	WHEN e.mgr LIKE '75%' THEN 5555
	WHEN e.mgr LIKE '76%' THEN 6666
	WHEN e.mgr LIKE '77%' THEN 7777
	WHEN e.mgr LIKE '78%' THEN 8888
	ELSE e.MGR 
END AS "CHG_MGR"
FROM EMP e;

-- 하나의 열에 출력 결과를 담는 다중행 함수 = null 제외
-- 1. SUM()
-- 2. COUNT()
-- 3. MAX()
-- 4. MIN()
-- 5. AVG()

-- 전체 사원의 급여의 합 구하는
SELECT
SUM(E.SAL)
FROM
	EMP e;

-- 전체 사원의 급여의 합 구하는데 중복된 급여는 제외한 합
SELECT
SUM(E.SAL), sum(DISTINCT E.SAL), sum(ALL e.sal)
FROM
	EMP e;

-- 총사원의 인원수 구하기

SELECT count(e.empno), count(e.ename), count(e.COMM), count(e.HIREDATE), count(DISTINCT(e.JOB)), COUNT(E.JOB)
FROM emp e;

SELECT DISTINCT(e.JOB)
FROM EMP e;

-- 급여의 최대값 최소값
SELECT MAX(e.SAL) max, MIN(e.SAL) min
FROM EMP e;

-- 10번 부서 인원들의 급여 최대값
SELECT MAX(e.SAL)
FROM EMP e
WHERE e.DEPTNO = 10;

-- 20번 부서 인원들의 입사일중 가장 최근과 오래된 입사일
SELECT MAX(TO_CHAR(e.HIREDATE, 'YYYY-MM-DD')) JUNIOR, MIN(TO_CHAR(e.HIREDATE, 'YYYY-MM-DD')) SENIOR
FROM EMP e;

-- 부서가 30번인 사원의 평균 급여
SELECT AVG(e.SAL) avgSAL
FROM EMP e
WHERE e.DEPTNO = 30;

-- 결과값을 원하는 열로 묶어 출력 : GROUP BY 
-- 부서별 평균 급여 출력
SELECT 
AVG(e.SAL)
FROM EMP e
GROUP BY e.DEPTNO;

-- 부서별 평균 급여 조회
SELECT 
e.DEPTNO ,
AVG(e.SAL)
FROM EMP e
GROUP BY e.DEPTNO;

-- 부서별, 직책별 평균 급여 조회
SELECT 
e.DEPTNO,
e.job,
AVG(e.SAL)
FROM EMP e
GROUP BY e.DEPTNO, e.JOB
ORDER BY e.DEPTNO;

-- 다중행 함수와 같이 사용하는 일반 열들은 GROUP BY 절에 사용된 컬럼만 가능

-- GROUP BY + HAVING : 결과값을 원하는 열로 묶어 출력할때 조건 추가
-- 부서별, 직책별 평균 급여 조회 + 평균 급여 >=2000
SELECT
	e.DEPTNO,
	e.job,
	AVG(e.SAL)
FROM
	EMP e
GROUP BY
	e.DEPTNO,
	e.JOB
HAVING
	AVG(e.SAL) >= 2000
ORDER BY
	e.DEPTNO;

SELECT 
e.DEPTNO,
e.job,
AVG(e.SAL)
FROM EMP e
WHERE AVG(e.SAL) >= 2000 -- WHERE + 그룹 함수는 허가되지 않습니다. -- 실행순서에 따른 문제
GROUP BY e.DEPTNO, e.JOB
ORDER BY e.DEPTNO;

-- 실행순서
-- FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY

-- 같은 직무에 종사하는 사원이 3명 이상인 직책과 인원수를 출력
-- 출력 직책, 인원수
SELECT 
e.JOB, COUNT(e.EMPNO)
FROM EMP e
GROUP BY e.JOB
HAVING COUNT(e.EMPNO) >= 3;

-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- 출력 예시 1987 20 2 / 1987 30 1
SELECT 
TO_CHAR(e.HIREDATE, 'YYYY'), e.DEPTNO, COUNT(e.EMPNO)
FROM EMP e
GROUP BY TO_CHAR(e.HIREDATE, 'YYYY'), e.DEPTNO
ORDER BY TO_CHAR(e.HIREDATE, 'YYYY') ASC; -- = ORDER BY TO_NUMBER(TO_CHAR(e.HIREDATE, 'YYYY')) ASC;

-- JOIN
-- 여러 종류의 데이터를 다양한 테이블에 나누어 저장하기 때문에 여러 테이블의 데이터를 조합하여 
-- 출력할때가 많다. 이때 사용하는 방식이 조인
-- 결론 : 관계있는 여러 테이블 데이터를 조합하여 출력하는 기능

-- JOIN 의 종류
	-- 내부조인 : 연결이 안되는 데이터는 제외 - inner join
		-- 1. 등가조인 : 각 테이블의 특정 열과 일치하는 데이터를 기준으로 추출 
		-- 2. 비등가조인 : 두 테이블이 서로 일치하는 값이 없을때 = 등가조인 외 조인
		-- 3. 자체(self) 조인 : 같은 테이블끼리 조인
	-- 외부조인 : 연결 안되는 데이터 보기 -- outter join
		-- 1. 왼쪽외부조인(Left outter join) : 오른쪽 테이블의 데이터 존재 여부와 상관없이 왼쪽 테이블 기준으로 출력
		-- 2. 오른쪽외부조인(Right outter join) : 왼쪽 테이블의 데이터 존재 여부와 상관없이 오른쪽 테이블 기준으로 출력
		-- 결론 : (FROM : 왼쪽 l, 오른쪽 r) 어느쪽 테이블을 기준으로 출력느냐
-- 사원별 부서정보 조회 [등가조인]
SELECT e.*, d.*
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;

SELECT e.EMPNO, d.*
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO; -- 조건 안넣으면 나올수있는 조합의 최대치가 나옴 emp 12 * dept 4 = 48


-- 급여가 3000 이상인 사원별 부서정보 조회
SELECT e.EMPNO, e.sal, d.*
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL >= 3000;

-- 급여가 2500 이하이고, 사원번호가 9999 이하인 사원별 부서정보 조회
SELECT e.EMPNO, d.*
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL <= 2500 AND e.EMPNO <= 9999;

-- 사원별 정보 + SALGRADE.GRADE를 출력 [비등가조인]
SELECT e.*, s.GRADE 
FROM EMP e, SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 자체조인
-- 사원 정보 + 직속상관 정보
SELECT e1.EMPNO, e1.ENAME, e1.MGR , e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2 
WHERE e1.MGR = e2.EMPNO; 

-- 사원 정보 + 직속상관정보
-- 왼쪽 기준으로 외부조인 (+) -> oracle 기준 아우터 조인, sql 기준 표준안은 따로 있음
SELECT e1.EMPNO, e1.ENAME, e1.MGR , e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2 
WHERE e1.MGR = e2.EMPNO(+); 

-- 오른쪽 기준으로 외부조인
SELECT e1.EMPNO, e1.ENAME, e1.MGR , e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2 
WHERE e1.MGR(+) = e2.EMPNO; 

-- 표준 문법을 사용한 조인
-- INNER JOIN ON
-- 테이블1 JOIN 테이블2 ON(조인하는 조건)
-- 사원별 부서정보 조회 [등가조인 [SQL표준문법]]
SELECT e.*, d.*
FROM EMP e INNER JOIN DEPT d ON e.DEPTNO = d.DEPTNO;

-- 사원별 정보 + SALGRADE.GRADE를 출력 [비등가조인 [SQL표준문법]]
SELECT
	e.*,
	s.GRADE
FROM
	EMP e
INNER JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 표준문법을 사용한 조인 OUTTER JOIN
-- LEFT&RIGHT OUTER JOIN ON 
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR ,
	e2.ENAME AS mgr_ename
FROM
	EMP e1
LEFT OUTER JOIN EMP e2 ON
	e1.MGR = e2.EMPNO; 

SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR ,
	e2.ENAME AS mgr_ename
FROM
	EMP e1
RIGHT OUTER JOIN EMP e2 ON
	e1.MGR = e2.EMPNO; 

-- INNER, OUTER 생략가능
SELECT
	e.*,
	s.GRADE
FROM
	EMP e
/*INNER*/ JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 3개 이상의 테이블을 join
-- (테이블1 join 테이블2 on 조건) join 테이블3 on(조건)
SELECT *
FROM EMP E1 JOIN EMP e2 ON e1.EMPNO = e2.EMPNO JOIN EMP e3 ON e2.EMPNO = e3.EMPNO


-- 모든 부서정보와 사원정보를 부서번호, 사원번호 순서로 정렬하여 출력
SELECT
	*
FROM
	EMP e,
	DEPT d
WHERE
	e.DEPTNO = d.DEPTNO
ORDER BY
	e.EMPNO;

-- 급여가 2000을 초과한
-- 모든 부서정보, 사원 정보, 급여등급 정보, 각 사원의 직속 상관 정보를
-- 부서번호, 사원번호 순서로 정렬하여 출력 
SELECT
	d.*,
	e1.*,
	s.*,
	e2.EMPNO,
	e2.ENAME
FROM
	EMP e1
LEFT JOIN EMP e2 ON
	e1.MGR = e2.EMPNO
JOIN DEPT d ON
	e1.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON
	e1.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE e1.SAL > 2000
ORDER BY
	e1.DEPTNO,
	e1.EMPNO;

-- 모든 부서정보, 사원정보, 급여등급정보, 각 사원의 직속상관 정보를
-- 부서번호 사원번호 순서로 정렬하여 출력
-- 출력 : 부서번호, 부서명, 사원번호, 사원명, 매니저번호, 직무, 급여, losal,hisal, grade, 직속상관 매니저empno, 매니저이름
SELECT
	e1.DEPTNO,
	d.DNAME,
	e1.EMPNO,
	e2.ENAME,
	e1.MGR,
	d.LOC,
	e1.SAL,
	s.LOSAL,
	s.HISAL,
	s.GRADE,
	e2.EMPNO,
	e1.ENAME mgr_ename
FROM
	EMP e1
JOIN DEPT d ON
	e1.DEPTNO = d.DEPTNO
LEFT JOIN EMP e2 ON
	e1.MGR = e2.EMPNO
JOIN SALGRADE s ON
	e1.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	e1.DEPTNO,
	e1.EMPNO; 

-- 부서별 평균급여, 최대급여, 최소급여, 사원수 출력
-- 출력 : 부서번호, 부서명, avg_sal, min_sal, cnt
SELECT
	e.DEPTNO,
	d.dname,
	ROUND(AVG(e.SAL), 1) avg_sal, 
	MAX(e.SAL) max_sal,
	MIN(e.SAL) min_sal,
	COUNT(e.EMPNO) cnt
FROM
	EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY
	e.DEPTNO, d.dname
ORDER BY
	e.DEPTNO ASC;

-- subquery : SQL 구문을 실행하는데 필요한 데이터를
--			   추가로 조회하고자 SQL구문 내부에서 사용하는 SELECT 문
	-- 연산자 등의 비교 또는 조회 대상 오른쪽에 놓이며 괄호로 묶어서 사용
	-- 특수한 몇몇 경우를 제외한 대부분의 서브쿼리에서는 ORDER BY 절을 사용할 수 없다. -- 왜?
	-- 서브쿼리의 SELECT 절에 명시한 열은 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정 -- 
	-- 서브쿼리에 있는 SELECT문의 결과 행 수는 함께 사용하는 메인쿼리의 연산자 종류와 어울려야한다.

-- subquery의 종류
	-- 단일행 서브쿼리 : 실행결과가 행 하나인 서브쿼리
			-- 연산자 : >, >=, <, <=, (<> & ^= & !=) 비교연산자 및 등가비교연산자

	-- 다중행 서브쿼리 : 실행결과가 여러개의 행인 서브쿼리
			-- 연산자 : IN, any(some), all, exists
				-- ANY, SOME : 서브쿼리가 반환한 여러 결과값중 메인 쿼리와 조건식을 사용한 결과가 하나라도 TRUE라면
				--             메인쿼리 조건식을 TRUE로 반환

	-- 다중열 서브쿼리 : 서브쿼리의 SELECT 절에 비교할 데이터를 여러개 지정

-- 이름이 'JONES'인 사원의 급여보다 높은 급여를 받는 사원을 조회
-- 1. JONES의 급여 조회
-- 2. JONES의 급여보다 높은 사람만 조회
SELECT SAL FROM EMP e WHERE e.ENAME = 'JONES';

SELECT e.*
FROM EMP e
WHERE e.SAL > 2975;

-- SUBQUERY(단일행) 로 변경
SELECT e.*
FROM EMP e
WHERE e.SAL > (SELECT SAL FROM EMP e WHERE e.ENAME = 'JONES');-- = 2975

-- ALLEN 보다 입사일이 빠른 사원의 정보을 조회 [같은 타입]
SELECT e.*
FROM EMP e
WHERE e.HIREDATE < (SELECT e.HIREDATE FROM EMP e WHERE e.ENAME = 'ALLEN');

-- 20번 부서에 속한 사원중 전체 사원의 평균 급여보다 높은 급여를 갖는 사원 정보(사번, 이름, 직무 , 급여),
-- 소속부서 정보(DEPT) 조회 JOIN + SUBQUERY
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, d.*
FROM EMP e JOIN DEPT d ON e.SAL > (SELECT AVG(e.SAL) FROM EMP e) AND e.DEPTNO = 20 AND e.DEPTNO = d.DEPTNO;

-- 위와 동일하고, 전체사원의 평균급여보다 적거나 같은 급여를 갖는 20번 부서
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, d.*
FROM EMP e JOIN DEPT d ON e.SAL <= (SELECT AVG(e.SAL) FROM EMP e) AND e.DEPTNO = 20 AND e.DEPTNO = d.DEPTNO;

-- 다중행 서브쿼리 (IN 연산자 사용)
-- 부서별 최고급여와 같은 급여를 받는 사원을 조회
SELECT MAX(e.SAL) FROM EMP e GROUP BY e.DEPTNO;

SELECT e.*
FROM EMP e
WHERE e.SAL IN (SELECT MAX(e.SAL) FROM EMP e GROUP BY e.DEPTNO);

-- ANY, SOME = IN과 같은 값이나, ANY는 <, > 등의 연산자도 사용할 수 있음
SELECT MAX(e.SAL) FROM EMP e GROUP BY e.DEPTNO;

SELECT
	e.*
FROM
	EMP e
WHERE
	e.SAL = ANY ( -- ANY의 내용과 e.SAL을 비교하여 일치하는 e.SAL만 출력 = IN 
	SELECT
		MAX(e.SAL)
	FROM
		EMP e
	GROUP BY
		e.DEPTNO);

-- 30번 부서의 최대 급여보다 적은 급여를 받는 사원 조회
-- MAX를 사용하지 않은 이유? : 굳이 안써도 구할 수 있다는 예문
SELECT
e.*
FROM EMP e
WHERE e.SAL < ANY(SELECT E.SAL FROM EMP E WHERE E.DEPTNO =30) -- SAME
-- WHERE e.SAL < (SELECT MAX(E.SAL) FROM EMP E WHERE E.DEPTNO =30) -- SAME
ORDER BY e.SAL, e.EMPNO;

-- ALL : 서브쿼리의 모든 결과가 조건식에 맞아 떨어져야만 메인쿼리의 조건식이 TRUE

-- 30번 부서의 최소 급여보다 적은 급여를 받는 사원 조회
SELECT
	e.*
FROM
	EMP e
WHERE
	e.SAL < ALL(SELECT E.SAL FROM EMP E WHERE E.DEPTNO = 30)
ORDER BY
	e.SAL,
	e.EMPNO;

-- EXISTS : 서브쿼리에 결과값이 하나 이상 있으면 조건식이 모두 TRUE, 없으면 FALSE
-- EMP 내에 DEPTNO가 10번인 행이 있으므로 모두 출력
SELECT * FROM EMP WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO=10);

-- EMP 내에 DEPTNO가 50번인 행이 없으므로 모두 출력 안함
SELECT * FROM EMP WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO=50);

-- 다중열 서브쿼리
-- 부서별 최고급여와 같은 급여를 받는 사원과 부서번호를 조회
SELECT e.*
FROM EMP e
WHERE (e.DEPTNO, e.SAL) IN (SELECT e.DEPTNO, MAX(e.SAL)FROM EMP e GROUP BY e.DEPTNO);

SELECT e.*
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO IN (10 AND 30) AND e.SAL = MAX(e.SAL); -- TODO 왜 저리 되는가

-- SELECT절에 사용하는 서브쿼리 (결과가 반드시 하나만 반환)
-- 사원정보, 급여등급, 부서명 조회(JOIN) 
SELECT
	e.EMPNO,
	e.JOB,
	e.SAL,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL) AS salgrade, -- todo 하나만 넣어야 되는 이유
	e.DEPTNO,
	(SELECT d.DNAME FROM DEPT d WHERE e.DEPTNO = d.DEPTNO) AS dname
FROM
	EMP e
	
-- 10번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사원번호(사번, 이름, 직무)
-- 부서번호(부서번호, 부서명, 위치)를 조회
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
	AND e.DEPTNO = 10
	AND e.JOB != ALL (SELECT e.JOB FROM EMP e WHERE e.DEPTNO = 30);

	
-- 직책이 SALESMAN 인 사람의 최고급여보다 많이 받는 사람의 사원정보, 급여등급 정보를 조회
-- 다중행 함수(ANY, SOME)을 사용하는 방법과 사용하지 않는 방법 2가지로 작성
-- 출력 : 사번, 이름, 급여, 등급
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	s.GRADE
FROM
	EMP e
JOIN SALGRADE s ON
	e.SAL > (
	SELECT
		MAX(e.SAL)
	FROM
		EMP e
	WHERE 
		e.JOB = 'SALESMAN')
	AND e.SAL BETWEEN s.LOSAL AND s.HISAL;

SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	(SELECT s.GRADE FROM SALGRADE s WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL) AS GRADE
FROM
	EMP e
WHERE
	e.SAL > (
	SELECT
		MAX(e.SAL)
	FROM
		EMP e
	WHERE 
		e.JOB = 'SALESMAN');

SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	s.GRADE
FROM
	EMP e
JOIN SALGRADE s ON
	e.SAL > ALL (
	SELECT
		e.SAL
	FROM
		EMP e
	WHERE
		e.JOB = 'SALESMAN')
	AND e.SAL BETWEEN s.LOSAL AND s.HISAL ;

-- CRUD - Create(INSERT)
-- CREATE : 테이블 생성
	-- CREATE TABLE 생성할 테이블 명 AS 복사할 테이블;
-- INSERT : 삽입
	-- INSERT INTO 테이블명(필드명, 필드명, ...)
	-- VALUES(값1, 값2, ...)

-- 기존 테이블을 복사 후 새 테이블로 생성
CREATE TABLE dept_temp AS SELECT * FROM dept;

SELECT * FROM DEPT_TEMP;

INSERT INTO dept_temp(DEPTNO, DNAME, LOC)
VALUES(50, 'DATABASE', 'SEOUL');

INSERT INTO dept_temp -- 필드명 일단 생략 가능함 안될때도 있음
VALUES(60, 'NETWORK', 'BUSAN');

INSERT INTO dept_temp
VALUES('70', 'NETWORK', 'BUSAN');

SELECT * FROM DEPT_TEMP;

INSERT INTO dept_temp(DEPTNO, DNAME, LOC) -- 필드와 값의 개수가 일치하지 않으면 실행 X
VALUES('NETWORK', 'BUSAN');
INSERT INTO dept_temp(DEPTNO, DNAME, LOC) -- 필드와 값의 개수가 일치하지 않으면 실행 X
VALUES('NETWORK', 'BUSAN', 'NETWORK', 'BUSAN');

INSERT INTO dept_temp -- deptno TYPE = number(2, 0) 2자리 소수점 0 -> 실행 x 
VALUES(600, 'NETWORK', 'BUSAN');

INSERT INTO dept_temp -- NULL 넣기 방법 1 (null 명시)
VALUES(80, 'NETWORK', null);

-- 필드명 생략은 테이블의 현재 열 순서대로 나열되었다고 가정하고 데이터 처리
INSERT INTO dept_temp(deptno, dname) -- NULL 넣기 방법 2 (필드명 생략)
VALUES(90, 'NETWORK'); 
-- 단 해당 필드의 타입이 not null이면 null 못 넣음 NOT NULL [ ]

-- 열 구조만 복사 후 새 테이블 생성하기
CREATE TABLE emp_temp 
AS SELECT * FROM emp WHERE 1<>1;

SELECT * FROM emp_temp;

-- 데이터 삽입 가능 양식 : YYYY-MM-DD OR YYYY/MM/DD
INSERT INTO EMP_TEMP(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2020-12-13', 5000, 1000, 10)

INSERT INTO EMP_TEMP(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES(3111, '성춘향', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);

-- emp, salgrade 급여등급이 1인 사원들만 emp_temp에 추가
INSERT
	INTO
	EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT -- values대신 subquery
	e.*
FROM
	EMP e
JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL
	AND s.GRADE = 1;

-- CRUD - U(Update) : 수정
-- UPDATE 테이블명 SET 변경할열 = 값 . . . 
-- WHERE 데이터를 변경할 대상 행을 선별하는 조건 나열
SELECT * FROM emp_temp;
-- 90번 부서의 LOC를 SEOUL로 변경
UPDATE dept_temp SET LOC = 'SEOUL';
UPDATE emp_temp SET sal = 300 WHERE empno = 9999;

WHERE DEPTNO = 90;

-- COMMIT
-- ROLLBACK

-- 40번 부서의 부서명, 위치 변경
-- DEPT 테이블의 40번 부서랑 동일
UPDATE dept_temp 
SET (DNAME, LOC) = (SELECT dname, loc FROM DEPT WHERE DEPTNO = 40)
WHERE DEPTNO = 40;

-- 50번 부서의 부서명과 위치를 변경
UPDATE dept_temp 
SET LOC = 'BOSTON', DNAME = 'SALES'
WHERE DEPTNO = 50;

-- CRUD - D(Delete) : 삭제
-- DELETE FROM 테이블명    -- FROM 생략 가능 
-- WHERE 삭제할 조건 

-- DEPT_TEMP 테이블의 70번 부서 삭제
SELECT * FROM dept_temp;
DELETE DEPT_TEMP WHERE DEPTNO = 70;

-- DEPT_TEMP 테이블의 LOC가 SEOUL인 행 삭제
DELETE DEPT_TEMP WHERE LOC = 'SEOUL';

-- EMP_TEMP의 SAL이 3000이상인 사람 삭제
SELECT * FROM EMP_TEMP;

DELETE EMP_TEMP WHERE SAL >= 3000;

DELETE EMP_TEMP; -- DELETE, UPDATE문에서 WHERE 생략시 많은 데이터, 파일이 날라갈 수 있음을 주의














CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;
SELECT * FROM EXAM_EMP;
SELECT * FROM EXAM_DEPT;
-- EXAM_DEPT 테이블에 다음 데이터를 삽입하기
-- 50, ORACLE, BUSAN
-- 60, SQL, ILSAN
-- 70, SELECT, INCHEON
-- 80, DML, BUNDANG
INSERT INTO EXAM_DEPT VALUES(50, 'ORACLE', 'BUSAN');
INSERT INTO EXAM_DEPT VALUES(60, 'SQL', 'ILSAN');
INSERT INTO EXAM_DEPT VALUES(70, 'SELECT', 'INCHEON');
INSERT INTO EXAM_DEPT VALUES(80, 'DML', 'BUNDANG');

-- EXAM_EMP 테이블에 다음 데이터 삽입하기
-- 7201, USER1, MANAGER, 7788, 2016-02-01, 4500, NULL, 50
-- 7202, USER2, CLERK, 7201, 2016-02-16, 1800, NULL, 50
-- 7203, USER3, ANALYST, 7201, 2016-04-11, 3400, NULL, 60
-- 7204, USER4, SALESMAN, 7201, 2016-05-31, 2700, 300L, 60
-- 7205, USER5, CLERK, 7201, 2016-07-20, 2600, NULL, 70
-- 7206, USER6, CLERK, 7201, 2016-09-08, 2600, NULL, 70
-- 7207, USER7, LECTURER, 7201, 2016-10-28, 2300, NULL, 80
-- 7208, USER8, STUDENT, 7201, 2018-03-09, 1200, NULL, 80
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7201, 'USER1', 'MANAGER', 7788, '2016-02-01', 4500, NULL, 50);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7202, 'USER2', 'CLERK', 7201, '2016-02-16', 1800, NULL, 50);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7203, 'USER3', 'ANALYST', 7201, '2016-04-11', 3400, NULL, 60);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7204, 'USER4', 'SALESMAN', 7201, '2016-05-31', 2700, 300, 60);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7205, 'USER5', 'CLERK', 7201, '2016-07-20', 2600, NULL, 70);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7206, 'USER6', 'CLERK', 7201, '2016-09-08', 2600, NULL, 70);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7207, 'USER7', 'LECTURER', 7201, '2016-10-28', 2300, NULL, 80);
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7208, 'USER8', 'STUDENT', 7201, '2018-03-09', 1200, NULL, 80);
SELECT * FROM EXAM_EMP;
-- EXAM_EMP 에서 50번 부서에서 근무하는 사원의 평균 급여보다 많이 받는 사원을
-- 70번 부서로 옮기는 SQL 구문 작성
--SELECT로 찾고 실행하고 다시 찾기
SELECT * FROM EXAM_EMP;
UPDATE EXAM_EMP 
SET DEPTNO = 70 
WHERE SAL > (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO = 50);

-- EXAM_EMP 에서 입사일이 가장 빠른 60번 부서의 사원보다 늦게 입사한 사원의
-- 급여를 10% 인상하고 80번 부서로 옮기는 SQL 구문 작성
UPDATE EXAM_EMP
SET sal = SAL * 1.1, DEPTNO = 80
WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO = 60);
-- EXAM_EMP에서 급여등급이 5인 사원을 삭제하는 SQL 구문 작성
-- 급여등급이 5인 사원들 = sal이 30001 이상인 직원들
SELECT * FROM EXAM_SALGRADE;
SELECT * FROM EXAM_EMP;
SELECT * FROM EMP;

DELETE  EXAM_EMP
WHERE EMPNO IN (SELECT e.empno FROM EXAM_EMP e JOIN EXAM_SALGRADE s ON GRADE = 5 AND SAL BETWEEN LOSAL AND HISAL);


-- 트랜잭션(tranjection) : ALL or NOTHING (전부실행 OR 전부취소) 1-2-3이 있을때 1,2,3 모두 실행하거나 모두 실행 안해야함
-- DML(데이터 조작어) - INSERT, UPDATE, DELETE 
-- COMMIT(전부실행) / ROOLBACK(전부취소) : 

INSERT INTO DEPT_TEMP VALUES (30, 'DATABASE', 'SEOUL');
UPDATE DEPT_TEMP SET LOC = 'BUSAN' WHERE DEPTNO = 30;
DELETE DEPT_TEMP WHERE LOC = 'RESERECH';

COMMIT;
ROLLBACK;

-- 세션 : 데이터베이스 접속 후 작업을 수행한 후 접속을 종료하기까지의 전체 기간
SELECT * FROM DEPT_TEMP;
DELETE DEPT_TEMP WHERE DEPTNO = 30;

-- DDL (데이터 정의어) : 객체를 생성, 변경, 삭제
	-- 데이터 생성 : CREATE
	-- 데이터 변경 : ALTER
	-- 데이터 삭제 : DROP
	-- 테이블 전체 데이터 삭제 : TRUNCATE
	-- 테이블 이름 변경 : RENAME

-- CREATE TABLE 테이블명(
-- 	컬럼명1 자료형,
-- 	컬럼명2 자료형,
-- 	컬럼명n 자료형,
-- 	. . .
-- )

-- 테이블명의 규칙 
	-- 문자로 시작
	-- 테이블 이름은 30BYTE 이하 
	-- 같은 사용자 안에서는 테이블명 중복 불가
	-- SQL 예약어는 테이블명으로 사용불가

CREATE TABLE DEPT_DDL(
	DEPTNO NUMBER(2,0),
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);SCOTT.EMP_DDL

SELECT * FROM dept_ddl;

CREATE TABLE EMP_DDL (
	EMPNO NUMBER(4,0),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0)
);



-- 기존 테이블 구조와 데이터를 이용한 새 테이블 생성
CREATE TABLE exam_emp AS SELECT * FROM emp; 
CREATE TABLE exam_emp AS SELECT * FROM emp WHERE 1<>1; -- 테이블 구조만 가져옴

-- ALTER : 테이블 변경
	-- 열 추가
	-- 열 이름 변경
	-- 열 저료형 변경
	-- 특정 열 삭제

-- ALTER - HP열 추가
	--ALTER TABLE 테이블명 ADD 열 열타입;
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);
SELECT * FROM EMP_DDL;

-- ALTER - 열 이름 변경 HP -> TEL
	-- ALTER TABLE 테이블명 RENAME COLUMN 열 TO 열;
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;

-- ALTER - 열 자료형 변경 EMPNO NUMBER(4,0 ) -> NUMBER(5, 0)
	-- ALTER TABLE 테이블명 MODIFY 열 타입;
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(3);

ALTER TABLE EMP_TEMP MODIFY EMPNO NUMBER(5); -- 이미 데이터가 존재할 경우 축소가 그냥 안됨

-- ALTER - 특정 열 삭제
	-- ALTER TABLE 테이블 DROP COLUMN 열;
ALTER TABLE EMP_DDL DROP COLUMN TEL;

-- 테이블 이름 변경
	-- RENAME 테이블 TO 테이블;
RENAME EMP_DDL TO EMP_RENAME;

-- 테이블 데이터 삭제
	-- 전체 데이터 삭제 : TRUNCATE TABLE 테이블;
TRUNCATE TABLE EMP_RENAME;

-- 테이블 제거
	-- DROP TABLE 테이블;
DROP TABLE EMP_RENAME;


-- MEMBER 테이블 생성하기
-- ID VARCHAR2(8) / NAME 10 / ADDR 50 / EMAIL 30 / AGE NUMBER(4)
CREATE TABLE MEMBER(
	ID VARCHAR2(8),
	NAME VARCHAR2(10),
	ADDR VARCHAR2(50),
	EMAIL VARCHAR2(30),
	AGE NUMBER(4, 0)
);

SELECT * FROM MEMBER;
-- INSERT (REMARK = X)
INSERT INTO MEMBER (ID, NAME, ADDR, EMAIL, AGE)
VALUES ('hong123', '홍길동', '서울시 종로구', 'hong123@gmail.com', 24);

-- MEMBER 테이블 열 추가하기
-- bigo (문자열 20)
ALTER TABLE MEMBER ADD BIGO VARCHAR(20);

-- bigo 열 크기를 20 -> 30으로 변경
ALTER TABLE MEMBER MODIFY BIGO VARCHAR(30);
-- bigo 열 이름을 remark로 변경
ALTER TABLE MEMBER RENAME COLUMN BIGO TO REMARK;
------------------------------------------------------------------ 객체 시작
-- ORACLE 객체 (TABLE, INDEX, VIEW, SEQUENCE)
-- 1. 오라클 데이터베이스 테이블
	-- 사용자 테이블 : scott, hr ...
	-- 데이터 사전 : 중요한 데이터 보관(사용자, 권한, 메모리, 성능 ...)
		-- 일반 사용자가 접근하는 곳은 아님

SELECT * FROM DICT ORDER BY TABLE_NAME; -- USER.*, all_*, dba_, v$* ...
SELECT *
FROM USER_TABLES;

-- 2. 인덱스 : 검색을 빠르게 처리
	-- FULL SCAN : SELECT * FROM TABLE
	-- INDEX SCAN 

-- 인덱스 조회
SELECT * FROM USER_INDEXES;

-- 인덱스 생성
	-- CREATE INDEX 인덱스명 ON 테이블명(열이름 ASC OR DESC, 열이름 ...)
CREATE INDEX IDX_EMP_TEMP_SAL ON EMP_TEMP(SAL);

-- 인덱스 삭제 
DROP INDEX IDX_EMP_TEMP_SAL;

SELECT * FROM EMP e; -- FULL SCAN

-- 3. VIEW : 가상 테이블
	-- CREATE VIEW 뷰이름(열이름1, 열이름2 ...) AS (저장할 SELECT 구문)
	-- 권한을 가진 사용자만 생성 가능
	-- 보안성 : 특정 열을 노출하지 않을 수 있음
	-- 편리성 : 
CREATE VIEW DEPTNO_20_EMP AS(
SELECT e.EMPNO, e.ENAME, e.JOB, e.DEPTNO
FROM EMP e
WHERE e.DEPTNO = 20); -- SCOTT/Views 파일에 DEPTNO_20_EMP 생성됨
SELECT * FROM EMP;
SELECT * FROM DEPTNO_20_EMP;
DROP VIEW DEPTNO_20_EMP;

SELECT * FROM EMP_TEMP;

-- 4. 시퀀스 : 오라클 데이터베이스에서 특정 규칙에 따른 연속 숫자를 생성하는 객체
	-- 규칙에 따라 순번을 생성
	-- ORACLE에만 있음
	-- CREATE SEQUENCE 시퀀스명; : 기본값

	-- CREATE SEQUENCE  
	-- INCREMENT BY 1 : 시퀀스에서 생성할 번호의 증가값 = 1씩 증가 
	-- MINVALUE 1 : 시퀀스에서 생성할 번호의 최소값
		-- NOMINVALUE : ASC = 1
	-- MAXVALUE 9999999999999999999999999999 : 시퀀스에서 생성할 수 있는 최대값
	-- NOCYCLE : MINVALUE -> MAXVALUE 까지 한 사이클 다 돌고 나서 새로운 번호 요청시 에러 발생시킴.
		-- CYCLE : MINVALUE -> MAXVALUE 까지 실행 후 다시 MINVALUE부터 시작
	-- CACHE 20 NOORDER : 시퀀스가 생성할 번호를 메모리에 미리 할당해 놓을 개수를 지정
		-- NOCACHE : 할당 안해
		-- NOORDER : ORDER BY?
	
CREATE SEQUENCE board_seq;
-- MEMBER TABLE에 NO 칼럼 추가
SELECT * FROM MEMBER;

ALTER TABLE MEMBER ADD NO NUMBER(20);

-- MEMBER INSERT 시 NO값은 SEQUENCE값으로 입력하기
-- 사용할 시퀀스 생성

CREATE SEQUENCE MEMBER_SEQ;
INSERT INTO MEMBER (ID, NAME, ADDR, EMAIL, AGE, NO)
VALUES ('hong123', '홍길동', '서울시 종로구', 'hong123@gmail.com', 24, MEMBER_SEQ.NEXTVAL);

-- SEQUENCE.NEXTVAL : 해당 시퀀스 발행
-- SEQUENCE.CURRVAL : 가장 마지막으로 생성된 시퀀스 값 확인
SELECT MEMBER_SEQ.CURRVAL FROM DUAL; 

-- SEQUENCE 는 발행한 순간 되돌릴 수 없다.

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE CACHE 2;

CREATE TABLE dept_sequence AS SELECT * FROM DEPT WHERE 1<>1;

INSERT INTO DEPT_SEQUENCE 
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
SELECT * FROM DEPT_SEQUENCE;

SELECT SEQ_DEPT_SEQUENCE.CURRVAL FROM DUAL;

-- SEQUENCE 수정
	-- ALTER SEQUENCE 시퀀스명 ~~
ALTER SEQUENCE SEQ_DEPT_SEQUENCE 
INCREMENT BY 3
MAXVALUE 99
CYCLE;

-- SEQUENCE 제거
	-- DROP SEQUENCE 시퀀스명 
DROP SEQUENCE SEQ_DEPT_SEQUENCE;
DROP SEQUENCE BOARD_SEQ;
-------------------------------------------- 객체 끝
-- 제약조건(*) : 테이블에 저장할 데이터를 제약하는 특수한 규칙 
-- 종류
	-- 1. NOT NULL : 빈 값을 허용하지 않음
	-- 2. UNIQUE : 중복 불가
	-- 3. PRIMARY KEY(PK) : 유일하게 하나만 존재 NOT NULL + UNIQUE
	-- 4. FOREIGN KEY(FK) : 다른 테이블과 관계 맺기
	-- 5. CHECK : 데이터 형태와 범위를 지정
	-- 6. DEFAULT : 기본값 설정

-- 제약조건 설정
	-- 테이블 생성시 컬럼 명과 타입 뒤에 제약조건 명시하기
CREATE TABLE TBL_NOTNULL(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);
-- ORA_01400 : NULL을 ("SCOTT"."TBL_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
INSERT INTO TBL_NOTNULL(LOGIN_ID, LOGIN_PWD, TEL)
VALUES('1577', NULL, 010-1234-5678);

INSERT INTO TBL_NOTNULL(LOGIN_ID, LOGIN_PWD, TEL)
VALUES('1577', '', 010-1234-5678); -- '' = NULL

INSERT INTO TBL_NOTNULL(LOGIN_ID, LOGIN_PWD)
VALUES('1577', 'HONG'); -- '' = NULL

-- CONSTRAINT 제약조건명 : 제약조건에 이름 넣어주기(중복불가)
CREATE TABLE TBL_NOTNULL2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LOGID_NN NOT NULL,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LOGPWD_NN NOT NULL,
	TEL VARCHAR2(20)
);
-- 기존 열에 제약조건 추가
	-- ALTER TABLE 테이블명 MODIFY 열이름 열타입 제약조건;
ALTER TABLE TBL_NOTNULL MODIFY LOGIN_ID VARCHAR2(20) NULL;

-- 기존 열에 제약조건 변경 가능하나, 이미 삽입된 데이터가 제약조건에 만족해야 변경가능
ALTER TABLE TBL_NOTNULL MODIFY TEL VARCHAR2(20) NOT NULL;

UPDATE TBL_NOTNULL SET TEL = '1577-1577' WHERE LOGIN_ID = '1577';

ALTER TABLE TBL_NOTNULL2 MODIFY TEL CONSTRAINT TBLNN2_TEL_NN NOT NULL;

-- 제약조건 이름 변경
ALTER TABLE TBL_NOTNULL2 RENAME CONSTRAINT TBLNN2_TEL_NN TO TBL_NM2_TEL_NN;

-- 제약조건 삭제
ALTER TABLE TBL_NOTNULL2 DROP CONSTRAINT TBL_NM2_TEL_NN;

-- UNIQUE : 데이터의 중복을 허용하지 않음.
	-- 단 NULL 은 중복 대상에서 제외됨

CREATE TABLE TBL_UNIQUE(
	LOGIN_ID VARCHAR2(20) UNIQUE,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);
-- 데이터 무결성 
	-- 데이터베이스에 저장되는 데이터의 정확성과 일치성 보장
	-- DML 과정에서 지켜야 하는 규칙

-- ORA-00001: 무결성 제약 조건(SCOTT.SYS_C008393)에 위배됩니다
INSERT INTO TBL_UNIQUE(LOGIN_ID, LOGIN_PWD,TEL)
VALUES('1Q2W3E4R3###', 'HOKINS', '1577-1587'); -- 중복 불가

INSERT INTO TBL_UNIQUE(LOGIN_ID, LOGIN_PWD,TEL)
VALUES('', 'HOKINS', '1577-1577'); -- NULL 은 UNIQUE 판별 대상에서 제외

ALTER TABLE TBL_UNIQUE MODIFY TEL VARCHAR2(20) UNIQUE;

UPDATE TBL_UNIQUE tu SET TEL = NULL;

-- 유일하게 하나만 있는 값 : PRIMARY KEY(PK)
	-- PK : NOT NULL + UNIQUE
	--      한 테이블에서 단 하나의 열에만 PK 설정 가능

CREATE TABLE TBL_PK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20) 
);

CREATE TABLE TBL_PK2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLPK2_LGNID_PK PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20) 
);
-- ORA-00001: 무결성 제약 조건(SCOTT.SYS_C008397)에 위배됩니다
INSERT INTO TBL_PK(LOGIN_ID, LOGIN_PWD,TEL)
VALUES('유일한', '1Q2W3E4R', '1577-1587');

-- 외래키(FK) : 다른 테이블과 관계를 맺는 키 <=> JOIN
	-- EX) EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
	--     DEPTNO = FK

-- 부서 테이블 생성 (참조 대상이 되는 테이블 먼저 작성)
CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);
SELECT * FROM EMP WHERE 1<>1;
CREATE TABLE EMP_FK(
	 EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
	 ENAME VARCHAR2(10) NOT NULL,
	 JOB VARCHAR2(9) NOT NULL,
	 MGR NUMBER(4),
	 HIREDATE DATE,
	 SAL NUMBER(7) NOT NULL,
	 COMM NUMBER(7, 2),
	 DEPTNO CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) -- FK 선언
);
-- ORA-02291: 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다
-- - 부모 키가 없습니다
INSERT INTO EMP_FK (EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO)
VALUES (1, 'TEST1', 'PARTNER', SYSDATE, 2500, 10);

-- FK INSERT시 주의점 (부모-> 자식)
	-- 참조 대상이 되는 테이블(부모)의 데이터 삽입 
	-- 참조 하는 테이블(자식)의 데이터 삽입

INSERT INTO DEPT_FK 
VALUES (10, 'DATABASE', 'SEOUL');

-- FK DELETE시 주의점 (자식 -> 부모)
	-- 참조하는 테이블(자식)의 데이터 삭제
	-- 참조 대상이 되는 테이블(부모)의 데이터 삭제
-- ORA-02292: 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다
-- - 자식 레코드가 발견되었습니다
DELETE FROM DEPT_FK WHERE DEPTNO = 10;

-- FK 관련 키 삭제시 옵션 설정
	-- ON DELETE CASCADE : 부모 삭제 될 때 자식도 같이 삭제
	-- ON DELETE SET NULL : 부모 삭제 될 때 연결된 자식의 부모는 NULL로 변경
CREATE TABLE EMP_FK2(
	 EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK2 PRIMARY KEY,
	 ENAME VARCHAR2(10) NOT NULL,
	 JOB VARCHAR2(9) NOT NULL,
	 MGR NUMBER(4),
	 HIREDATE DATE,
	 SAL NUMBER(7) NOT NULL,
	 COMM NUMBER(7, 2),
	 DEPTNO CONSTRAINT EMPFK_DEPTNO_FK2 REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE --
);

CREATE TABLE EMP_FK3(
	 EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK3 PRIMARY KEY,
	 ENAME VARCHAR2(10) NOT NULL,
	 JOB VARCHAR2(9) NOT NULL,
	 MGR NUMBER(4),
	 HIREDATE DATE,
	 SAL NUMBER(7) NOT NULL,
	 COMM NUMBER(7, 2),
	 DEPTNO CONSTRAINT EMPFK_DEPTNO_FK3 REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL --
);

INSERT INTO DEPT_FK 
VALUES (20, 'NETWORK', 'BUSAN');

INSERT INTO EMP_FK2 (EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO)
VALUES (1, 'TEST1', 'PARTNER', SYSDATE, 2500, 10); -- CASCADE : DELETE

INSERT INTO EMP_FK3 (EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO)
VALUES (1, 'TEST1', 'PARTNER', SYSDATE, 2500, 10); -- SETNULL : DEPTNO -> NULL

DELETE FROM DEPT_FK WHERE DEPTNO = 20;

-- 자식 먼저 삭제 후 부모 삭제
DELETE FROM EMP_FK WHERE EMPNO = 1;
DELETE FROM DEPT_FK WHERE DEPTNO = 10;


DROP TABLE MEMBER;
-- MEMBER table 생성하기
-- id : PK, NAME : NOT NULL, EMAIL : NOT NULL
CREATE TABLE MEMBER(
	NO NUMBER(8) UNIQUE,
	ID VARCHAR2(10) PRIMARY KEY,
	NAME VARCHAR2(10) NOT NULL,
	ADDR VARCHAR2(50),
	EMAIL VARCHAR2(30) NOT NULL,
	AGE NUMBER(4, 0)
);
SELECT * FROM MEMBER;
SELECT MEMBER_SEQ.NEXTVAL FROM DUAL;

SELECT * FROM MEMBER;

SELECT * FROM MEMBER m WHERE m.NAME LIKE '%홍%';

-- check : 데이터의 형태와 범위를 지정
	-- CHECK(조건)
	-- CHECK(LENGTH(변수명) > 3) : 데이터 길이가 3이상
	

CREATE TABLE TBL_CHECK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) CHECK(LENGTH(LOGIN_PWD) > 3),
	TEL VARCHAR2(20) 
);

INSERT INTO TBL_CHECK 
VALUES('TEST_ID', '1234', '010-2345-6789');

-- DEFAULT : 기본값 = 값을 넣지 않으면 기본값으로 설정된 값이 됨
	-- DEFAULT 값
CREATE TABLE TBL_DEFAULT(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
	TEL VARCHAR2(20) 
);
INSERT INTO TBL_DEFAULT(LOGIN_ID, TEL)
VALUES ('abc3', '112');

CREATE TABLE BOARD(
	ID NUMBER(8) PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL CHECK (LENGTH(NAME) > 1),
	REGDATE DATE DEFAULT SYSDATE
);
DELETE BOARD;
DROP TABLE BOARD;
INSERT INTO BOARD (ID, NAME)
VALUES(1, 'DR.HONG');

SELECT * FROM BOARD;

SELECT * FROM MEMBER WHERE NAME LIKE '%홍%';