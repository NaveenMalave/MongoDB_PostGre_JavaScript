create table employee(
 empid int,
 name varchar(40),
 salary int,
 depid int
);
insert into employee(empid,name,salary,depid) values (101,'naveen',400000,201);
insert into employee values(102,'srikanth',6000000,202),(103,'sai kiran',700000,203);
insert into employee values(104,'vinay',8000,204);
insert into employee values(104,'satya',70000,204),(105,'mohan',60000,206)
select * from employee;
----delete records
--- 1) deleting selected records
delete from employee where empid=104
--b) uncondtional delete (be sure as it deleted all the data)
delete from employee
-----truncate--
truncate employee --- hard delete, cannot be rolled back
---drop table employee : it drops data along with structure also 

--- update records
--a) conditional update
update employee set salary=salary+500 where depid=201

--b)uncoditional update
update employee set salary=salary+200 

---updating more than one column values
update employee set salary=50000,depid=10 where empid=105 

---insert only few columns values
insert into employee(empid,name) values(106,'ramnath')

----display computed values as bonus of salary
select empid,name,salary,depid, salary*0.1 as Bonus from employee
-------sorting the records
select * from employee order by salary desc
select * from employee