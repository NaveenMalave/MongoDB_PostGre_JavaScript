--==============PL/SQL=====================
--IT is a block of statements combined with sql and some programming
constructs to perform some tasks in database . these blocks can be anonymous
or can be stored in database with some names like stored procedure , funtions
triggers which can be called as an needed by the users or applications.
---declaring variables
 var_name data-type;
 DO
 $$
 DECLARE 
 --all variables are declard
 BEGIN
 --statement and logic
 END$$;
 e.g. 
 DO $$
 DECLARE
  first_name varchar(20):='Ramnath';
 BEGIN
  RAISE NOTICE 'First Name:%',first_name;
END $$;
-----------
DO $$
 DECLARE
  first_name varchar(20):='Ramnath';
  last_name varchar(20):='Nishas';
 BEGIN
  RAISE NOTICE 'First Name:%,Last Name:%',first_name,last_name;
END $$;
---------
--stored procedures vs user_defined: stored procedure perform
--some task and do not return anything as no RETURN statement
--is used inside the SP whereas functions return a value using
--RETURN statement and also declare return type of the function.
create or replace function fn_name(param1 data-type) returns in
as 
$$
DECLARE
begin
 return value
END ;
$$
e.g. define a function to add two numbers and return the sum 
create or replace function fn_add(num1 int,num2 int) returns int
as
$$ 
declare 
  result int;
begin 
 result:=num1+num2;
 return result;
end;
$$ language plpgsql;
--------
--call the function
do $$ 
declare 
num1 int :=100;
num2 int :=200;
result int;
begin 
result:=fn_add(num1,num2);
raise notice 'sum of % and % is %',num1,num2,result;
end;
$$
---define a functions get_bounus which accepts salary and 
--returns 10% of salary as bonus
create or replace function get_bonus(salary int)
returns numeric(10,2)
as
$$ 
declare 
  bonus numeric(10,2);
begin
  bonus:=0.1*salary;
  return bonus;
end;
$$ language plpgsql;
---------
create or replace function get_bonus(salary int)
returns numeric(10,2)
as
$$ 
declare 
  bonus numeric(10,2);
begin
  if salary>5000 then
  bouns:=0.1*salary;
  else
  bonus:0.2*salary
  end if
  return bonus;
end;
$$ language plpgsql;
----------
--test the function
select get_bonus(5000) as bonus;
--test the function on table records
select emp_no,salary,get_bouns(salary) as bonus from emp;
select * from emp;
do 
$$
declare salary int:=1000;
return 
---------using CASE statements---------
--1) simple CASE statements:- direct value is compared
--2) search expression case statement:- some expression is compared
--example of simple CASE statements
 create or replace function get_bouns(salary int, deptid int) 
 return nt
 as
 $$
 declare
  bonus numeric(10,2);
 begin
  case deptid 
  	when 201 then bouns:=0.1*salary;
	 when 202 then bouns:=0.1*salary;
	 else bouns:=0;
	end case;
	return bouns;
end;
$$ language plpgsql;
---test
select get_bonus(7000,203) as bouns;
select ecode,salary,deptid,get_bonus(salary,deptid) as bouns
from employee;
----case  
begin
 case 
  when salary>5000 and salary<10000 then bonus:=0.1*salary;
  when salary>=10000 and salary<=100000 then bonus:=0.1*salary;
  else bonus:0;
  return bonus;
 end;
 $$ language plpgsql;
 ---test
 select get_bonus 

 ----------Loop statements---------
 Loop --
 Exit when condition
 --
 end loop;
 eg.
 Do$$
 declare
 begin
  loop
  counter:=counter+1;
  raise notice '%',counter
  exit when counter>10;
  raise notice '%' , counter;
   end loop
 end;
 $$;
 --------
 ------while loop-------
 ---add numbers upto 10
 do $$
 declare
  sum integer:=0;
  i integer:=0;
 begin
 while i<=10
 loop
 sum:=sum+i;
 i:=i+1;
 end loop;
 raise notice 'sum of numbers upto 10 is %',sum;
 end $$;
 ---------Type of functions based on return values--------
 --1) Scaler- valued functions: these functions return rimitive single value
 --like int,char,decimal etc
 --2) Table-valued functions:- These functions return TABLE type
 --and should return a query statement result
 create or replace function get_emps_by_did(did int)
 returns table(emp_no int,  dept_no int) language plpgsql
 as
 $$
 begin
  return query select emp_no,dept_no
  from emp where emp_no=did;
  end;$$
  ---test the table-valued functions
  select * from get_emps_by_did(109);
  select * from emp;
 ----------parameter modes or directions---------
 --IN:- default mode, i.e u can only pass it and any modification to the
 --passed parameter will not retained after exiting the block
--b)OUT:it will retain the modifications out of the block
--c) INPUT: u can assign the value and also retain the changes out of block

drop function calculate_bonus;
--example of OUT mode---
create or replace function calculate_bonus(salary int,out bonus int)
as
$$
begin
 bonus:=0.1*salary;

end;$$ language plpgsql;
-----test function----
do
$$
declare
salary int:=7000;
bvalue int;
xvalue int;
begin 
--call the function
select bonus,x from calculate_bonus(salary) into bvalue,xvalue;
raise notice 'bonus:%,x:%',bonus,xvalue;
end;$$
drop function calculate_bonus(int)

--Drawback of functions: user--defined functions do not support transaction
--i.e we cannot start a transaction is UDFs and commit or rollback.
--so we have stored procedure which supports transactions.
--no return type but out/inout parameters can be used.
--syntax=>
create or replace procedure proc_name(param_list) language plpgsql
as
$$
declare
--
begin
--
end;
$$--Example: using stored procedure, update the salary of an employee
passing --ecode and salary to be updated
create or replace procedure sp_updatesal(ec int,sal int)
language plpgsql
as $$
begin
  update employee set salary=sal where ecode=ec;
  raise notice 'salary updated for the employee %',ec;
  end;$$
  --to call a stored procedure, use  CALL statement
  call sp_update(101,5000)

  -----TRIGGERS---------
  These are like PL/SQL block which are defined to be fired automatically
  on some operation like INSERT ,DELETE AND UPDATE BEFORE triggere and 
  AFTER trigger:- means whether trigger shud fire after completing the
  operation or before the operation.
  --Trigger can also be marked FOR EACH ROW  to get fired for every
  --records affected.
  old and new column name can be used to access the data before and after
  the changes are done in the record.
  syntax=>
  create trigger trigger_name
  before | after| instead of event_name
  on table_name
  [
--- trigger logic here..
  ]
  e.g.
  create or replace function display() returns trigger language plpgsql
  as $$
  begin 
  raise notice 'old values: % % % %'old.edecode,old.salary,old epartmnt
  raise notice 'new values: % % % %',new.ecode,new.ename,new.salary , new.department
   raise notice 'trigger fired';
   return new;
  end;
  $$


  create trigger t1
  before update
  on employee
  for each row
  execute procedure display();
  
  select * from employee;
  update employee set salary=salary*1000 where ecode=102;
  ------
  --ques:create a trigger which should log the record in another table
  --deletion so that u can get the resclare
  create table log_tbl(
ecode int,
sr name varchar()
date_of_trains
)
create or replace function log_date returns
as
$$
declare
 en int;
 en varchar(23);
 sal int;
 did int;
begin
--get the deleted record values.
select old.ecode, old.ename,ole.salary,old.deptid into ec,an,sal,did;
--insert this record into log table
insert into log_tbl values(ec,en,sal,did,now());
raise notice 'record  deleted and logged into log table'
end;$$
-------define delete trigger
create or replace  trigger del_trig
after delete
on employee
execute function log_date();

select * from employee;
