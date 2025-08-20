-- create

create database abc;
use abc;
create table emp 
(name text(20),
id int primary key,
salary int,
dept_id int,
email varchar(30));

-- add column --

alter table emp
add manager_id int;

select * from emp;

-- rename column --

alter table emp
rename column manager_id to mng_id;

-- rename table name --

alter table emp
rename to employee;

alter table employee
rename to emp;

-- modify data type --

alter table emp
modify salary decimal(10,2);

-- drop column --

alter table emp
drop column mng_id;

-- add constraint --

alter table emp
add constraint unq_email unique(email);

describe emp;

create table dep(
dep_id int primary key,
dep_name varchar(20) unique
);

-- add foreign key --

alter table emp
add constraint dept
foreign key (dept_id) references dep(dep_id);

alter table emp
add column is_active boolean default true;


-- drop --

drop table emp;

-- truncate --

truncate table dep; 