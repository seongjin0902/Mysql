use shopdb;


-- ----------------
-- index
-- ----------------
-- 데이터 베이스 테이블의 검색 성능을 향상시키기 위해 사용되는 데이터 구조
-- where 이하 조건절 열에 index로 지정된 열을 사용한다
-- index열로 지정된 열은 기본적으로 정렬 처리가 된다
-- unique index(pk,unique 제약조건 시 기본설정 됨) 와 non_unique index로 나눠진다

-- mysql index 종류

-- b-tree		: 기본 값, 대부분의 데이터 index에 잘 적용되어 사용
-- hash			: 해시 함수를 이용한 index, 정확한 일치 검색에 사용
-- full-text	: 전체 텍스트 검색에 사용되는 index, 텍스트 검색 기능 향상
-- spatial		: 공간데이터(위도/경도 등)을 처리하기 위한 index, 지리 정보검색에 유리





create table test_01
(
	col1 int primary key,
    col2 int 
);
show index from test_01;

create table test_02
(
	col1 int primary key,
    col2 int unique,
    col3 int
);
show index from test_02;

-- pk 열을 기준으로 b-tree 검색 시 용이하도록 오름차순 정렬이 된다
-- unique 열은 자동정렬되는 열은 아니다

alter table test_02 drop primary key;
alter table test_02 drop constraint col2;
show index from test_02;

create table test_03
(
	col1 int primary key,
    col2 int,
    col3 int,
    index col2_3_index(col2,col3)
);
show index from test_03;
drop table test_04;

create table test_04
(
	col1 int primary key,
    col2 int,
    col3 int,
    unique index col2_3_index(col2,col3)
);
show index from test_04;

create table test_05
(
	col1 int ,
    col2 int,
    col3 int
);
show index from test_05;

create index col1_idx on test_05(col1);
create unique index col2_idx on test_05(col2);
show index from test_05;

create table test_06
(
	col1 int primary key,
    userid char(8) not null,
    constraint fk_usertbl_test_06 foreign key(userid) references usertbl(userid)
    on update cascade
    on delete cascade
);
show index from test_06;