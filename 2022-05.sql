# a6 DB 삭제/생성/선택
DROP DATABASE IF EXISTS a6;
CREATE DATABASE a6;
USE a6;

# 부서(홍보, 기획)
CREATE TABLE dept(
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  regDate DATETIME NOT NULL,
  `name` CHAR(100) NOT NULL 
);

INSERT INTO dept SET regDate = NOW(), `name` = '홍보';
INSERT INTO dept SET regDate = NOW(), `name` = '기획';

# 사원(홍길동/홍보/5000만원, 홍길순/홍보/6000만원, 임꺽정/기획/4000만원)
CREATE TABLE emp(
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  regDate DATETIME NOT NULL,
  `name` CHAR(100) NOT NULL,
  deptId INT(10) NOT NULL,
  sal INT(50) NOT NULL
);

INSERT INTO emp SET regDate = NOW(), `name` = '홍길동', deptId = 1, sal = 5000;
INSERT INTO emp SET regDate = NOW(), `name` = '홍길순', deptId = 1, sal = 6000;
INSERT INTO emp SET regDate = NOW(), `name` = '임꺽정', deptId = 2, sal = 4000;

# 사원 수 출력
SELECT COUNT(*)
FROM emp;

# 가장 큰 사원 번호 출력
SELECT MAX(id)
FROM emp;

# 가장 고액 연봉
SELECT MAX(sal)
FROM emp;

# 가장 저액 연봉
SELECT MIN(sal)
FROM emp;

# 회사에서 1년 고정 지출(인건비)
SELECT SUM(sal)
FROM emp;

# 부서별, 1년 고정 지출(인건비)
SELECT deptId, SUM(sal)
FROM emp
GROUP BY deptId;

# 부서별, 최고연봉
SELECT deptId, MAX(sal)
FROM emp
GROUP BY deptId;

# 부서별, 최저연봉
SELECT deptId, MIN(sal)
FROM emp
GROUP BY deptId;

# 부서별, 평균연봉
SELECT deptId, AVG(sal)
FROM emp
GROUP BY deptId;

# 부서별, 부서명, 사원리스트, 평균연봉, 최고연봉, 최소연봉, 사원수 
## V1(조인 안한 버전)
SELECT e.deptId AS '부서번호',
GROUP_CONCAT(e.name) AS '사원리스트',
TRUNCATE(AVG(e.sal),0) AS '평균연봉',
MAX(e.sal) AS '최고연봉',
MIN(e.sal) AS '최소연봉',
COUNT(*) AS '사원수'
FROM emp AS e
GROUP BY e.deptId;

## V2(조인해서 부서명까지 나오는 버전)
SELECT d.name AS '부서명',
GROUP_CONCAT(e.name) AS '사원리스트',
TRUNCATE(AVG(e.sal),0) AS '평균연봉',
MAX(e.sal) AS '최고연봉',
MIN(e.sal) AS '최소연봉',
COUNT(*) AS '사원수'
FROM emp AS e INNER JOIN dept AS d
ON e.deptId = d.id
GROUP BY e.deptId;

## V3(V2에서 평균연봉이 5000이상인 부서로 추리기)
SELECT d.name AS '부서명',
GROUP_CONCAT(e.name) AS '사원리스트',
TRUNCATE(AVG(e.sal),0) AS '평균연봉',
MAX(e.sal) AS '최고연봉',
MIN(e.sal) AS '최소연봉',
COUNT(*) AS '사원수'
FROM emp AS e INNER JOIN dept AS d
ON e.deptId = d.id
GROUP BY e.deptId
HAVING AVG(e.sal) >= 5000;

## V4(V3에서 HAVING 없이 서브쿼리로 수행)
SELECT *
FROM (
    SELECT d.name AS '부서명',
    GROUP_CONCAT(e.name) AS '사원리스트',
    TRUNCATE(AVG(e.sal),0) AS '평균연봉',
    MAX(e.sal) AS '최고연봉',
    MIN(e.sal) AS '최소연봉',
    COUNT(*) AS '사원수'
    FROM emp AS e INNER JOIN dept AS d
    ON e.deptId = d.id
    GROUP BY e.deptId
)AS D
WHERE D.'평균연봉' >= 5000;

### HINT, UNION을 이용한 서브쿼리
# SELECT *
# FROM (
#     select 1 AS id
#     union
#     select 2
#     UNION
#     select 3
# ) AS A

