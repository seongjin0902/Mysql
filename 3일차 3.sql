create table tbl_test
(
	no int primary key,
    name varchar(20),
    age int,
    gender char(1)
);

delete from tbl_test;
insert into tbl_test values(1,'aa',66,'W'); -- commit;
insert into tbl_test values(2,'aa',66,'W'); -- commit;
insert into tbl_test values(3,'aa',66,'W'); -- commit;
select * from tbl_test;
commit;

start transaction;
	insert into tbl_test values(4,'aa',66,'W');
	insert into tbl_test values(5,'aa',66,'W');
	insert into tbl_test values(6,'aa',66,'W');
rollback; -- start transaction 앞으로 돌아감

start transaction;
	savepoint s1;
	insert into tbl_test values(4,'aa',66,'W');
	insert into tbl_test values(5,'aa',66,'W');
	insert into tbl_test values(6,'aa',66,'W');
    rollback to s1; -- s1 이전으로 돌아감
    savepoint s2;
	insert into tbl_test values(7,'aa',66,'W');
	insert into tbl_test values(8,'aa',66,'W');
	savepoint s3;
	insert into tbl_test values(9,'aa',66,'W');
	insert into tbl_test values(10,'aa',66,'W');
    rollback to s3; -- s3 이전 savapoint로 돌아감
    rollback to s2; -- s2 이전 savepoint로 돌아감
    
select * from tbl_test;
    