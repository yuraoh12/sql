# SBS_DB
## 수업 보충 페이지 to2.kr/cZq

XAMPP -> 윈도우 개발환경 셋팅을 쉽게 해주는 툴


- cls  (정리)
- cd  (디렉토리 이동)
- mysql -u root -p (루트로 접속해서 비밀번호 입력하겠다)

### sql 기본 문법
```
# 전체 데이터베이스 리스팅
SHOW DATABASES;

# `mysql` 데이터 베이스 선택
USE mysql;

# 테이블 리스팅
SHOW TABLES;

# 특정 테이블의 구조
DESC 테이블;

# 기존에 a1 데이터베이스가 존재 한다면 삭제
DROP DATABASE IF EXISTS a1;

# 새 데이터베이스(`a1`) 생성
CREATE DATABASE a1;

# 게시물 테이블 article(title, body)을 만듭니다.
CREATE TABLE article(title VARCHAR(100), `body` TEXT)
# VARCHAR(100) => 문자 100개 저장가능
# text => 문자 많이 저장가능

# 테이블 구조 수정(id 칼럼 추가, first)
ALTER TABLE article ADD COLUMN id INT(10) FIRST;

# 날짜 칼럼 추가 => regDate DATETIME
ALTER TABLE article ADD COLUMN regDate DATETIME;

# 데이터 추가(title = 제목, body = 내용)
INSERT INTO article VALUES ('제목', '내용');
INSERT INRO article(title, `body`) VALUES ('제목', '내용');
INSERT INTO article set title = '제목', `body` = '내용';

# 데이터 조회
SELECT * FROM article;

# 기존 데이터에 id값 추가(id = 1, id IS NULL)
UPDATE article SET id = 1 WHERE id IS NULL;

# 기존 데이터 중 1개만 id를 2로 변경(LIMIT 1)
UPDATE article SET id = 2 LIMIT 1;

# 데이터 삭제 => DELETE
DELETE FROM article WHERE id = 2;

# NOW() 함수 => 현재 날짜 시간 추출
SELECT NOW();

# id 데이터는 꼭 필수 이기 때문에 NULL을 허용하지 않게 바꾼다.(alter table, not null)
ALTER TABLE article MODIFY COLUMN id INT(10) NOT NULL;
## 기존의 NULL값 때문에 경고가 뜬다.
## 기존의 NULL값이 0으로 바뀐다.

# 기본키로 지정
ALTER TABLE article ADD PRIMARY KEY(id);

# auto_increment => 자동 숫자(데이터 값에 순차적인 숫자 부여, 기본키에 자주 사용됨)
ALTER TABLE article MODIFY COLUMN id INT(10) NOT NULL AUTO_INCREMENT;
## auto_increment 를 걸기전에 해당 칼럼은 무조건 key 여야 한다.

# 테이블 클릭하고 F6 클릭하면 테이블 상세 정보 알 수 있음.
# id 칼럼에 UNSIGNED 속성을 추가
ALTER TABLE article MODIFY COLUMN id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;

# 작성자(writer) 칼럼을 title 칼럼 다음에 추가
ALTER TABLE article ADD COLUMN writer VARCHAR(100) NOT NULL AFTER title;

# 작성자(writer) 칼럼의 이름을 nickname 으로 변경해주세요.(ALTER TABLE article CHANGE oldName, newName)
ALTER TABLE article CHANGE writer nickname VARCHAR(100) NOT NULL;

# nickname 칼럼의 위치를 body 밑으로 보내주세요.(MODIFY COLUMN nickname)
ALTER TABLE article MODIFY COLUMN nickname VARCHAR(100) NOT NULL AFTER `body`;

## 데이터 수정은 CHANGE 구조 수정은 MODIFY

# hit 조회수 칼럼 삭제해주세요.
ALTER TABLE article DROP COLUMN hit;

# 조회수 가장 많은 게시물 3개만 조회.
SELECT * FROM article ORDER BY hit DESC LIMIT 3;

# 작성자명이 '홍길'로 시작하는 게시물만 조회
SELECT * FROM article WHERE nickname LIKE '홍길%';

# 조회수가 10 이상 55 이하 인것만 조회
SELECT * FROM article WHERE hit BETWEEN 10 AND 55;

# 작성자가 '무명'이 아니고 조회수가 50 이하인 것만 조회
SELECT * FROM article WHERE nickname != '무명' AND hit <= 50;

# 작성자가 '무명' 이거나 조회수가 55 이상인 게시물을 조회
SELECT * FROM article WHERE nickname = '무명' OR hit >=55;
