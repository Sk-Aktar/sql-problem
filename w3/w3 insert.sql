use practice;
-- 1. Write a MySQL query to insert a record with your own value into the table countries against each columns.
-- Here is the structure of the table "countries".
+--------------+---------------+------+-----+---------+-------+
| Field        | Type          | Null | Key | Default | Extra |
+--------------+---------------+------+-----+---------+-------+
| COUNTRY_ID   | varchar(2)    | YES  |     | NULL    |       |
| COUNTRY_NAME | varchar(40)   | YES  |     | NULL    |       |
| REGION_ID    | decimal(10,0) | YES  |     | NULL    |       |
+--------------+---------------+------+-----+---------+-------+	

create table countries (
	country_id varchar(2),
    country_name varchar(40),
    region_id decimal(10,0)
    );
insert into countries values
	(12,'india',123),
    (13,'saudi',124),
    (14,'iran',125);
select * from countries;

-- 2. Write a MySQL query to insert one row into the table countries against the column country_id and country_name.
-- Here is the structure of the table "countries".
+--------------+---------------+------+-----+---------+-------+
| Field        | Type          | Null | Key | Default | Extra |
+--------------+---------------+------+-----+---------+-------+
| COUNTRY_ID   | varchar(2)    | YES  |     | NULL    |       |
| COUNTRY_NAME | varchar(40)   | YES  |     | NULL    |       |
| REGION_ID    | decimal(10,0) | YES  |     | NULL    |       |
+--------------+---------------+------+-----+---------+-------+	;
create table countries2(
	country_id varchar(2),
    country_name varchar(40),
    region_id decimal(10,0)
);
insert into countries2 value (12,'india',2524);

3. Write a MySQL query to create duplicate of countries table named country_new with all structure and data.
Here is the structure of the table "countries".
+--------------+---------------+------+-----+---------+-------+
| Field        | Type          | Null | Key | Default | Extra |
+--------------+---------------+------+-----+---------+-------+
| COUNTRY_ID   | varchar(2)    | YES  |     | NULL    |       |
| COUNTRY_NAME | varchar(40)   | YES  |     | NULL    |       |
| REGION_ID    | decimal(10,0) | YES  |     | NULL    |       |
+--------------+---------------+------+-----+---------+-------+	;
create table countries3 like countries2;
describe countries3;

-- 4. Write a MySQL query to insert NULL values against region_id column for a row of countries table.

insert into countries value(1,'india',null	);

-- 5. Write a MySQL query to insert 3 rows by a single insert statement.

insert into countries values
	(1,'india',501),
    (2,'japan',502),
    (3,'korea',503);
    
-- 6. Write a MySQL query insert rows from country_new table to countries table.
-- Here is the rows for country_new table. Assume that, the countries table is empty.
+------------+--------------+-----------+
| COUNTRY_ID | COUNTRY_NAME | REGION_ID |
+------------+--------------+-----------+
| C0001      | India        |      1001 |
| C0002      | USA          |      1007 |
| C0003      | UK           |      1003 |
+------------+--------------+-----------+;
truncate countries2;
create table countries2 like countries;
insert into countries2  select * from countries;
-- create table countries2 as select * from countries;
select * from countries2;
select * from countries;

-- 7. Write a MySQL query to insert one row in jobs table to ensure that no duplicate value will be entered in the job_id column.

create table jobs(
	job_id int unique auto_increment,
    job_title text,
    salary int);
insert into jobs value(1,'se',20000),(2,'po',25000),(3,'sd',30000);

9. Write a MySQL query to insert a record into the table countries to ensure that, a country_id and region_id combination will be entered once in the table.

create table countries (
	country_id int ,
    country_name int,
    region_id text,
    primary key(country_id,region_id)
    );

-- 10. Write a MySQL query to insert rows into the table countries in which the value of country_id column will be unique and auto incremented.

create table countries (
	country_id int unique auto_increment,
    country_name int,
    region_id text
    );

-- 11. Write a MySQL query to insert records into the table countries to ensure that the country_id column will not contain any duplicate data 
-- and this will be automatically incremented and the column country_name will be filled up by 'N/A' if no value assigned for that column.

create table country(
	country_id int unique auto_increment,
    country_name text default 'N/A',
    region text
    );
    
-- 12. Write a MySQL query to insert rows in the job_history table in which one column job_id is containing those values 
-- which are exists in job_id column of jobs table.

create table job_history3 (
emp_id int primary key,
start_date date,
end_date date,
job_id int,
foreign key (job_id) references job2(job_id)
);

-- 13. Write a MySQL query to insert rows into the table employees in which a set of columns department_id and manager_id contains a unique value 
-- and that combined values must have exists into the table departments.

create table employees8(
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

-- 14. Write a MySQL query to insert rows into the table employees in which a set of columns department_id and job_id contains the values 
-- which must have exists into the table departments and jobs.

create table employees9(
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
foreign key (job_id) references job2(job_id)
);
 