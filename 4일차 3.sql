use shopdb;
select userid,
sum(if(prodname='모니터',amount,0)) as '모니터',
sum(if(prodname='책',amount,0)) as '책',
sum(if(prodname='청바지',amount,0)) as '청바지',
sum(if(prodname='메모리',amount,0)) as '메모리',
sum(amount) as '합계'
from buytbl
group by userid with rollup;
select  * from buytbl;

-- 문제
-- usertbl의 지역(addr) 별 가입 인원현황을 출력
-- 서울 경기 경남 ... 총계
--  2   3  2	   10

select
sum(if(addr='서울',1,0)) as '서울',
sum(if(addr='경기',1,0)) as '경기',
sum(if(addr='경남',1,0)) as '경남',
sum(if(addr='전남',1,0)) as '전남',
sum(if(addr='경북',1,0)) as '경북',
count(addr) as '총계'
from usertbl;


select distinct addr from usertbl;
select * from usertbl;

-- 문제 2
-- buytbl에 userid의 groupname을 이용해서 userid별로 어떤 groupname을 구매했는지 피벗을 만듭니다
-- userid 전자 의류 서적 null 총계
-- BBK    2    0   0   0   2
-- EJW    0    1   2   0   3
-- ...

select userid,
sum(if(groupname='전자',1,0)) as '전자',
sum(if(groupname='의류',1,0)) as '의류',
sum(if(groupname='서적',1,0)) as '서적',
sum(if(groupname is null,1,0)) as 'null',
count(*) as '총계'
from buytbl 
group by userid with rollup;

select * from usertbl;











