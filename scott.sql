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