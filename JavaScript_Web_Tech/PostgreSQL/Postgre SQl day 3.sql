-----NESTED SUBQUERY
--QUES: Find the employees working in the department of emplyee
--whose ecode is 101 --deptid 201
select * from emp 
where deptid IN (select deptid from employee where ecode=103 or ecode = 102)
--operators used in nested queries based on whether inner
--queries gives 
--if there is chance of multiple results by inner query 
--following operators should by used:
--a) IN :-if results are more, to match with either of the values
--b) > ANY:- greater than the minimum
--c) > <ANY : less than the miximum
--d) >All : greater than the max
--e) <ALL : less than the minimum
--
col-->9
select * from tbl where col < ALl(5,10,7)

--1.2 :- Correlated query --> IN this query the data needed by the
--inner query depends on the outer query records . so inner 
--query is executed for eact outer query record unlike normal
--nested query where inner query is executed only once for its outer query.
ques: Find those students whose marks are greater than 
average marks of all students
select * from students where marks>(select avg(marks) from students)
ques: Find those students whose marks are greater than 
average marks of all students of his/her section
select * from students as o
where marks > (select avg(marks) from students as i
where i.section=o.section)
ques: find the employee who gets salary greater than the average 
salary  in his/her department

--Join Queries : Due to normalization data is scattered
--accross multiple tables, so we need these join queries to get all the required 
--information from both tables are needed.
-- Types of joins:
--a) INNER JOINS: we use this when records matching from both the tables are needed.
select e.ecode,e.ename,e.salay,d.deptid,d.dname,d.dhead
from employe as e, deptm as d where e.deptno=d.deptno

select e.ecode,e.ename,e.salay,d.deptid,d.dname,d.dhead
from employe as e inner join  dept as d on (e.deptno=d.deptno)
--b) OUTER JOINS:
--i) LEFT OUTER JOIN: it gives matching form both tabe
--and non matched record from left side table
select
form 
--ii) RIGHT OUTER JOIN:
--iii) FULL OUTER JOIN:
it gives matching from both the table as well as 
--self join: when the record is joined with another record
--which is present same table . it is special case of join.
----------------VIEWS------------
--These are sql queries compiled and stored in database
--but do not store result of the query as it is resolved
--runtime.
---why to use views?
--1) to keep the data or information ready needed by the
--end user from various tables.
--2) only relevent data or columns needed instead of whole
--table than also we can use views by storing the query
--as per relevant data needed.
--3) make ur data secure
--4)queries are faster through views than adhoc queries
--as these are pre-parsed and pre-compiled 
syntax=>
create view v1
as 
select e.ecode,e.ename, e.salary,d.dept_id,d.dname,d.dhead
from emplyee as e
right outer join
dept as d
--talling the view
select * from v1;
--NOTES 
--a) views follows constraints as per table which is used
--in the query of the view
--b)we can do DML(I,D AND U) operations thru view on 
--the base table used in the view but if the view is containing
--multiple tables than we cannot perform DML operation
--To do this DML operation on views containing multiple
--tables , we take the help of INSTEAD OF trigger.
update v set salary=salary+1000 where ecode=102
create view emp_v
as select emp_no,emp_fname from emp where dept_no='d3'
insert into emp_v values(109,'suresh')
delete from emp_v where emp_no=109;
select * from emp;
select * from emp_v;
---
alter view emp_v
as select emp_no,emp_fname from emp;

create or replace view emp_v
as select emp_no , emp_fname from emp;
---------
create  view emp_vv
as select emp_no , emp_fname from emp;
select * from emp_vv