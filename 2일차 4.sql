-- ignore 에러 건너뛰고 실행

desc tbl_test;

select * from tbl_test;

insert ignore into tbl_test values(9,'홍길동','대구');
insert into tbl_test values(11,'홍길동','대구');
insert into tbl_test values(12,'홍길동','대구');
