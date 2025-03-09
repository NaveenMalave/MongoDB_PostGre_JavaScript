use empdb;

--creating table
create table employee
(
	ecode int primary key,
	ename varchar(25),
	salary int,
	deptid int
)


select * from employee

--adding records
insert into employee values(101,'Ravi',1111,201);
insert into employee values(102,'John',2222,202);
insert into employee values(103,'Tom',3333,203);
insert into employee values(104,'David',4444,203);
insert into employee values(105,'Shyam',5555,202);

select * from employee;

--adding multiple records with single INSERT statement
insert into employee values(106,'Suresh',6666,201),
							(107,'Iyan',7777,202);

--deleting records
--a) deleting selected records
delete from employee where ecode=105

--b) unconditional delete (be sure as it deleted all the data)
delete from employee   --can be rolled back, i.e. soft delete

--truncate 
truncate employee  -- hard delete , cannot be rolled back

--drop table employee   : it drops data along with structure also

--updating records
--a) conditional update
UPDATE employee SET salary=salary + 1000 WHERE ecode=101
--b) unconditional update
UPDATE employee SET salary=salary + 1000

--updating more than one column values
UPDATE employee SET salary=50000,deptid=206 WHERE ecode=101

--insert only few column values
insert into employee(ecode,ename) values(105,'Ramnath')

--displaying computed values like bonus of a salary
select ecode,ename,salary,deptid,salary*0.1 as Bonus from employee

--sorting the records
select * from employee order by salary desc

--select records with null column
select * from employee where salary is not null


select * from employee


--
select * 
from employee 
order by salary,ecode desc

---grouping and group functions
select sum(salary) as TotalSalary,
avg(nullif(salary,0)) as AvgSalary,
max(salary) as MaxSalary,
min(salary) as MinSalary,
count(nullif(salary,0)) as NoOfEmps
from employee

select sum(salary) as TotalSalary,
avg(salary) as AvgSalary,
max(salary) as MaxSalary,
min(salary) as MinSalary,
count(salary) as NoOfEmps
from employee

--group by 
select deptid,sum(salary) as TotalSalary,
avg(coalesce(salary,0)) as AvgSalary,
max(salary) as MaxSalary,
min(salary) as MinSalary, ---2
count(coalesce(salary,0)) as NoOfEmps
from employee
where deptid>201 ---0
group by deptid    ---1
having avg(coalesce(salary,0))>4000  ---3
order by avg(coalesce(salary,0)) desc ---4

--Note: in GROUP BY query , we can only use either group functions 
--and/or group column. other than this column it is not allowed
--group functions i


select ecode,coalesce(salary,0) as salary from employee
--Note: coalesce(expr1,expr2) will return first NOT NULL value
--from the list. This can be used in group functions to 
--include the null records if needed as group functions
--ignores the null values. for e.g. count() and avg() may
--affect the result due null values


--Operators
+,-,*,/,<,>,<=,>=,!=

--string pattern matching
lIKE ---- 
%  for multiple charcter
-- underscore(_) for single character

--find the employees whose name starts with 'R'
select * from employee where ename like 'R%'

--find the employees whose name starts with 'R' having total 4 characters 
select * from employee where ename like 'R___'

--find the employees whose name contain 'R'  
select * from employee where ename like '%a%'

--Working with Date data-type
--1. NOW()
select now() --displays current and time

create table orders
(
order_id serial primary key,
order_date date,
quantity int
)
insert into orders(order_date,quantity) values(now(),5000)

insert into orders(order_date,quantity) values('2025-01-15',3000)

--2) AGE() calculates the difference between two dates
select AGE(now(),'2025-01-10') as age_diff

--3) EXTRACT() used for extracting parts of the date 
--like year,month,day
select EXTRACT(YEAR FROM now()) as month

--4) TO_CHAR() used for formatting the date and time output
select to_char(now(),'DD/MM/YYYY') as date


----working with BOOLEAN type--------------
--used for flag or status value which acepts TRUE,FALSE and NULL
--It also support other literals like
--true/false
--'t'/'f'
--'yes'/'no'
--'y'/'n'
--'1'/'0'

drop table test
create table test
(
 id int,
 price numeric(5,2)
)
insert into test values(1,true);
insert into test values(2,'1');
insert into test values(3,'t');
insert into test values(4,'y');
insert into test values(5,'yes');

---NUMERIC data-type----
NUMERIC(precision,scale)

e.g. NUMERIC(5,2)-----3 precision and 2 scale
		123.01

insert into test values(3,123.047)

--TIME formats 
drop table test
create table test
(
id int,
time_val time
)

insert into test values(1,now())


insert into test values(2,'01:02')
insert into test values(3,'01:02:50');
insert into test values(4,'010250')


---JSON data-type--
drop table test
create table test
(
 id serial primary key,
 info json
)

insert into test(info) values(
 '{
	"customer":"John",
	"items":
	{"product":"coffee","qty":6}
 }'
);

select info->'items' 
from test
where info->'items'->>'product'='coffee'


select * from test

select * from test



select * from orders


---working with constraints-------------
--Constraints: to specify some rules and restrictions 
--on data to maintain the integrity or correctness of data
--in database at any point of time.
--Types of constraints:
--1) PRIMARY KEY:- It maintains unique records in the tab;e
--and duplicate records cannot be inserted in table
--it doesn't allow NULL value in the column.
--only one Primary key per table.

create table employee
(
ecode int primary key,
ename varchar(20)
....
)

--2) CHECK constraints:- it accepts only the values allowed
--as per the expression provided in the check constraint.
	drop table test
	create table test
	(
		ecode int primary key,
		ename varchar(20),
		salary int check(salary>10000 and salary<=50000),
		gender char(1) check(gender in('M','F'))	
	)

insert into test values(1,'ravi',50000,'M')


--3) DEFAULT constraint:- it takes default specfied value if
--it is not provided while inserting

drop table test

create table test
(
ecode int,
salary int default 5000,
gender char(1) default 'M',
doj date default now()
)

insert into test(ecode) values(101)

select * from test


--4) UNIQUE constraint:- It maintains unique values in a column
--There can be more than one unique constraints per table
--It can accept NULL value also

drop table test
create table test
(
	ecode int primary key,
	ename varchar(20) not null,
	emailid varchar(25) unique,
	mobileno varchar(10) unique
)
insert into test values(101,'ravi','ravi@gmail.com','9986017462')

insert into test values(102,'ravi','ravi@gmail.com','9986017462')

--5) NOT NULL:- It makes the column mandatory, doesnot accept null

--6) FOREIGN KEY :- It is called refrential integrity constraint
--it accept only those values which are already present in 
--other record which is refered by this.

for e.g.

department----(deptid(PK),dname,dhead)
employee----(ecode,ename,salary,deptid(FK))

create table dept
(
deptid int primary key,
dname varchar(20),
dhead int
)
create table emp
(
ecode int primary key,
ename varchar(20),
salary int,
deptid int references dept(deptid) on delete cascade
)

--Rules:
--INSERT rule: we cannot insert in the dependent table
--if the key data is not present in the main table

--DELETE rule:- we cannot delete the record from main table 
--if there are dependent record present somewhere

--on delete cascade : this clause makes sure that when the
--main key record is delete, all its dependent records will 
--also get deleted

delete from dept where deptid=201



insert into dept values(201,'account',109);

insert into emp values(101,'ravi',1111,201)

select * from dept;
select * from emp;


---altering the table---
--1) Adding a new column:- 
alter table emp add column city varchar(10)

--2) Remove the column
alter table emp drop column city

--3) Rename the column
alter table emp rename column empname to ename

select * from emp

--4) adding primary key
alter table emp add constraint pk1 primary key(ecode)

--5) adding foreign key
alter table emp add constraint fk1 
				foreign key(deptid) 
					references dept(deptid)

--6) renaming the table
alter table emp rename to tbl_employee


--Complex queries
--1) Nested queries:- Query within another query.
--It is used when in a query or sql statement the data needed
--is not directly available. So we need another query to get 
--that data which is needed in the main query.
--for e.g.
--Ques: Find the employees working in the deparment of employee
--whose ecode is 101----deptid 201
sol:
select * 
from employee 
where deptid >All (select deptid 
			  from employee 
			  where ecode=103 or ecode=102)

--operators used in nested queries based on whether inner
--query gives multiple results or single.
--if there is chance of multiple results by the inner query
--following operators should be used:
--a) IN :- if results are more, to match with either of the
--values
--b) >ANY:- greater than the minimum
--c) <ANY:- less than the maximum
--d) >ALL:- greater than the max
--e) <ALL:- less than the minimum
col---->4
select *
from tbl
where col<ALL(5,10,7)




--1.2:- Correlated query:- In this query the data needed by the
--inner query depends on the outer query record. So inner
--query is executed for each outer query record unlike normal
--nested query where inner query is excecuted only once for 
--its outer query.

Ques:- Find those students whose marks are greater than 
average marks of all students of his/her section
select * 
from students as o
where marks > (select avg(marks) 
				from students as i
				where i.section=o.section)
				
ques: 
find the employees who gets salary greater than the
average salary in his/her department



--2) Joins queries:- Due to normalization data is scatterred
--across multiple tables, so we need these join queries to get
--all the required information from various tables.
--Types of joins:-
--a) INNER JOINS:- We use this whe records matching from 
--both the tables are needed.
for e.g employee(deptid) and department(deptid)

//ANSI
select e.ecode,e.ename,e.salary,d.deptid,d.dname,d.dhead
from employee as e,dept as d
where e.deptid =d.deptid 


select e.ecode,e.ename,e.salary,d.deptid,d.dname,d.dhead
from employee as e 
inner join 
dept as d
on (e.deptid =d.deptid) 

--b) OUTER JOINS:-
--i) LEFT OUTER JOIN:- it gives matching from both the tables
--and non-matched records from left side table
select e.ecode,e.ename,e.salary,d.deptid,d.dname,d.dhead
from employee as e 
left outer join 
dept as d
on (e.deptid =d.deptid)

--ii) RIGHT OUTER JOIN:-it gives matching from both the tables
--and non-matched records from right side table
select e.ecode,e.ename,e.salary,d.deptid,d.dname,d.dhead
from employee as e 
right outer join 
dept as d
on (e.deptid =d.deptid)

--iii) FULL OUTER JOIN:-
it gives matching from both the tables as well as un-matched 
also from both side tables
--and non-matched records from right side table
select e.ecode,e.ename,e.salary,d.deptid,d.dname,d.dhead
from employee as e 
full outer join 
dept as d
on (e.deptid =d.deptid)

select * from employee
select * from dept


insert into dept values(202,'admin',106),(203,'sales',107)

--self-join:- when the record is joined with another record
--which is present same table. It is a special case of join.
---VIEWS----------------------
--These are sql queries compiled and stored in database
--but do not store result of the query as it is resolved
--runtime.
--why to use views?
--1) to keep the data or information ready needed by the
--end user from various tables.
--2) only relevant data or columns needed instead of whole
--table then also we can use views by storing the query
--as per relevant data needed.
--3) makes ur data secure
--4) queries are faster through views than adhoc queries
--as these are pre-parsed and pre-compiled queries.

syntax=>
create view v1
as
select e.ecode,e.ename,e.salary,d.deptid,d.dname,d.dhead
from employee as e 
right outer join 
dept as d
on (e.deptid =d.deptid)

--calling the view
select * from v1;

--Notes:- 
--a) views follows constraints as per table which is used 
--in the query of the view
--b) we can do DML(I,D and U) operations thru views on the
--base table used in the view but if the view is containing
--multiple tables then we cannot perform DML operations.
--To do this DML operation on views containing multiple
--tables, we take the help of INSTEAD OF trigger.

--to modify the definition of view
create or replace view emp_v
as
select ecode,ename from employee;




	


