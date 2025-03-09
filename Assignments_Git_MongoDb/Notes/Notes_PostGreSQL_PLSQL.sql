--======================PL/SQL=============================
It is a block of statements combined with SQL and some programming
constructs to peform some task in database. These blocks can be 
anonymous or can be stored in database with sime names like
stored procedures,functions, triggers which can be called as and when
needed by the users or applications.

--declaring variables 
	var_name data-type:=value;

DO
$$
DECLARE
--all variables are declared 
BEGIN
--statemenst and logic 	
END$$;

e.g.
DO $$
DECLARE
	first_name VARCHAR(20):='Ramnath';
	last_name VARCHAR(20):='Nishad';
BEGIN
	RAISE NOTICE 'First Name:%, Last Name: % ',first_name,last_name;
END $$;

--Stored procedures vs User-defined: Stored procedure perform
--some task and do not return anything so no RETURN statement
--is used inside the SP whereas functions return a value using
--RETURN statement and also declare return type of the 
--function.

create or replace function fn_name(param1 data-type) returns int
as 
$$
DECLARE

BEGIN

 RETURN value;
END;
$$

e.g. define a function to add two numbers and return the sum

create or replace function fn_add_numbers(num1 int,num2 int)
returns int
as $$
declare 
	result int;
begin	
    result:=num1 + num2;
	return result;
end;
$$ language plpgsql;


--call the function
DO $$
declare
	num1 int:=100;
	num2 int:=200;
	result int;
begin
	result:=fn_add_numbers(num1,num2);
	raise notice 'sum of % and % is %',num1,num2,result;
END;
$$

--define a functions get_bonus which accepts salary and 
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


--test the function
select get_bonus(5000) as bonus;

--test the function on table records
select ecode,salary,get_bonus(salary) as Bonus from employee;
-----Simple IF statement----

create or replace function get_bonus(salary int)
returns numeric(10,2)
as
$$
declare 
	bonus numeric(10,2);
begin
	if salary>5000 then
		bonus:=0.1*salary;
	else
		bonus:=0.2*salary;
	end if;	
	return bonus;
end;
$$ language plpgsql;


select get_bonus(7000) as bonus;

----using CASE statements-------------
--1)simple CASE statement:- direct value is compared
--2) Search expression CASE statement:- some expression is compared

--example of Simple CASE statement:-
create or replace function get_bonus(salary int,deptid int) returns numeric(10,2)
as
$$
declare
	bonus numeric(10,2);
begin
	case deptid
		when 201 then bonus:=0.1*salary;
		when 202 then bonus:=0.2*salary;
		else bonus:=0;
	end case;

	return bonus;
end;
$$ language plpgsql;



---CASE with searched expression----
--example of searched expression CASE statement:-
create or replace function get_bonus(salary int) returns numeric(10,2)
as
$$
declare
	bonus numeric(10,2);
begin
	case 
		when salary>5000 and salary<10000 then bonus:=0.1*salary;
		when salary>=10000 and salary<50000 then bonus:=0.2*salary;
		else bonus:=0;
	end case;

	return bonus;
end;
$$ language plpgsql;



--example of Simple CASE statement with data from table:-
drop function get_bonus(int);

create or replace function get_bonus(ec int) returns numeric(10,2)
as
$$
declare
	bonus numeric(10,2);
	sal int;
	did int;
begin
	--get the employee salary and deptid from table
	select salary,deptid into sal,did from employee where ecode=ec;
	case did
		when 201 then bonus:=0.1*sal;
		when 202 then bonus:=0.2*sal;
		else bonus:=0;
	end case;

	return bonus;
end;
$$ language plpgsql;



--test 
select get_bonus(25000) as bonus;
select ecode,salary,deptid,get_bonus(ecode) as bonus 
from employee;

------Loop statement-----
Loop 
---
Exit when condition
---
End Loop;

eg. 
do $$
declare 
	counter int:=0;
begin
	loop
		counter:=counter + 1;		
		exit when counter>10;
		raise notice '%',counter;
	end loop;
end;
$$;

---------WHILE loop-----
--add numbers upto 10
do $$
declare 
	sum integer:=0;
	i integer:=0;
begin	
while i<=10 
loop
	sum:=sum + i;
	i:=i+1;
end loop;
raise notice 'sum of numbers upto 10 is %',sum;
end $$;


-----Types of functions based on return values-----
--1) Scaler-valued functions:-these functions return rimitive single value
--like int,char,decimal etc
--2) Table-valued functions:- These functions return TABLE tyoe
--and should return a query statement result

drop function get_emps_by_did(int);

create or replace function get_emps_by_did(did int)
returns table(ec int,sal int,dept_id int) language plpgsql
as
$$
begin
	return query select ecode,salary,deptid 
	from employee where deptid=did;
end;$$


--test the table-valued functions
select * from get_emps_by_did(202);


-----parameter modes or directions-------------
--a)IN :- default mode i.e. u can only pass it and any modification to th e
--passed parameters will not retained after exiting the block.
--b) OUT:- it will retain the modifications out of the block
--c) INOUT:- u can assign the value and also retain the changes
--out of the block.

drop function calculate_bonus(int);
--example of OUT mode-------------
create or replace function calculate_bonus(salary int, out bonus int,out x int ) 
language plpgsql
as
$$
begin
	select 0.1*salary,100 into bonus,x;
end;$$ 


--test the function --

do
$$
declare
 salary int:=7000;
 bvalue int;
 xvalue int;
begin
	--call the function 
	select bonus,x from calculate_bonus(salary) into bvalue,xvalue;
	raise notice 'bonus:%, x:%',bvalue,xvalue;
end;$$


--Drawback of functions:- user-defined functions do not support  transaction
--i.e. we cannot start a transaction is UDFs and commit or rollback.

--So we have stored procedures which supports transactions.
--no return type but out/inout parameters can be used.

--syntax=>
create or replace procedures proc_name(param_list) languague plpgsql
as
$$
declare
--variable declaration
begin
--body--
end;$$

--example : using stored procedure, update the salary of an employee passing
--ecode and salary to be updated.

create or replace procedure sp_updatesal(ec int,sal int)
language plpgsql
as $$
begin
	update employee set salary=sal where ecode=ec;
	raise notice 'salary updated for the employee %',ec;
end;$$

--to call a stored procedure, use CALL statement
call sp_updatesal(101,50000)



--------------TRIGGERS------------
These are like PL/SQL block which are defined to be fired
automatically on some operation like INSERT,DELETE and UPDATE.
BEFORE triggere and AFTER trigger :- means whether trigger shud  fire
after completing the operation or before the operation.

--Trigger can also be marked FOR EACH ROW to get fired for every 
--records affected.

OLD and NEW column name can be used to access the data before and after
the changes are done in the record. 

syntax=>
create trigger trigger_name
BEFORE | AFTER | INSTEAD OF event_name
ON table_name
[
--trigger logic here...

]

e.g.
CREATE FUNCTION trigger_function()
   RETURNS TRIGGER
   LANGUAGE PLPGSQL
AS $$
BEGIN
   -- trigger logic
END;
$$

create or replace function display() returns trigger language plpgsql
as $$
begin
 raise notice 'trigger fired';
 raise notice 'old values: % % % %',OLD.ecode,OLD.ename,OLD.salary,OLD.deptid;
 raise notice 'new values: % % % %',NEW.ecode,NEW.ename,NEW.salary,NEW.deptid;
 return new;
end;
$$


create or replace trigger t1
after update 
on employee
for each row
execute function display();


select * from employee;
update employee set salary=salary+1000 where ecode=102;



---ques: create a trigger which should log the record in another table
--on deletion so that u can get the deleted records.

create table log_tbl
(
ecode int,
ename varchar,
salary int,
deptid int,
date_of_trans date default now()
)

//define the trigger function to get the deleted records 
//and insert into log table

create or replace function log_data() returns trigger language plpgsql
as
$$
declare
 ec int;
 en varchar;
 sal int;
 did int;
begin
 --get the deleted record values
  select OLD.ecode,OLD.ename,OLD.salary,OLD.deptid into ec,en,sal,did;
 --insert this record into log table
 insert into log_tbl values(ec,en,sal,did,now());
 raise notice 'record deleted and logged into log table';
 return old;
end;$$


--define delete trigger 
create or replace trigger del_trig 
before delete
on employee 
for each row
execute function log_data();

select * from log_tbl;

--Transactions :- It is a group of sql statements which are executed
--as a one unit i.e. either all shud get completed or all shoud be reverted
--if any of the statements are failed. We make the data consistent due
--to use of transactions.
--Types of transactions:-
--a) implicit :- for every statements, one implicit transaction is initiated
--and immediately it is committed automatically by the server.
--b) explicit:- we have to start the transaction and finish the transaction
--using either COMMIT or ROLLBACK.

syntax=>
BEGIN TRANSACTION
--statements--
COMMIT;
--or ROLLBACK


select * from employee;

begin transaction;
delete from employee where ecode=101;
update employee set salary=salary+1000 where ecode=102;

commit;

rollback;

begin transaction isolation level repeatable read;
insert into employee values(104,'ramnath',4444,201);

commit;

isolation levels:-
1)READ UNCOMMITTED :- transation can see the uncommitted records also.
this is not there is postgresql as default is READ COMMITTED
2) READ COMMITTED:- only committed records will be visible to the transaction.
3) REPEATABLE READ:- It makes sure that a transaction will get always
same version of data throughout when it was started even though other
transactions are committing the data into the table.
4) READ SERIALIZABLE:- This assumes that the transaction are considered
in a serial rather than parallel. so more waiting chances will be here but
more consistent data u will get in ur transactions.



------Error handling in PLSQL--------------

do $$
declare 
 n1 int:=10;
 n2 int:=2;
 res int;
begin 
if n2=0 then
	raise exception 'divide by zero error happened,denominator should not be 0';
end if;
res:=n1/n2;
raise notice 'result:%',res;

exception
	--when sqlstate '22012' then
	when others then
	raise notice 'Error occurred:%',sqlerrm;
end;$$





















select * from employee;












