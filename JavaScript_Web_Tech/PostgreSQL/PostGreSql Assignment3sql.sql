create table student(
FName varchar(24) unique,
LName varchar(23) unique,
Age int unique
)
insert into student values ('Susan','Yao',18),('Ramesh','Arvind',20),
('Joseph','Antony',19),('Jennifer','Amy',30),
('andy','perumal',21)
select * from student
drop table student
create table Teacher(
FName varchar(23) unique,
LName varchar(23) unique,
Age int unique
)
drop table teacher
insert into teacher values ('Jennifer','Amy',30),
('Nanda','sham',40),('Ramesh','Arvind',20)
select * from teacher
-----------------
select s.FName, s.LName from student s
join teacher t on 
lower(s.FName)=lower(t.FName) and lower(s.LName)=lower(t.LName)
----------------------
select s.FName,s.LName from student s
left join teacher t on
s.FName = t.FName and s.LName = t.LName
where t.FName is null and t.LName is null
---------------------------
select t.FName,t.LName from teacher t
 left join student s on
s.FName = t.FName and s.LName = t.LName
where s.FName is null and s.LName is null
-----------------------------
drop table Purchases;
create table Purchases(
cust_id int references customers(cust_id),
amount int
)
insert into Purchases values(1,100),
(3,50),(1,200),
(1,500),(3,20);
create table customers(
cust_id int primary key,
name varchar(23)
)
insert into customers values(1,'Adam'),
(2,'Bob'),(3,'Cathy')
---
select * from Purchases;
select * from customers;
select p.cust_id,sum(p.amount) as total_amount
from purchases p 
join customers c
on c.cust_id=p.cust_id
-------------
select c.cust_id,coalesce(sum(amount),0) as total_amount
from Purchases p 
right outer join customers c
on c.cust_id=p.cust_id
group by c.cust_id