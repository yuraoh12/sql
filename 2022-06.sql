
# 데이터베이스 a4가 존재하면 삭제
DROP DATABASE IF EXISTS a4;

# 데이터베이스 a4 생성
CREATE DATABASE a4;

# 데이터베이스 a4 선택
USE a4;

# 회원 테이블 생성, loginId, loginPw, `name`
## 조건 : loginId 칼럼에 UNIQUE INDEX 없이
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    loginId CHAR(50) NOT NULL,
    loginPw VARCHAR(100) NOT NULL,
    `name` CHAR(100) NOT NULL
);

# 회원 2명 생성
## 조건 : (loginId = 'user1', loginPw = 'user1', `name` = '홍길동')
## 조건 : (loginId = 'user2', loginPw = 'user2', `name` = '홍길순')
INSERT INTO `member`
SET regDate = NOW(),
loginId = 'user1',
loginPw = 'user1',
`name` = '홍길동';

INSERT INTO `member`
SET regDate = NOW(),
loginId = 'user2',
loginPw = 'user2',
`name` = '홍길순';

# 회원 2배 증가 쿼리만들고 회원이 백만명 넘을 때 까지 반복 실행
## 힌트1 : INSERT INTO `tableName` (col1, col2, col3, col4)
## 힌트2 : SELECT NOW(), UUID(), 'pw', '아무개'

INSERT INTO `member` (regDate, loginId, loginPw, `name`)
SELECT NOW(), UUID(), 'pw', '아무개'
FROM `member`;

# 회원수 확인
SELECT COUNT(*)
FROM `member`;

# 검색속도 확인
## 힌트 : SQL_NO_CACHE
SELECT SQL_NO_CACHE *
FROM `member`
WHERE loginId = 'user1';

# 유니크 인덱스를 loginID 칼럼에 걸기
## 설명 : mysql이 loginId의 고속검색을 위한 부가데이터를 자동으로 관리(생성/수정/삭제) 한다.
## 설명 : 이게 있고 없고가, 특정 상황에서 어마어마한 성능차이를 가져온다.
## 설명 : 생성된 인덱스의 이름은 기본적으로 칼럼명과 같다.
ALTER TABLE `member` ADD UNIQUE INDEX (`loginId`); 

# 검색속도 확인, loginId 가 'user1' 인 회원 검색
SELECT SQL_NO_CACHE *
FROM `member`
WHERE loginId = 'user1';

# 인덱스 삭제, `loginId` 이라는 이름의 인덱스 삭제
ALTER TABLE `member` DROP INDEX `loginId`;

# 회원 테이블 삭제
DROP TABLE `member`;

# 회원 테이블을 생성하는데, loginId에 uniqueIndex 까지 걸어주세요.
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    loginId CHAR(50) UNIQUE NOT NULL,
    loginPw VARCHAR(100) NOT NULL,
    `name` CHAR(100) NOT NULL
);

# 회원 2명 생성
## 조건 : (loginId = 'user1', loginPw = 'user1', `name` = '홍길동')
## 조건 : (loginId = 'user2', loginPw = 'user2', `name` = '홍길순')
INSERT INTO `member`
SET regDate = NOW(),
loginId = 'user1',
loginPw = 'user1',
`name` = '홍길동';

INSERT INTO `member`
SET regDate = NOW(),
loginId = 'user2',
loginPw = 'user2',
`name` = '홍길순';

# 회원수 확인
SELECT COUNT(*) FROM `member`;

# 인덱스 쓰는지 확인
## 힌트 : EXPLAIN SELECT SQL_NO_CACHE * ~
EXPLAIN SELECT SQL_NO_CACHE *
FROM `member`
WHERE loginId = 'user1';

# 게시물 테이블 생성(title, body, writerName, memberId)
CREATE TABLE `article` (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    title CHAR(200) NOT NULL,
    `body` TEXT NOT NULL,
    `writerName` CHAR(100) NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL
);

# 1번 회원이 글 1 작성(title = '글 1 제목', `body` = '글 1 내용')
INSERT INTO article
SET regDate = NOW(),
title = '글 1 제목',
`body` = '글 1 내용',
writerName = '홍길동',
memberId = 1;

# 2번 회원이 글 2 작성(title = '글 2 제목', `body` = '글 2 내용')
INSERT INTO article
SET regDate = NOW(),
title = '글 2 제목',
`body` = '글 2 내용',
writerName = '홍길순',
memberId = 2;

# 1번 회원이 글 3 작성(title = '글 3 제목', `body` = '글 3 내용')
INSERT INTO article
SET regDate = NOW(),
title = '글 3 제목',
`body` = '글 3 내용',
writerName = '홍길동',
memberId = 1;

# 전체글 조회
SELECT *
FROM article;

# 1번회원의 이름변경 홍길동 => 홍길동2
UPDATE `member`
SET `name` = '홍길동2'
WHERE id = 1;

# 전체글 조회, 여전히 게시물 테이블에는 이전 이름이 남아 있음
SELECT *
FROM article;

# 게시물 테이블에서 writerName 삭제
ALTER TABLE article DROP COLUMN writerName;

# INNER JOIN 을 통해서 두 테이블을 조회한 결과를 합침, ON 없이
SELECT * FROM article
INNER JOIN `member`;

# INNER JOIN 을 통해서 두 테이블을 조회한 결과를 합침, 올바른 조인 조건

## 힌트 : 이걸로 조인조건을 걸 칼럼 조사
## SELECT article.id, article.memberId, member.id AS "회원테이블_번호"
## FROM article
## INNER JOIN `member`;

# 조인 완성, ON 까지 추가
SELECT A.*, M.name AS writerName
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id;
