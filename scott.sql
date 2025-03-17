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
