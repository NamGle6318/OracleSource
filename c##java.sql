-- DB 설계
-- Board 테이블 작성
CREATE TABLE board(
bno NUMBER(8) PRIMARY KEY,
title VARCHAR(100) NOT NULL,
content VARCHAR(2000) NOT NULL,
writer VARCHAR(50) NOT NULL,
regidate DATE DEFAULT SYSDATE
);

drop TABLE board;
DROP TABLE STUDENTTBL;
SELECT * FROM board;

CREATE SEQUENCE board_seq;
DROP SEQUENCE BOARD_SEQ;

INSERT INTO board(bno, title, content, writer)
VALUES (board_seq.nextval, 'title1', 'content1', 'user1');

 select * from dba_ts_quotas;

SELECT * FROM user_ts_quotas;

SELECT * FROM STUDENTTBL;
INSERT INTO STUDENTTBL(name) values('홍길동');
INSERT INTO STUDENTTBL(name) values('성춘향');
INSERT INTO STUDENTTBL(id, name) values(student_seq.nextval, '성춘향');