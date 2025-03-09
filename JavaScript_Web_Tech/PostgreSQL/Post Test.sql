create database company_db;
create table emp_info(
name varchar(30),
dept varchar(23),
salary int
)
create table dept_info(
dept_name varchar(23),
dept_head varchar(23)
)
-----------
create table employees(
emp_id int primary key,
emp_name varchar(23) not null,
emp_age int not null,
emp_department varchar(23),
emp_salary numeric
)
--------
create table department(
emp_id int references employees(emp_id) ,
dept_id int,
dept_salary int
)
select * from department
insert into department values
(102,01,50000),(105,04,40000),(104,09,600000),
(102,06,30000)
------------------
insert into employees values(101,'srikanth',23,'finance','300000'),
(102,'Naveen',24,'HR',400000),
(103,'sai krian',23,'IT',500000),
(104,'mohan',24,'QE','450000'),
(105,'satya Narayna',23,'Engineering',200000),
(106,'krishna',25,'HR',20000)
select * from employees
-----------------
select emp_name,emp_age from employees
where emp_department ='Engineering' and emp_salary>50000
-----------------
update employees 
set emp_salary = emp_salary+(emp_salary*0.10)
where emp_department = 'HR'
--------------------------
delete from employees where emp_salary<30000 
-------------------
select e.emp_name,e.emp_department,e.emp_salary
from employees e join department d
on e.emp_id=d.emp_id
-----------------
select e.emp_department,avg(e.emp_salary) as Emp_avg_salary
from employees e join department d
on e.emp_id=d.emp_id
group by e.emp_department
-------------
select emp_department,avg(emp_salary) as dep_avg_salry
from employees
group by emp_department
----------------
select emp_name from employees where emp_salary=
(select max(emp_salary) from employees
where emp_department ='Engineering')
--------------------
alter table employees add email_address varchar(25) unique
select * from employees
------------11 ----------------------
CREATE TABLE salary_changes (
    change_id SERIAL PRIMARY KEY,
    emp_id INT references employees(emp_id),
    old_salary NUMERIC,
    new_salary NUMERIC,
    change_date TIMESTAMP
)

create or replace procedure update_employee_salary(emp_id int,salary_increment int)
language plpgsql
as $$
declare 
old_sal numeric;
new_sal numeric;
begin
select salary into old_sal from employees1 where employee_id=emp_id;
new_sal:=salary+salary_increment;
	update employees1 set salary=new_sal where employee_id=emp_id;
	insert into salary_changes(employee_id,old_salary,new_salary,change_date) values (emp_id,old_sal,new_sal,now());
	raise notice 'salary updated for the employee id %',emp_id;
end;$$;

-----------------
create or replace function get_employee_bonus(emp_id int) returns int
as $$
declare
 emp_salary int;
 bonus int;
begin
	select emp_salary from employees where emp_id= emp_id;
	if emp_salary is null then
	return null;
	end if;
	if emp_salary>50000 then
		bonus:=emp_salary*0.1;
		else
 		bonus:=emp_salary*0.5;
	end if;
return bonus;
end;
$$ language plpgsql;
---------12---------------
CREATE TABLE audit_log (
    log_id SERIAL PRIMARY KEY,
    emp_id INT references employees(emp_id),
    old_salary NUMERIC,
    new_salary NUMERIC,
    change_time TIMESTAMP
);
select * from audit_log
-----------15----------
CREATE TABLE employ (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    salary NUMERIC,
    department_id INT
);
insert into employ values(101,'Kiran',300000,4),
(102,'santosh',450000,6),(103,'krishna',60000,7),
(104,'vishnu',780000,20)
create or replace function avg_dept_sal(department_id int) returns int
as $$
declare
 avg_salary int;
begin 
	select avg(salary) from employ where department_id=department_id;
	if avg_salary is null then
	return 0;
    end if;
	return avg_salary;
end;
$$ language plpgsql;

select avg_dept_sal(7) as avgrage_slary from employ
------------------------
