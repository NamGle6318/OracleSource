-- hr.employees = bigger scott emp
SELECT * FROM hr.EMPLOYEES e;

-- employees - first_name, last_name, job_id를 조회
SELECT e.FIRST_NAME, e.LAST_NAME, e.JOB_ID FROM EMPLOYEES e;

--Job_id 중복제외 후 조회
SELECT DISTINCT e.JOB_ID FROM EMPLOYEES e;

-- 사번이 176인 사원의 last_name, 부서 번호 조회
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	e.EMPLOYEE_ID = 176;

-- 급여가 12000 이상 되는 사원들의 last_name과 salary 를 조회
SELECT
	e.LAST_NAME,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.SALARY > 12000 ;

-- 급여가 5000~12000의 범위가 아닌 사원의 last_name과 salary 를 조회
SELECT
	e.LAST_NAME,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	NOT (e.SALARY >= 5000 AND e.SALARY <= 12000);

-- 급여가 5000~12000의 범위가 아닌 사원의 last_name과 salary 를 조회 (BETWEEN 사용)
SELECT
	e.LAST_NAME,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	E.SALARY NOT BETWEEN 5000 AND 12000;

-- IN 사용하여 20, 50번 부서에 근무하는 사월 조회(이름, 부서번호) 이름을 오름차순으로 정렬
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID IN (20, 50)
ORDER BY
	e.LAST_NAME ASC; 

-- 급여가 2500,3500,7000이 아니고 직무가 SA_REP, ST_CLERK가 아닌 사원 조회
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.SALARY NOT IN (2500, 3500, 7000)
	AND e.JOB_ID NOT IN ('SA_REP', 'ST_CLERK');

-- 고용일이 2014년 사원 조회
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE >= '2014-01-01'
	AND e.HIRE_DATE <= '2014-12-31';
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE BETWEEN '2014-01-01' AND '2014-12-31';

-- LIKE
-- 이름에 u가 포함되는 사원들의 사번, 이름을 조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e
WHERE e.LAST_NAME LIKE '%u%'; 

-- 이름의 4번째 글자가 a인 사원들의 사번, 이름을 조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e
WHERE e.LAST_NAME LIKE '___a%'; 
-- 이름에 a 혹은 e 글자가 있는 사원들의 사번, 이름을 조회, 이름을 내림차순으로 정렬
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e
WHERE e.LAST_NAME LIKE '%a%' OR e.LAST_NAME LIKE  '%e%'
--WHERE REGEXP_LIKE(e.LAST_NAME, 'a|e')
ORDER BY e.LAST_NAME DESC; 

-- 이름에 a와 e가 모두 있는 사원들의 사번, 이름을 조회, 이름을 내림차순으로 정렬
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e
WHERE e.LAST_NAME  LIKE '%a%' AND e.LAST_NAME LIKE '%e%' -- = %e%a% OR %a%e%
--WHERE e.LAST_NAME  LIKE IN ('%a%', '%e%')
ORDER BY e.LAST_NAME DESC; 

-- COMMISSION_PCT 가 NULL값인 직원을 조회
SELECT * FROM EMPLOYEES e WHERE e.COMMISSION_PCT IS NULL;

-- MANAGER_ID가 없는 사원들의 LAST_NAME, JOB_ID를 조회
SELECT e.LAST_NAME, e.JOB_ID FROM EMPLOYEES e WHERE e.MANAGER_ID IS NULL;

-- ST)CLERK인 직업을 가진 사원이 없는 부서 번호 조회(단, 부서번호가 널 값인 부서 제외)
SELECT DISTINCT
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	NOT e.JOB_ID = 'CLERK'
	AND e.DEPARTMENT_ID IS NOT NULL;
-- COMMISSION_PCT가 NULL이 아닌 사원들 중에서 COMMISSION=SALARY * COMMISSION_PCT를 구한다
-- 계산결과와 함께 사번, FIRST_NAME,JOB_ID를 조회
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.JOB_ID, e.SALARY * e.COMMISSION_PCT AS "COMMISSION" 
FROM EMPLOYEES e
WHERE e.COMMISSION_PCT IS NOT NULL ;



-- 성이 'Curtis' 인 사람의 성, 이름, 이메일, 폰번호, 직무 조회
-- 단 직무의 결과는 소문자로 출력한다.
SELECT e.FIRST_NAME, e.LAST_NAME, e.EMAIL, e.PHONE_NUMBER, LOWER(e.JOB_ID) AS "JOB_ID"
FROM EMPLOYEES e
WHERE e.FIRST_NAME = 'Curtis';

-- 부서번호가 60,70,80,90인 사원들의 사번, 성과 이름, 입사날짜, 직무를 조회
-- 단 직무가 it_prog인 사원의 경우 '프로그래머'로 변경하여 출력한다.
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.HIRE_DATE, REPLACE(e.JOB_ID, 'IT_PROG', '프로그래머') AS "JOB_ID"
FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID BETWEEN  60 AND 90; 

-- 직무가 AD_PRES, PU_CLERK인 사원들의 사번, 성,이름,부서번호,직무 조회
-- 단 산원명은 성과 이름을 합쳐서 출력한다(예시: Douglas Grand).
SELECT e.EMPLOYEE_ID, e.FIRST_NAME || ' ' || e.LAST_NAME AS "NAME", e.DEPARTMENT_ID, e.JOB_ID
FROM EMPLOYEES e 
WHERE e.JOB_ID IN ('AD_PRES','PU_CLERK');

-- 입사 10주년이 되는 날짜
SELECT 
e.LAST_NAME,
e.HIRE_DATE,
ADD_MONTHS(e.HIRE_DATE, 120) AS "10주년"
FROM EMPLOYEES e;

-- 회사 내 최대연봉과 최소연봉의 차이
SELECT MAX(e.SALARY) - MIN(e.SALARY) diff
FROM EMPLOYEES e; 



-- MANAGER로 근무중인 사원들의 숫자 조회
SELECT COUNT(DISTINCT(e.MANAGER_ID))
FROM EMPLOYEES e;

-- 부서별 직원수 조회(부서번호 오름차순)
-- 출력 : 부서번호, 직원수
SELECT e.DEPARTMENT_ID, COUNT(e.EMPLOYEE_ID)
FROM EMPLOYEES e
GROUP BY (e.DEPARTMENT_ID)
ORDER BY e.DEPARTMENT_ID;


-- 부서별 평균연봉 조회 (부서번호 오름차순)
-- 부서번호 평균연봉은 0의자리에서 반올림하기 (2215.45-> 2215)
SELECT
e.DEPARTMENT_ID, ROUND(AVG(e.SALARY))
FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID
ORDER BY e.DEPARTMENT_ID;


-- 동일한 직무를 가진 사원의 수 조회
-- job_id, 인원수
SELECT
e.JOB_ID, COUNT(e.EMPLOYEE_ID)"인원수"0
FROM EMPLOYEES e
GROUP BY e.JOB_ID;







-- 직원 ID가 SA_MAN인 사원들의 최대 연봉보다 높게 받는 사람들의
-- 이름, 직책, 급여 조회
-- 조건식 : 직원 ID = SA_MAN인 사원의 최대연봉보다 높아야함
SELECT
	e.LAST_NAME, e.JOB_ID, e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.SALARY > ALL(SELECT E.SALARY FROM EMPLOYEES e WHERE e.JOB_ID = 'SA_MAN');

-- 커미션을 받는 사원들의 부서와 연봉이 동일한 사원들의 
-- 이름, 부서번호, 급여 조회
-- 조건 커미션을 받는 사원들의 "부서", "연봉"이 동일한 사원들
-- 커미션이 null이 아닌 사원들의 테이블 생성
SELECT 
	e.LAST_NAME,
	e.DEPARTMENT_ID,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	(e.DEPARTMENT_ID,
	e.SALARY) IN
(
	SELECT
		e.DEPARTMENT_ID,
		e.SALARY
	FROM
		EMPLOYEES e
	WHERE
		e.COMMISSION_PCT IS NOT NULL)
;



-- 회사 전체 평균 연봉보다 더 버는 사원들 중 이름에 U가 있는 사원들이 근무하는 부서와 같은 그부서에 근무하는 사원들의
-- 사번, 이름, 급여 조회
-- 조건 : 회사 전체의 평균 연봉보다 더버는 사원들의 부서
--        AND 이름에 U가 있는 사원이 근무하는 부서의 사원들
SELECT 
	e.DEPARTMENT_ID,
	e.LAST_NAME,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID IN
	(
	SELECT DISTINCT
		e.DEPARTMENT_ID 
	FROM
		EMPLOYEES e
	WHERE
		e.SALARY > (
		SELECT
			ROUND(AVG(e.SALARY))
		FROM
			EMPLOYEES e)
		AND e.LAST_NAME LIKE '%u%');
--join 형태 : table JOIN (SUBQUERY) <별칭> 가능
SELECT 
	e.DEPARTMENT_ID,
	e.LAST_NAME,
	e.SALARY
FROM
	EMPLOYEES e JOIN (
	SELECT DISTINCT
		e.DEPARTMENT_ID 
	FROM
		EMPLOYEES e
	WHERE
		e.SALARY > (
		SELECT
			ROUND(AVG(e.SALARY))
		FROM
			EMPLOYEES e)
		AND e.LAST_NAME LIKE '%u%') d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;
-- 각 부서별 평균 연봉보다 더 받는 동일부서 사원들의 
-- 이름, 급여, 부서번호, 해당 부서의 평균연봉 조회(부서별 평균연봉을 기준으로 오름차순 정렬)
-- 조건 각 부서별 평균 연봉 < 더 받는 동일부서 사원들
-- 부서와 같은 번호 AND 해당 부서의 평균보다 높은 금액
-- 부서별 평균 연봉 테이블과 같은 부서 AND 해당 부서의 평균연봉보다 높은 금액
SELECT 
	e1.LAST_NAME,
	e1.SALARY,
	e1.DEPARTMENT_ID
FROM
	EMPLOYEES e1
JOIN (
	SELECT
		e2.DEPARTMENT_ID,
		ROUND(AVG(SALARY)) AS DEPT_SAL_AVG
	FROM
		EMPLOYEES e2
	GROUP BY
		e2.DEPARTMENT_ID
	HAVING e2.DEPARTMENT_ID IS NOT NULL) e2 ON
		e1.DEPARTMENT_ID = e2.DEPARTMENT_ID AND
	e1.SALARY > e2.DEPT_SAL_AVG;

-- 부서별 평균연봉
SELECT
	e.DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID;


-- 이름이 'Davies'인 사람보다 나중에 고용된 사원들의
-- 이름, 입사일, 조회
-- 조건 : 이름이 'Davies' AND 입사일보다 높은사람
SELECT
	e.LAST_NAME,
	e.HIRE_DATE
FROM EMPLOYEES e
WHERE 
	e.HIRE_DATE > (SELECT e.HIRE_DATE FROM EMPLOYEES e WHERE e.LAST_NAME = 'Davies');


-- 이름이 'King'인 사원을 매니저로 두고 있는 모든 사원들의
-- 이름, 급여 조회
SELECT 
	e.LAST_NAME,
	e.SALARY
FROM EMPLOYEES e
WHERE e.MANAGER_ID  IN (SELECT e.EMPLOYEE_ID FROM EMPLOYEES e WHERE e.LAST_NAME = 'King');

-- 이름이 'Hall'인 사원과 동일한 연봉 및 커미션을 받는 사원들의 
-- 이름, 부서번호, 연봉 조회
-- 단 'Hall'은 제외
SELECT
	e.LAST_NAME,
	e.DEPARTMENT_ID,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	(e.SALARY,
	NVL(e.COMMISSION_PCT, 0)) IN (
	SELECT
		e.SALARY,
		NVL(e.COMMISSION_PCT, 0)
	FROM
		EMPLOYEES e
	WHERE
		e.LAST_NAME = 'Hall')
	AND e.LAST_NAME != 'Hall';

-- 이름이 'Zlotkey'인 사원과 동일한 부서에서 근무하는 모든 사원들의
-- 사번, 고용날짜 조회
-- 단 'Zlotkey'는 제외
SELECT 
	e.DEPARTMENT_ID,
	e.HIRE_DATE
FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID = (SELECT e.DEPARTMENT_ID FROM EMPLOYEES e WHERE e.LAST_NAME = 'Zlotkey') 
AND e.LAST_NAME != 'Zlotkey';


-- 부서가 위치한 지역의 국가 ID 및 국가명을 조회한다
-- Location, contries 테이블 사용
-- EMP에 부서테이블 JOIN 하고 LOCATION 조인하고, CONTRIES 조인
SELECT * FROM LOCATIONS l ; -- LOCATION_ID별 COUNTRY_ID 존재
SELECT * FROM COUNTRIES c ; -- COUNTRY_ID별 COUNTRY_NAME 존재
SELECT * FROM EMPLOYEES e ; -- 안써도 됨
SELECT * FROM DEPARTMENTS ; -- 부서번호별 LOCATION_ID 존재

SELECT
	DISTINCT
	l.COUNTRY_ID,
	c.COUNTRY_NAME
FROM 
	DEPARTMENTS d
JOIN LOCATIONS l ON
	d.LOCATION_ID = l.LOCATION_ID
JOIN COUNTRIES c ON
	l.COUNTRY_ID = c.COUNTRY_ID;

-- 위치 id가 1700인 사원들의 연봉과 커미션을 추출한 뒤, 추출된 사원들의 연봉과 커미션이 동일한 사원정보 출력
-- 출력 : 사번, 이름(성 + 이름), 부서번호, 급여
-- LOCATION ID
SELECT
	DISTINCT
	e.EMPLOYEE_ID,
	e.FIRST_NAME || e.LAST_NAME AS name,
	e.DEPARTMENT_ID,
	e.SALARY
FROM
	EMPLOYEES e,
	DEPARTMENTS d
WHERE
	(e.SALARY,
	NVL(e.COMMISSION_PCT, 0)) IN (
	SELECT
		DISTINCT
		e.SALARY,
		NVL(e.COMMISSION_PCT, 0)
	FROM
		EMPLOYEES e
	JOIN DEPARTMENTS d ON
		e.DEPARTMENT_ID = d.DEPARTMENT_ID
		AND d.LOCATION_ID = 1700);

