use shopdb;
-- 01
delimiter $$
create procedure proc1()
begin
	-- 변수 선언
    declare var1 int;
    set var1 = 100;
    if var1=100 then
		select 'var1은 100입니다.';
	else
		select 'var1은 100이 아닙니다.';
	end if;
end $$
delimiter ;

show procedure status; -- procedure 목록 확인
show create procedure proc1; -- proc1 확인

call proc1();

-- 02
delimiter $$
create procedure proc2(in param int) -- 외부
begin
	if param=100 then
		select 'param은 100입니다.';
	else
		select 'param은 100이 아닙니다.';
	end if;
end $$
delimiter ;

call proc2(100);

-- 03
delimiter $$
create procedure proc3(in amt int) -- 외부
begin
	select * from buytbl where amount >= amt;
end $$
delimiter ;

call proc3(5);

-- 04
delimiter $$
create procedure proc4()
begin
	declare avg_amount int;
    set avg_amount=(select avg(amount) from buytbl);
	select *, if(amount>=avg_amount,'평균이상','평균이하') as '구매평균' from buytbl;
end $$
delimiter ;

call proc4();

-- usertbl에서 출생년도를 입력받아 해당 출생년도보다 나이가 많은 행만 출력
-- birthyear 열을 이용
-- 프로시저명 : older(in param int)

delimiter $
create procedure older(in param int)
begin
	select * from usertbl where param > birthyear;
end $$
delimiter ;

call older(1970);

-- 가입일로부터 지난 날짜 확인
select curdate();  -- 현재 날짜(yyyy-mm-dd)
select now(); -- 현재 날짜 시분초
select curtime(); -- 현재 시간
select *,ceil(datediff(curdate(),mdate)/365) from usertbl;

-- 가입한 지 12년이 초과한 user는 삭제 대상
select *,if(ceil(datediff(curdate(),mdate)/365)>12,'삭제','유지') from usertbl;

create table c_usertbl(select * from usertbl);
select * from c_usertbl;

delimiter $
create procedure delete_user(in del int)
begin
	select * from c_usertbl where ceil(datediff(curdate(),mdate)/365)>del;
	delete from u_usertbl where ceil(datediff(curdate(),mdate)/365) > del;
end $$
delimiter ;

call delete_user(12);
select * from c_usertbl;

-- 만 나이 계산('yyyy-mm-dd')
select *, date(concat(birthyear,'-01-01')) from usertbl;
select *,to_days(date(concat(birthyear,'01-01'))) from usertbl;
select *,
ceil((to_days(curdate()) - to_days(date(concat(birthyear,'-01-01'))))/365) 
as '나이(만)' from usertbl;

-- 07 나이 계산하기
-- ceil : 올림 , round : 반올림 , floor : 내림처리
delimiter $
create procedure add_age()
begin
	select U.userid,name,birthyear,prodname,price*amount,
    floor((to_days(curdate()) - to_days(date(concat(birthyear,'-01-01'))))/365) as '나이'
	from usertbl U
	inner join buytbl B
	on U.userid=B.userid;
end $$
delimiter ;

call add_age();
-- 08 두개 인자 받기
delimiter $$
create procedure proc08(in b int,in h int)
begin
	select * from usertbl where birthyear>=b and height>=h;
end $$;
delimiter ;  
call proc08(1975,170);

select * from buytbl;

delimiter $$
create procedure proc09(in n1 int, in n2 int, in n3 int)
begin
		select *,
	case
		when amount>=n1 then 'VIP'
		when amount>=n2 then '우수고객'
		when amount>=n3 then '일반고객'
		else '구매없음'
	end as 'Grade'
	from buytbl;
    
end $$;
delimiter ;
call proc09(10,7,5);

-- -------------------------------------------- 
delimiter $$
create procedure while01()
begin
	-- 탈출/조건 식에 사용되는 변수 선언&초기값 설정
	declare i int;
    set i=1;
    -- 반복에 사용되는 조건식(i<=10) 지정
	while i<=10 do
		select 'hello world';
        set i=i+1;  -- 반복문을 벗어나기 위한 연산처리
	end while;
end $$;
delimiter ;

call while01();

-- while 02
create table tbl_googoodan(dan int,i int, result int);
delimiter $$
create procedure while02()
begin
	declare dan int;
    declare i int;
    set dan=2;
    set i=1;
    while i<10 do
		insert into tbl_googoodan values(dan,i,dan*i);
		set i=i+1;
    end while;
end $$
delimiter ;

call while02();
select * from tbl_googoodan;

-- 03 while
delimiter $$
create procedure while03(in d int)
begin
    declare i int;
    set i=1;
    insert into tbl_googoodan(dan) values(d);
    while i<10 do
		insert into tbl_googoodan values(d,i,d*i);
		set i=i+1;
    end while;
end $$
delimiter ;

delete from tbl_googoodan;
call while03(9);

select * from tbl_googoodan;

-- 2단~9단까지 저장
-- 오름차순 구구단 or 내림차순 구구단







