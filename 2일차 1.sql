create database shopdb;

use shopdb;

CREATE TABLE usertbl(  
userID CHAR(8) NOT NULL PRIMARY KEY,  
name VARCHAR(10) NOT NULL,  
birthYear INT NOT NULL,  
addr NCHAR(2) NOT NULL,  
mobile1 CHAR(3), 
mobile2 CHAR(8),  
height SMALLINT, 
mDate DATE 
);

INSERT INTO userTbl VALUES('LSG','이승기',1987,'서울','011','1111111',182,'2008-8-8');
INSERT INTO userTbl VALUES('KBS','김범수',1979,'경남','011','2222222',173,'2012-4-4');
INSERT INTO userTbl VALUES('KKH','김경호',1971,'전남','019','3333333',177,'2007-7-7');
INSERT INTO userTbl VALUES('JYP','조용필',1950,'경기','011','4444444',166,'2009-4-4');
INSERT INTO userTbl VALUES('SSK','성시경',1979,'서울',NULL,NULL,186,'2013-12-12');
INSERT INTO userTbl VALUES('LJB','임재범',1963,'서울','016','6666666',182,'2009-9-9');
INSERT INTO userTbl VALUES('YJS','윤종신',1969,'경남',NULL,NULL,170,'2005-5-5');
INSERT INTO userTbl VALUES('EJW','은지원',1972,'경북','011','8888888',174,'2014-3-3');
INSERT INTO userTbl VALUES('JKW','조관우',1965,'경기','018','9999999',172,'2010-10-10');
INSERT INTO userTbl VALUES('BBK','바비킴',1973,'서울','010','0000000',176,'2013-5-5');

-- Buytbl 만들기
CREATE TABLE buyTbl(  
num INT NOT NULL PRIMARY KEY, 
userID CHAR(8) NOT NULL,  
prodName CHAR(15) NOT NULL, 
groupName CHAR(15),  
price INT NOT NULL,  
amount SMALLINT NOT NULL,  
FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

INSERT INTO buyTbl VALUES(1,'KBS','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(2,'KBS','노트북','전자',1000,1);
INSERT INTO buyTbl VALUES(3,'JYP','모니터','전자',200,1);
INSERT INTO buyTbl VALUES(4,'BBK','모니터','전자',200,5);
INSERT INTO buyTbl VALUES(5,'KBS','청바지','의류',50,3);
INSERT INTO buyTbl VALUES(6,'BBK','메모리','전자',80,10);
INSERT INTO buyTbl VALUES(7,'SSK','책','서적',15,5);
INSERT INTO buyTbl VALUES(8,'EJW','책','서적',15,2);
INSERT INTO buyTbl VALUES(9,'EJW','청바지','의류',50,1);
INSERT INTO buyTbl VALUES(10,'BBK','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(11,'EJW','책','서적',15,1);
INSERT INTO buyTbl VALUES(12,'BBK','운동화',NULL,30,2);


-- 06 order by
select * from usertbl order by mDate;
select * from usertbl where birthYear>=1970 order by mDate asc;

select * from usertbl where birthYear>=1970 order by mDate desc;

select * from usertbl order by height,name asc;

-- 07 distinct
select distinct addr from usertbl;

-- 08 limit
select * from usertbl;
select * from usertbl limit 3; -- 0 index부터 - 3라인까지 표시
select * from usertbl limit 2,3;

-- 09 테이블복사
-- 1) 구조 + 값 복사 (pk, fk 복사x)
create table tbl_buy_copy(select * from buytbl); 
select * from buytbl;
select * from tbl_buy_copy;
desc buytbl;
desc tbl_buy_copy;  -- 키 복사는 안 됨

create table tbl_buy_copy2(select userid,prodname from buytbl); 
select * from tbl_buy_copy2;

-- 2) 구조만 복사 (oracle이랑 다름) (pk, fk 복사o)
create table tbl_buy_copy3 like buytbl;
desc tbl_buy_copy3;
select * from tbl_buy_copy3;

-- 3) 데이터만 복사
insert into tbl_buy_copy3 select * from buytbl where amount>=2;
select * from tbl_buy_copy3;

-- 문제1
-- 1
select * from buytbl order by userid;
-- 2
select * from buytbl order by price desc;
-- 3
select * from buytbl order by amount asc, prodname desc;
-- 4
select distinct prodname from buytbl order by prodname asc;
-- 5
select distinct userid from buytbl ;
-- 6
select * from buytbl where amount>=3 order by prodname desc;
-- 7
create table cusertbl (select * from usertbl where addr in ('서울','경기'));
select * from cusertbl;