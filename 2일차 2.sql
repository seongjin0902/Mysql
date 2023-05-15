-- 01 group by
use shopdb;
-- sum
select userid,sum(amount) from buytbl group by userid;
select userid,sum(amount*price) from buytbl group by userid;
select userid,sum(amount*price) as '구매총액' from buytbl group by userid;
-- avg
select userid,avg(amount) from buytbl group by userid;
-- truncate 소수점
select userid,truncate(avg(amount),2) from buytbl group by userid;

-- max(), min()
select max(height) from usertbl;
select min(height) from usertbl;

-- 가장 큰 키와 가장 작은 키를 가지는 유저의 모든 열 값을 출력
select * from usertbl where height=(select max(height) from usertbl) 
or height=(select min(height) from usertbl);

-- count()
select * from usertbl;
select count(*) from usertbl;
select count(mobile1) from usertbl;

-- 문제
use shopdb;
-- 1
select userid,sum(amount) from buytbl group by userid;
-- 2
select truncate(avg(height),2) from usertbl;
-- 3
select userid,amount from buytbl 
where amount=(select max(amount) from buytbl)
or amount=(select min(amount) from buytbl);
-- 4
select * from buytbl where groupname is null;
select * from buytbl where groupname is not null;

-- classicmodels 문제
use classicmodels;

-- 1
select truncate(avg(creditLimit),2) from customers group by city; 
-- 2
select ordernumber,sum(quantityOrdered) from orderdetails group by ordernumber;
-- 3
select productvendor,sum(quantityInStock) from products group by productvendor;

-- 02 group by + having

-- buytbl에서 userid별로 amount의 총 합
select userid,sum(amount) as '총량' from buytbl group by userid 
having sum(amount>=5);

select groupname, sum(amount) from buytbl group by groupname
having sum(amount>=5);

select addr,avg(height) from usertbl group by addr
having avg(height)>=175;

-- 03 rollup
select num,groupname,sum(price*amount) from buytbl
group by groupname,num with rollup;

select userid,addr,avg(height) from usertbl
group by addr,userid
with rollup;

select groupname,sum(price*amount) from buytbl
group by groupname with rollup;

-- 문제

-- 1
select userid,prodname,sum(price*amount) from buytbl
group by prodname,userid;
-- 2
select userid,prodname,sum(price*amount) from buytbl
group by prodname,userid having sum(price*amount)>=1000;
-- 3
select distinct userid, prodname,price from buytbl
where price=(select max(price) from buytbl) or
price=(select min(price) from buytbl);
-- 4
select * from buytbl where groupname is not null;
-- 5
select prodname,sum(price*amount) as '총합' from buytbl
group by prodname with rollup;
select num,prodname,sum(price*amount) as '총합' from buytbl
group by prodname,num with rollup;