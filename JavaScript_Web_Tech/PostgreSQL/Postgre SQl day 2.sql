select * from employee;
---------------grouping and group function
select sum(salary) as TotalSalary,
 avg(salary) as Avgsalary,
 max(salary) as MaxSalary,
 min(salary) as MinSalary,
 count(salary) as NoOfEmps
from employee

-------Note: in GROUP BY query, we can only use either group funtion
-- and/or group column, other than this column it is not allowed
--Group function i
select sum(salary) as TotalSalary,
 avg(salary) as Avgsalary,
 max(salary) as MaxSalary,
 min(salary) as MinSalary,
 count(coalesce (salary,0)) as NoOfEmps
from employee
where depid>201 --->0
group by depid --->1
having avg(coalesce(salary,0)) > 4000 --->3
order by avg(coalesce(salary,0)) desc;
----------------------
select ecode,coalesce(salary,0) as salary from employee;
---Note: coalesce(expr1,expr2) will return first NOT NULL values
--From the list. This can be used in group function to
--include the null records if needed as group functions
---ignore the null values,
------------------operators----------------
+,-,*,/,<,>,<=,>=,!=
---------String patterns----------
like--
% for multiple character
---underscore(_) for single character
--find the employee whose name starts with 'N'
select name from employee where name like 'n%'
------find employee whose name starts with 'R' having total 4
select * from employee where name like 's%'
------working with date and data-type ---------------
select now()---1)displaty current date time
create table orders(
order_id serial primary key,
order_date date,
quantity int
);
insert into orders (order_date,quantity) values (now(),5000)
insert into orders(order_date,quantity) values ('2025-01-15',3000)
select * from orders
--2) AGE() calculate the difference between two dates
select AGE(now(),'2025-01-10') as age_diff
--3)EXTRACT() used for extracting parts of the date
--like year, month,day 
select extract(year from now()) as year
--4) TO_CHAR() used  for formatting the date and time output
select to_char(now(),'DD/MON/YYYY') AS DATE
-------WORKING WITH BOOLEAN TYPE------------
--USED FOR FLAG OR STATUS VALUE WHICH ACEPTS TRUE,FALSE AND NULL
---IT ALSO SUPPORT OTHER LITERALS LIKE
--TRUE/FALSE
--'t'/'f'
--'yes'/'no'
--'y'/'n'
--1/2
drop table test
create table test(
id int,
availabe boolean
)
insert into test values(1,True);
insert into test values(2,true);
insert into test values(3,'t');
insert into test values(4,'y');
insert into test values(5,'yes');

select * from test
--------NUMERIC DATA-TYPE-------
NUMERIC(precision,scale)
e.g. NUMERIC(5,2)------3 precision and 2 scale
123.01
create table tests(
id int,
price numeric(5,2)
)
insert into tests values(3,123.04)
select * from tests
-------Time formats---------
create table testing(
id int,
time_val time)
insert into testing values(1,now())
insert into testing values(2,'01:21')
select * from testing
---------json data type------
create table tet(
id serial primary key,
info json
)
insert into tet(info) values(
'{ "customer":"srikanth", 
"item": { "product":"tea","qty":5} }'
);
select info->>'item' from tet
select * from tet
select info->'item'
from tet
where info->'item'->>'product'='tea'
-----------WORKING WITH CONSTRAINTS---------------------
--CONSTRAINTS : To specify some rules and restrictions
--on data to maintain the integrity or correctiness of data
--in database at my any point of time.
--1) PRIMARY KEY: It maintains unique records in the table and 
--duplicate records cannot be inserted in table
--it doesn't allow NULL value in the column
--only one primary key per table.
create table employee(
ecode int primary key,
ename varchar(23)
)
--2)CHECK: It accepts only the values allowed as per
--the expression provided in the check constraint.
create table emptest(
ecode int primary key,
ename varchar(20),
salary int check(salary>10000 and salary<=50000),
gender char(1) check(gender='M' or gender='F')
)
insert into emptest values(1,'ravi',50000,'M')
select * from emptest
--3) DEFAULT contraint: it takes default specified value if
--it is not  proviided
create table teet(
ecode int,
salary int default 5000,
gender char(1) default 'M',
)
select * from teet;
---------4) UNIQUE constraints: it maintains unique values in a column
--there an be more than one unique constrains
create table tom (
ecode int primary key,
ename varchar(20) not null,
emailid varchar(20) unique,
mobile varchar(10) unique
)
insert into tom values (101,'ravi','rav@gmail.com',234545455)
insert into tom values (102,'kramma','ram@gmailcom',24352345)
select * from tom
-----------------------
--5)Not NUll: it makes the column mandatory, does'nt accept null value
--5)Foreign key: it is called refrential integrity constraint
--it accept only those  values which
create table dept(
deptid int primary key,
dname varchar(20),
dhead int
)
create table emp(
ecode int primary key,
ename varchar(20),
salary int,
deptid int references dept(deptid)
)
insert into dept values(201,'account',100);
insert into dept values(301,'ravi',200)
select * from dept;
select * from emp;
---------
--Rules:
--INSERT RULE: we cannot insert in the department table
--if the key data is not present in the main table
--DELETE RULE: we cannot delete the record form main table
--if there are dependent record present  somewhere.
--on delete(ascade).this clause make sure that when the main key 
--record is delete al its dependent records will also get deleted.
----------------------------
--altering the table--
--1) Adding the New column:
alter table emp add column city varchar(10)
--2) Remove the column
alter table emp drop column city;
--3) Rename the column
alter table emp rename column empname to ename
select * from emp
--4) adding primary key
alter table emp add constraints pk1 primary key(ecode)
--5) adding foreign key
alter table emp add constraints fk1 foreign key(deptid)
references dept(deptid)
--6) renaming the table
alter table emp rename to tbl_employee