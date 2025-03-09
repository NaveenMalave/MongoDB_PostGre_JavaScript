create database practice;
create table SUPPLIER(
SNO VARCHAR(23) PRIMARY KEY,
SNAME VARCHAR(23),
STATUS INT,
CITY VARCHAR(23)
)
INSERT INTO SUPPLIER VALUES('s1','smith',20,'london'),
('s2','Jones',10,'paris'),('s3','Blackes',30,'paris'),
('s4','clark',20,'london'),('s5','adams',30,'athens');

INSERT INTO SUPPLIER (SNO,SNAME,CITY) 
VALUES ('s6','oh','seattle'),('s7','Fidel','seattle'),
('s8','Caryle','seattle');

SELECT * FROM SUPPLIER

CREATE TABLE PART(
PNO VARCHAR(23) PRIMARY KEY,
PNAME VARCHAR(23),
COLOR VARCHAR(23),
WEIGHT INT,
CITY VARCHAR(23)
)
INSERT INTO PART (PNO,PNAME,COLOR,WEIGHT,CITY)
VALUES('p1','nut','red',12,'london'),
	  ('p2','bolt','Green',17,'paris'),
      ('p3','Screw','Blue',17,'rome'),
	  ('p4','Screw','red',14,'london'),
	  ('p5','cam','blue',12,'paris'),
	  ('p6','cog','red',19,'london');


create table SUPP_PART(
SNO varchar(30),
PNO varchar(30),
constraint fk_SUPPLIER foreign key (SNO) references SUPPLIER(SNO),
constraint fk_PART foreign key (PNO) references PART(PNO),
QTY int
);
insert into SUPP_PART (SNO,PNO,QTY) values('s1','p1',300);
insert into SUPP_PART (SNO,PNO,QTY) values('s1','p2',200);
insert into SUPP_PART (SNO,PNO,QTY) values('s1','p3',400);
insert into SUPP_PART (SNO,PNO,QTY) values('s1','p4',200);
insert into SUPP_PART (SNO,PNO,QTY) values('s1','p5',100);
insert into SUPP_PART (SNO,PNO,QTY) values('s1','p6',100);
insert into SUPP_PART (SNO,PNO,QTY) values('s2','p1',300);
insert into SUPP_PART (SNO,PNO,QTY) values('s2','p2',400);
insert into SUPP_PART (SNO,PNO,QTY) values('s3','p2',200);
insert into SUPP_PART (SNO,PNO,QTY) values('s4','p2',200);
insert into SUPP_PART (SNO,PNO,QTY) values('s4','p4',300);
insert into SUPP_PART (SNO,PNO,QTY) values('s4','p5',400);
--------------------------------------------
select * from supplier;
select * from part;
select * from supp_part;
---------------simple queries---------------------
select sno,status from supplier where city='paris';
select pno from supp_part;
select distinct(PNO) from supp_part;
select * from supplier;
select Pno,weight,weight*454 as weight_grams from part;
select SNO from supplier where status > 20 and city='paris'
select sno , status from supplier where city='paris' order by status desc;
select sno from supplier where status isnull
--------------Aggregate function---------------
select count(*) as CountOfSNO from supplier;
select count(pno) as CountOfPNO from supp_part where pno='p2';
select sum(qty) as SumOfQTY from supp_part where pno='p2';
select pno, sum(qty) as SumOfQTY from supp_part group by pno;