create table tbl_test
(
	no int primary key,
    name varchar(20),
    age int,
    gender char(1)
);

delimiter $$
create procedure tx_test()
begin
	declare continue handler for sqlexception
    begin
		show errors;
    end;
    insert into tbl_test values(5,'aa',66,'W');
    insert into tbl_test values(7,'aa',66,'W');
    insert into tbl_test values(8,'aa',66,'W');
end $$
delimiter ;
call tx_text();
show procedure status;