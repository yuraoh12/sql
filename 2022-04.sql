# a5 데이터베이스 삭제/생성/선택
DROP DATABASE IF EXISTS a5;
CREATE DATABASE a5;
USE a5;

# 부서(dept) 테이블 생성 및 홍보부서 기획부서 추가
CREATE TABLE dept(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL UNIQUE
);

INSERT INTO dept SET regdate = NOW(), `name` = '홍보부서';
INSERT INTO dept SET regdate = NOW(), `name` = '기획부서';

# 사원(emp) 테이블 생성 및 홍길동사원(홍보부서), 홍길순사원(홍보부서), 임꺽정사원(기획부서) 추가
CREATE TABLE emp(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` CHAR(100) NOT NULL,
    deptname CHAR(100) NOT NULL,
    regDate DATETIME NOT NULL
);

INSERT INTO emp SET `name` = '홍길동', deptname = '홍보부서', regDate = NOW();
INSERT INTO emp SET `name` = '홍길순', deptname = '홍보부서', regDate = NOW();
INSERT INTO emp SET `name` = '임꺽정', deptname = '기획부서', regDate = NOW();

# 홍보를 마케팅으로 변경
UPDATE dept SET `name` = '마케팅부서' WHERE `name` = '홍보부서';

# 마케팅을 홍보로 변경
UPDATE dept SET `name` = '홍보부서' WHERE `name` = '마케팅부서';

# 구조를 변경하기로 결정(사원 테이블에서, 이제는 부서를 이름이 아닌 번호로 기억)
ALTER TABLE emp ADD COLUMN deptno INT(10) UNSIGNED NOT NULL;

UPDATE emp SET deptno = 1 WHERE deptname = '홍보부서';
UPDATE emp SET deptno = 2 WHERE deptname = '기획부서';

ALTER TABLE emp DROP COLUMN deptname;

# 사장님께 드릴 인명록을 생성

# 사장님께서 부서번호가 아니라 부서명을 알고 싶어하신다.
# 그래서 dept 테이블 조회법을 알려드리고 혼이 났다.

# 사장님께 드릴 인명록을 생성(v2, 부서명 포함, ON 없이)
# 이상한 데이터가 생성되어서 혼남

# 사장님께 드릴 인명록을 생성(v3, 부서명 포함, 올바른 조인 룰(ON) 적용)
# 보고용으로 좀 더 편하게 보여지도록 고쳐야 한다고 지적받음

SELECT e.name, e.regDate, d.name
FROM emp e, dept d
WHERE e.deptno = d.id;

# 사장님께 드릴 인명록을 생성(v4, 사장님께서 보시기에 편한 칼럼명(AS))

SELECT e.name AS 이름, e.regDate AS 입사일, d.name AS 부서번호
FROM emp e, dept d
WHERE e.deptno = d.id;


SELECT e.name AS `이름`, e.regDate AS `입사일`, d.name AS `부서번호`
FROM emp e INNER JOIN dept d
ON e.deptno = d.id
ORDER BY `부서명`, `사원번호`;

