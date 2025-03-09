create database assignments;
create table Dept (
Dept_no varchar(23) primary key,
Dept_name varchar(23),
locations varchar(23)
)
insert into Dept values('d2','Accounting','Seattle')
insert into Dept values('d3','Marketing','Dallas')
select * from dept
create table emp(
emp_no int primary key,
emp_fname varchar(23),
emp_lname varchar(23),
dept_no varchar(23),
constraint fk_Dept foreign key(dept_no) references Dept(Dept_no)
)
insert into emp values(25348,'Mattheq','Smith','d3'),
(10102,'Ann','jones','d3'),(18316,'John','Barrimore','d1'),
(29346,'James','James','d2')
select * from emp
create table project(
project_no varchar(23) primary key,
project_name varchar(23),
Budget int
)
insert into project values
('p1','Apollo',120000),('p2','Gemini',95000),('p3','Mercury',185600)
select * from project
CREATE TABLE works_on (
    emp_no INT ,
    project_no VARCHAR(23),
    job VARCHAR(23),
    enter_date DATE,
    CONSTRAINT fk_emp FOREIGN KEY (emp_no) REFERENCES emp(emp_no),
    CONSTRAINT fk_project FOREIGN KEY (project_no) REFERENCES project(project_no)
);
insert into works_on values
(10102,'p3','Manager','1999-01-01'),(25348,'p2','clerk','1998-02-15'),
(29346,'p1','clerk','1998-01-04'),(10102,'p1','clerk','1999-01-01')
insert into works_on(emp_no,project_no,enter_date) values (18316,'p2','1998-02-15'),
(29346,'p2','1997-12-15')
select * from works_on
-----------------------------
select emp_no from works_on where job='clerk'
---------
select w.emp_no from works_on as w 
join project as p on w.project_no = p.project_no
where p.project_no ='p2' and w.emp_no>10000 
----
select emp_no from works_on
where year(enter_date)<>1998


SELECT emp_no
FROM works_on
WHERE emp_no NOT IN (
    SELECT emp_no
    FROM works_on
    WHERE EXTRACT(YEAR FROM enter_date) = 1998
);
---------------------
select emp_no from works_on
where project='p1' and job in ('manager','analyst)
----------
SELECT w.emp_no
FROM works_on w
JOIN project p ON w.project_no = p.project_no
WHERE p.project_no = 'p1' AND w.job IN ('Analyst', 'Manager');
------------------
SELECT enter_date
FROM works_on
WHERE project_no = 'p2' AND (job IS NULL OR job = '');
----------------
select emp_no,emp_fname from emp 
where emp_lname like '%t%t%'
-------
select emp_no,emp_fname from emp
where (emp_lname like '_o%es' or emp_lname like '_a%es')
---------
select e.emp_no  from emp as e  join dept as d
on e.dept_no=d.dept_no where d.locations = 'Seattle'
----------
select locations, count(dept_no) as department_id
from dept
group by locations
-------------
select max(emp_no) as biggest_emp_no from works_on
---------------
select job from works_on 
group by job having count(distinct emp_no)>2
----------
SELECT e.emp_no
FROM emp e
JOIN works_on w ON e.emp_no = w.emp_no
WHERE w.job = 'Clerk' OR e.dept_no = 'd3';
--------------
select w.emp_no, w.job from works_on w
join project p on p.project_no = w.project_no
where project_name ='Gemini'
----------------
select e.emp_fname,e.emp_lname from emp e join
dept d on d.dept_no=e.dept_no
where dept_name in ('Research', 'Accounting')
------- 
select w.enter_date from works_on w join emp e
on e.emp_no = w.emp_no
where e.dept_no='d1' and w.job='clerk'
-------------
select p.project_name from project as p join
works_on as  w on w.project_no=p.project_no
where w.job='clerk'
group by p.project_name
having count(w.emp_no)>=2
--------------
select e.emp_fname,e.emp_lname from emp e
join works_on w on e.emp_no =w.emp_no
join project p on p.project_no=w.project_no
where w.job='Manager' and p.project_name='Mercury'
--------------
select e.emp_fname,e.emp_lname from emp e
join works_on w on w.emp_no = e.emp_no
where w.enter_date in(
select enter_date from works_on
group by enter_date
Having count(emp_no)>1
)
------------------
select e1.emp_no from emp e1
join emp e2 on e1.dept_no = e2.dept_no and e1.emp_no <> e2.emp_no
join dept d on e1.dept_no=d.dept_no
where d.locations=d.locations
------------
select e.emp_no
from emp e
join dept d on e.dept_no=d.dept_no
where d.dept_name = 'Marketing'

-------
select * from dept 
select * from emp
select * from project
select * from works_on