use shopdb;

-- PK 제약조건
-- 01 테이블 생성 시 PK 설정
create table tbl_Test01
(
	id char(10) primary key,
    name char(10) not null
);
desc tbl_test01;

create table tbl_Test02
(
	id char(10),
    name char(10) not null,
    primary key(id)
);
desc tbl_test02;

create table tbl_Test03
(
	id char(10),
    name char(10) not null,
    primary key(id,name)
);
desc tbl_test03;

select * from information_schema.columns
where
table_schema='shopdb' and table_name='tbl_test03' and column_key='PRI';


-- 02 PK 설정(테이블 생성이후)
create table tbl_Test04
(
	id char(10),
    name char(10) not null
);
desc tbl_test04;

alter table tbl_test04 add constraint PK_tbl_test04 primary key(id);
desc tbl_test04;

-- 03 PK 제거
desc tbl_test01;
alter table tbl_test01 drop primary key;


-- 문제
-- 1번 buytbl을 구조+데이터 복사하고 num를 primary key로 설정

create table c_buytbl(select * from buytbl);
select * from c_buytbl;
alter table c_buytbl add constraint PK_c_buytbl primary key(num);
desc c_buytbl;

-- FK 제약조건
desc tbl_test01;
create table tbl_test01_FK
(
	no int primary key,
	id char(10) not null,
    constraint FK_test01_FK_test01 foreign key(id) references tbl_test01(id)
);

-- 옵션
-- cascade 		: pk 열의 값이 변경 시 fk 열의 값도 함께 변경
-- no action 	: pk 열의 값이 변경 시 fk 열의 값은 변경x
-- restrict 	: pk 열의 값이 변경 시 fk 열의 값의 변경 차단
-- set null 	: pk 열의 값이 변경 시 fk 열의 값을 null로 설정
-- set default 	: pk 열의 값이 변경 시 fk 열의 값을 default로 설정된 기본값을 적용

create table tbl_test02_FK
(
	no int primary key,
	id char(10) not null,
    constraint FK_test01_FK_test02 foreign key(id) references tbl_test01(id)
    on update cascade 
    on delete cascade
);


create table tbl_test03_FK
(
	no int primary key,
	id char(10),
    constraint FK_test01_FK_test03 foreign key(id) references tbl_test01(id)
    on update cascade 
    on delete set null
);

-- Mysql에서는 fk설정 시 자동으로 해당 열이 index열로 지정된다

create table tbl_test04_FK
(
	no int primary key,
	id char(10)
);
desc tbl_test04_FK;

alter table tbl_test04_FK add
constraint FK_tbl_test01_test04_FK foreign key(id) references tbl_test01(id)
on update cascade
on delete cascade;

-- 문제
-- buytbl을 copy_buytbl로 구조 + 데이터 복사 이후
-- num을 pk 설정
-- userid를 fk 설정(on delete restrict on update cacade)

create table copy_buytbl(select * from buytbl);
select * from copy_buytbl;
alter table copy_buytbl add constraint PK_copy_buytbl primary key(num);
alter table copy_buytbl add
constraint FK_buytbl_copy_buytbl_FK foreign key(userid) references usertbl(userid)
on update cascade
on delete restrict;

desc copy_buytbl;

-- (이슈) update / delete 시 옵션 적용 확인


-- FK열이 포함되어져 있는 테이블의 데이터 삭제 시 x
drop table tbl_test01_fk; -- fk열이 있는 테이블은 삭제 가능
drop table tbl_test01; 	-- pk를 다른 fk가 있는 테이블에 연결되어 있을 때는 삭제 x
desc tbl_test;
drop table tbl_test;

-- fk가 걸려있는 pk 테이블 강제 삭제
set foreign_key_checks =0;
drop table tbl_test01;
set foreign_key_checks=1;


-- --------------------------------
-- unique 제약조건(중복허용 x, null)
-- --------------------------------

-- unique 설정1
create table tbl_test05
(
	id int primary key,
	name varchar(25),
    email varchar(50) unique
);
-- unique 설정2
create table tbl_test06
(
	id int primary key,
	name varchar(25),
    email varchar(50),
    constraint uk_email unique(email)
);
-- unique 설정3
create table tbl_test07
(
	id int primary key,
	name varchar(25),
    email varchar(50)
);
alter table tbl_test07 add constraint uk_tbl_test07_email unique(email);

desc tbl_test07;

-- unique 삭제
alter table tbl_test07 drop constraint uk_tbl_test07_email;
-- 확인
show create table tbl_test07;

-- ------------------------
-- check 제약조건
-- ------------------------

create table tbl_test08
(
	id varchar(20) primary key,
    name varchar(20) not null,
    age int check(age>=10 and age<=50),				-- age는 10~50세 까지만 입력가능
    addr varchar(5),								-- addr은 서울,대구,인천만 가능하게 설정
    constraint ck_addr check(addr in('서울','대구','인천'))
);

desc tbl_test08;
show create table tbl_test08;
select * from information_schema.check_constraints;
-- check 삭제
alter table tbl_test08 drop check ck_addr;

-- ------------------------
-- default 설정
-- ------------------------
create table tbl_test09
(
	id varchar(20) primary key,
    name varchar(20) default '이름없음',
    age int check(age>=10 and age<=50) default 20,				-- age는 10~50세 까지만 입력가능
    addr varchar(5) default '인천', 								-- addr은 서울,대구,인천만 가능하게 설정
    constraint ck_addr check(addr in('서울','대구','인천'))
);
desc tbl_test09;

-- default 설정 바꾸기
alter table tbl_test09 alter column name set default '홍길동';
desc tbl_test09;

-- default 삭제
alter table tbl_test09 alter column age drop default;



