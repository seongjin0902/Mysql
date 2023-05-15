use shopdb;

create table tbl_copy_buytbl(select * from buytbl);

select * from tbl_copy_buytbl;
desc tbl_copy_buytbl;
delete from tbl_copy_buytbl where num>=5;
-- 01 insert value값 여러 개 넣기
insert into tbl_copy_buytbl(num,userid,prodname,groupname,price,amount)
values
(9,'aaa','운동화','의류',1000,1),
(10,'aaa','운동화','의류',1000,1),
(11,'aaa','운동화','의류',1000,1),
(12,'aaa','운동화','의류',1000,1);
select * from tbl_copy_buytbl;


-- 02 insert 시 auto_increment
create table tbl_test
(id int primary key auto_increment,
name varchar(20),
addr varchar(100));
desc tbl_test;
insert into tbl_test(id,name,addr) values(null,'홍길동','대구');
select * from tbl_test;

delete from tbl_test;

-- auto_increment 초기화
alter table tbl_test auto_increment=0;
commit;
insert into tbl_test(id,name,addr) values(null,'홍길동','대구');
select * from tbl_test;

-- 


