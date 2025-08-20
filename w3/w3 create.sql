create database practice;
use practice;

-- 1. Write a MySQL query to create a simple table countries including columns country_id, country_name and region_id.

create table countries (country_id int ,
	country_name text,
    region_id int
    );
select * from countries;


-- 2. Write a MySQL query to create a simple table countries including columns country_id, country_name and region_id which is already exists.

create table if not exists countries (
	country_id int ,
    country_name text,
    region_id int
    );

-- 3. Write a MySQL query to create the structure of a table dup_countries similar to countries.

create table dup_countries like countries;
select * from dup_countries;

-- 4. Write a MySQL query to create a duplicate copy of countries table including structure and data by name dup_countries.

insert into countries values
	(1,'india',1001),
    (2,'USA',1002),
    (3,'iran',1003)
    ;
    
select * from countries;
create table if not exists dup_countries as select * from countries; 
select * from dup_countries;

-- 5. Write a MySQL query to create a table countries set a constraint NULL.

create table coutries (
	id int,
    country_name text not null,
    region text
    );

-- 6. Write a MySQL query to create a table named jobs including columns job_id, job_title, min_salary, max_salary 
-- and check whether the max_salary amount exceeding the upper limit 25000.

create table jobs (
	job_id int not null unique primary key,
    job_title text, 
    min_salary int,
    max_salary int check(max_salary<=2500)
    );

-- 7. Write a MySQL query to create a table named countries including columns country_id, country_name and region_id and make sure 
-- that no countries except Italy, India and China will be entered in the table.

create table country1 (
	country_id int,
    country_name text check(country_name in ('Italy','India','China')),
    region_id int
    );

-- 8. Write a MySQL query to create a table named job_histry including columns employee_id, start_date, end_date, job_id 
-- and department_id and make sure that the value against column end_date will be entered at the time of insertion to the format like '--/--/----'.

create table job_history (
	employeed_id int,
    start_date date,
    end_date date check(end_date like '--/--/----'),
    job_id int ,
    department_id int
    );
select * from job_history;

-- 9. Write a MySQL query to create a table named countries including columns country_id,country_name and region_id 
-- and make sure that no duplicate data against column country_id will be allowed at the time of insertion.

create table country2 (
	country_id int unique,
    country_name text,
    region_id int
    );

-- 10. Write a MySQL query to create a table named jobs including columns job_id, job_title, min_salary and max_salary, 
-- and make sure that, the default value for job_title is blank and min_salary is 8000 and 
-- max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.
drop table job2;
use w3;

create table job2 (
	job_id int not null ,
    job_title varchar(30) default ' ',
    min_salary int default 8000,
    max_salary int default null
    );
describe job2;

-- 11. Write a MySQL query to create a table named countries including columns country_id, country_name and region_id and 
-- make sure that the country_id column will be a key field which will not contain any duplicate data at the time of insertion.

create table country3 (
country_id int unique primary key,
country_name text,
region_id int 
);
describe country3;

-- 12. Write a MySQL query to create a table countries including columns country_id, country_name and 
-- region_id and make sure that the column country_id will be unique and store an auto incremented value.

create table country4(country_id int unique auto_increment,country_name text,region_id int);
describe country4; 

-- 13. Write a MySQL query to create a table countries including columns country_id, country_name and region_id and 
-- make sure that the combination of columns country_id and region_id will be unique.

create table country5(
	country_id int ,
    country_name varchar(50),
    region_id int ,
    primary key(country_id,country_name)
    );
describe country5;

-- 14. Write a MySQL query to create a table job_history including columns employee_id, start_date, end_date, job_id and 
-- department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and 
-- the foreign key column job_id contain only those values which are exists in the jobs table.
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| JOB_ID     | varchar(10)  | NO   | PRI |         |       |
| JOB_TITLE  | varchar(35)  | NO   |     | NULL    |       |
| MIN_SALARY | decimal(6,0) | YES  |     | NULL    |       |
| MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+;
use practice;
create table job_history2(
	employee_id int unique,
	start_date date,
    end_date date,
    job_id int not null,
    department_id int,
    foreign key (job_id) references job2(job_id)
    );
describe job2;

-- 15. Write a MySQL query to create a table employees including columns employee_id, first_name, last_name, email,
-- phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, 
-- the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id 
-- and manager_id columns contain only those unique combination values, which combinations are exists in the departments table.
-- Assume the structure of departments table below.
+-----------------+--------------+------+-----+---------+-------+
| Field           | Type         | Null | Key | Default | Extra |
+-----------------+--------------+------+-----+---------+-------+
| DEPARTMENT_ID   | decimal(4,0) | NO   | PRI | 0       |       |
| DEPARTMENT_NAME | varchar(30)  | NO   |     | NULL    |       |
| MANAGER_ID      | decimal(6,0) | NO   | PRI | 0       |       |
| LOCATION_ID     | decimal(4,0) | YES  |     | NULL    |       |
+-----------------+--------------+------+-----+---------+-------+;
create table department(
	department_id decimal(4,0)not null default 0,
    department_name varchar(30) not null,
    manager_id decimal(6,0) not null default 0,
    location decimal(4,0),
    primary key(department_id,manager_id)
    );
describe department;
create table employees2(
employee_id int primary key not null,
first_name text,
last_name text,
email varchar(30),
phone_number varchar(12),
hire_date date,
job_id int,
salary int,
commission float,
manager_id decimal(6,0) not null,
department_id decimal(4,0)not null,
foreign key (department_id,manager_id) references department(department_id,manager_id)
);

-- 16. Write a MySQL query to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date,
-- job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time
-- of insertion, and the foreign key column department_id, reference by the column department_id of departments table, can contain only those values 
-- which are exists in the departments table and another foreign key column job_id, referenced by the column job_id of jobs table, 
-- can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables.
+-----------------+--------------+------+-----+---------+-------+  
| Field           | Type         | Null | Key | Default | Extra |  
+-----------------+--------------+------+-----+---------+-------+
| DEPARTMENT_ID   | decimal(4,0) | NO   | PRI | 0       |       |
| DEPARTMENT_NAME | varchar(30)  | NO   |     | NULL    |       |
| MANAGER_ID      | decimal(6,0) | YES  |     | NULL    |       |
| LOCATION_ID     | decimal(4,0) | YES  |     | NULL    |       |
+-----------------+--------------+------+-----+---------+-------+
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| JOB_ID     | varchar(10)  | NO   | PRI |         |       |
| JOB_TITLE  | varchar(35)  | NO   |     | NULL    |       |
| MIN_SALARY | decimal(6,0) | YES  |     | NULL    |       |
| MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+;
create table employees3(
employee_id int primary key not null,
first_name text,
last_name text,
email varchar(30),
phone_number varchar(12),
hire_date date,
job_id int,
salary int,
commission float,
manager_id decimal(6,0) not null,
department_id decimal(4,0)not null,
foreign key (department_id) references department(department_id),
foreign key(job_id) references job2(job_id)
);


-- 17. Write a MySQL query to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, 
-- the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, 
-- referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. 
-- The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON UPDATE CASCADE action allows 
-- you to perform cross-table update and ON DELETE RESTRICT action reject the deletion. The default action is ON DELETE RESTRICT.
-- Assume that the structure of the table jobs and InnoDB Engine have been used to create the table jobs.
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| JOB_ID     | int(11)      | NO   | PRI | NULL    |       |
| JOB_TITLE  | varchar(35)  | NO   |     |         |       |
| MIN_SALARY | decimal(6,0) | YES  |     | 8000    |       |
| MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+;

create table employees4(
employee_id int primary key not null,
first_name text,
last_name text,
email varchar(30),
phone_number varchar(12),
hire_date date,
job_id int,
salary int,
commission float,
manager_id decimal(6,0) not null,
department_id decimal(4,0)not null,
foreign key (job_id) references job2(job_id)
);

-- 18. Write a MySQL query to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, 
-- the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, 
-- referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. 
-- The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE CASCADE that lets you allow 
-- to delete records in the employees(child) table that refer to a record in the jobs(parent) table when the record in the parent table is deleted 
-- and the ON UPDATE RESTRICT actions reject any updates.
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| JOB_ID     | int(11)      | NO   | PRI | NULL    |       |
| JOB_TITLE  | varchar(35)  | NO   |     |         |       |
| MIN_SALARY | decimal(6,0) | YES  |     | 8000    |       |
| MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+;
create table employees5(
employee_id int primary key not null,
first_name text,
last_name text,
email varchar(30),
phone_number varchar(12),
hire_date date,
job_id int,
salary int,
commission float,
manager_id decimal(6,0) not null,
department_id decimal(4,0)not null,
foreign key (job_id) references job2(job_id)
on delete cascade on update restrict
);

-- 19. Write a MySQL query to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, 
-- the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by 
-- the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create 
-- the tables. The specialty of the statement is that, The ON DELETE SET NULL action will set the foreign key column values in 
-- the child table(employees) to NULL when the record in the parent table(jobs) is deleted, with a condition that the foreign key column in 
-- the child table must accept NULL values and the ON UPDATE SET NULL action resets the values in the rows in the child table(employees) to NULL values
-- when the rows in the parent table(jobs) are updated.

create table employees5(
employee_id int primary key not null,
first_name text,
last_name text,
email varchar(30),
phone_number varchar(12),
hire_date date,
job_id int,
salary int,
commission float,
manager_id decimal(6,0) not null,
department_id decimal(4,0)not null,
foreign key (job_id) references job2(job_id)
on delete cascade on update restrict
);

-- 20. Write a MySQL query to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, 
-- the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by 
-- the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create 
-- the tables. The specialty of the statement is that, The ON DELETE NO ACTION and the ON UPDATE NO ACTION actions will reject the deletion and any updates.

create table employees6(
employee_id int primary key not null,
first_name text,
last_name text,
email varchar(30),
phone_number varchar(12),
hire_date date,
job_id int,
salary int,
commission float,
manager_id decimal(6,0) not null,
department_id decimal(4,0)not null,
foreign key (job_id) references job2(job_id)
ON DELETE NO ACTION 
ON UPDATE NO ACTION
);