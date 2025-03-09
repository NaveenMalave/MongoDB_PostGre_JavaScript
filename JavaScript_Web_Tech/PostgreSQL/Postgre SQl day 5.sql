---------TRANSACTIONS----------
--It is a group of sql statements which are executed as a one unit
--i.e. either all should get completed or all should be reverted
--if any of the statements are failed. we make the data consistent due
--to use of transactions.
--Types of Transactions
--a) implict: for every statements, one implicit transactions i
 --is initiated and  immediately it is commited automatically  by the server
--b) Expicit: 

syntax=>
begin transaction
--statements--
commit
--or rollback

begin transaction
delete from employee where emp_id = 104;
commit;
begin transaction 
insert into employees values(101,'ramnath',1111)

ISOATION  levels:
1)REAd uncommited: transaction can see the uncommited records also.
this is not there is postgresql as default is read committed
2) read commited: only commited record will be visible to the transaction
3) repeatable read: it makes sure that a transaction will get always
sane version  of data througout when it was started even though other 
transaction are committing the data into the table.
4)Read serializable: this assumes that the transaction are considerd
in a serial rather than parallel. som more waiting chances will be have but
more comsistent data u will get in ur transaction 

begin transaction isolation level repeatable read;

commit
begin transaction
delete from employee where ecode=101;
update from employee set salary=salary*1000 where emp_id=102;
commit
rollback
---error handling in PLSQL
do$$
declare
n1 int:=10;
n2 int:=2;
res int;
begin
if n2=0 then
raise exception 'divede by zero error happened , denominator should not'
end if;
res:=n1/n2;
raise notice 'result:%',res;
exception 
---when sqlstate '22012' thenwh
when others then
raise notice 'Error occurred:%',sqlerm;
end;$$

----
