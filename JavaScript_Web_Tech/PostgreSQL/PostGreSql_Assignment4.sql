create  or replace function Factorial(n INT)
returns bigint as $$
	declare 
	result bigint :=1;
begin
	while n>1 loop
	 result:=result*n;
	 n:=n-1;
	end loop;
	return result;
end;
$$ language plpgsql;
-----------------------
	
select Factorial(5) as FactorialResult;
--------------------------
create or replace function recent_employees()
returns table(emp_id int, emp_name varchar,join_date date )
as $$
begin
return query
select emp_id, emp_name, join_date
from emp
where join_date >= current_date - interval '30 days';
end;
$$ language plpgsql;

select * from recent_employees();
-----------------------------------
create or replace function rev_string(input_string varchar)
returns varchar as $$
declare 
 reversed_string varchar :='';
 i int;
begin
 for i in reverse length(input_string)..1 loop
 	reversed_string:=reversed_string || substring(input_string from i for 1);
end loop;
return reversed_string;
end;
$$ language plpgsql;

select rev_string('Hello') as reversedString;
----------------------------------
create or replace function total_sales(product_id int)
returns decimal as $$
declare
 total decimal:=0;
begin
	select coalesce(sum(quantity*price),0) into total
	from sales
	where product_id=product_id;
	return total;
end;
$$ language plpgsql;

select total_sales(101) as TotalSalesAmount;
---------------------------------
create or replace function high_value_cust(min_amount decimal)
returns table(customer_id int, customer_name varchar) as $$
begin
 return query
 select distinct c.customer_id,c.customer_name
 from customers c
 join orders o on c.customer_id = o.customer_id
 where o.total_amount > min_amount;
end;
$$ language plpgsql;

select * from high_value_cust(500);
-----------------------------