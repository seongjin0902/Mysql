use shopdb;
-- 01 after trigger

select * from usertbl;
create table c_usertbl select * from usertbl;
select * from c_usertbl;
create table c_usertbl_bak like c_usertbl;
select * from c_usertbl_bak;
alter table c_usertbl_bak add column type char(5);
alter table c_usertbl_bak add column u_d_date char(5);
alter table c_usertbl_bak change column u_d_date u_d_date datetime;
select * from c_usertbl_bak;

delimiter //
create trigger trg_c_usertbl_update
after update 
on c_usertbl
for each row
begin
	insert into c_usertbl_bak values(
    old.userid,old.name,old.birthyear,old.addr,old.mobile1,old.mobile2,old.height,old.mdate,'수정',now());
end $$
delimiter ;

show triggers;

select * from usertbl;
create table c_usertbl select * from usertbl;
select * from c_usertbl;
create table c_usertbl_bak like c_usertbl;
select * from c_usertbl_bak;
alter table c_usertbl_bak add column type char(5);
alter table c_usertbl_bak add column u_d_date char(5);
alter table c_usertbl_bak change column u_d_date u_d_date datetime;
select * from c_usertbl_bak;

delimiter //
create trigger trg_c_usertbl_update
after update 
on c_usertbl
for each row
begin
	insert into c_usertbl_bak values(
    old.userid,old.name,old.birthyear,old.addr,old.mobile1,old.mobile2,old.height,old.mdate,'수정',now());
end $$
delimiter ;







































