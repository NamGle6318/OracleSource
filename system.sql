-- 오라클 관리자 접근방법
-- system, sys(최고권한)
-- 사용자 이름 : sys as sysdba 
-- 비밀번호 : 엔터

-- 오라클 12c 버전부터 사용자계정 생성시 접두어(c##)를 요구함
-- c##hr
-- c##을 사용하지 않을경우 아래 명령어 실행
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 비밀번호 변경시
-- 비밀번호만 대소문자를 구별함
ALTER USER hr IDENTIFIED BY hr;

-- 계정 잠금 해제(hr)
ALTER USER hr account unlock;

-- 데이터사전 DBA_USERS를 사용하여 사용자 정보 조회
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';

-- SCOTT -> VIEW 생성 권한 부여 (GRANT)
	-- GRANT 부여할 권한 TO USERNAME
GRANT CREATE VIEW TO SCOTT;

-- 사용자 관리 
	-- 오라클은 테이블, 인덱스, 뷰 등 사용자별로 여러 객체를 생성하므로 
    -- 업무별 사용자를 생성한 후에 각 사용자 업무에 맞는 데이터 구조를 만들어 관리하는 방식 사용

-- 데이터베이스 스키마 : 사용자
	-- 스키마 : 데이터베이스에서 데이터 간 관계, 데이터 구조, 제약 조건 등 데이터를 저장하고 관리하고자 정의한
    --			데이터베이스 구조 범위
	-- 오라클 데이터베이스에서는 스키마 = 사용자

-- xe - hr, sctt ...

-- 사용자 생성 구문
	-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호;

	-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호;
	-- DEFAULT TABLESPACE 테이블스페이스명 -> USERS(정해진 이름이 있음)
	-- TEMPORARY TABLESPACE 테이블스페이스그룹명 -> 임시 공간
	-- QUOTA 테이블스페이스 크기 ON 테이블스페이스명 -> MB ON USERS

-- 1. 사용자 생성
CREATE USER C##java IDENTIFIED BY 12345;
ALTER USER C##JAVA
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP  
QUOTA 10m ON USERS;

-- 2. 권한 부여(GRANT)
	-- GRANT 권한 ON 테이블명 TO 테이블스페이스명;
	-- GRANT SELECT, INSERT, DELETE ON BOARD TO c##TEST1; -> BOARD 테이블의 S,I,D 권한 부여
	-- 롤 : 여러개의 권한이 묶여서 정의되어 있음

GRANT CONNECT, RESOURCE TO C##JAVA; 

--  ORA-65096: 공통 사용자 또는 롤 이름이 부적합합니다. 
CREATE USER TEST2 IDENTIFIED BY 12345; --> 사용자이름에 c##을 붙히지 않음

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; --> c## 안붙히겠다고 선언하는 명령어
CREATE USER TEST2 IDENTIFIED BY 12345;

-- 사용자 정보 조회
SELECT * FROM ALL_USERS
WHERE USERNAME = 'C##TEST1';

-- TEST1의 비밀번호 변경하기
ALTER USER C##TEST1 IDENTIFIED BY 54321; --> 실행장소가 system(관리자)라서 가능

-- 사용자 제거하기
DROP USER c##TEST1; --> ORA-01940: 현재 접속되어 있는 사용자는 삭제할 수 없습니다

DROP USER c##TEST1; --> ORA-01922: 'C##TEST1'(을)를 삭제하려면 CASCADE를 지정하여야 합니다
--> 사용자 스키마에 객체가 존재한다면 CASCADE옵션 사용해서 제거 ()

DROP USER c##TEST1 CASCADE; --> 성공!

grant resource to C##JAVA; 

ALTER USER USERS QUOTA 100M ON ts_name;

