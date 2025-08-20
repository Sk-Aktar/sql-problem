USE Sample_DB;

CREATE TABLE UserActivity
(
username VARCHAR(20) ,
activity VARCHAR(20),
startDate DATE,
endDate DATE
);

INSERT INTO UserActivity VALUES 
('Alice','Travel','2020-02-12','2020-02-20'),
('Alice','Dancing','2020-02-21','2020-02-23'),
('Alice','Travel','2020-02-24','2020-02-28'),
('Bob','Travel','2020-02-11','2020-02-18');

-- Get the second most recent activity. If there is only one activity then return that one also.

select username,activity
from (select *,dense_rank()over(partition by username order by startDate desc)as rn,
count(*)over(partition by username)as c from useractivity) as a
where rn=2 or c=1;


-------------------------------------------------------------


CREATE TABLE exams (
	student_id INT, 
	subject VARCHAR(20), 
	marks INT
	);

INSERT INTO exams VALUES 
(1,'Chemistry',91),
(1,'Physics',91),
(1,'Maths',81),
(2,'Chemistry',80),
(2,'Physics',90),
(3,'Chemistry',80),
(4,'Chemistry',71),
(4,'Physics',54),
(4,'Maths',64);

-- Find students with same marks in Physics and Chemistry
select student_id
from (select *,lag(marks)over(partition by student_id)as pre
from (select * from exams where subject!='Maths') as a)as b
where marks=pre;

--------------------------------------------------------------------------------

CREATE TABLE covid(
city VARCHAR(50),
days DATE,
cases INT);

INSERT INTO covid VALUES
('DELHI','2022-01-01',100),
('DELHI','2022-01-02',200),
('DELHI','2022-01-03',300),
('MUMBAI','2022-01-01',100),
('MUMBAI','2022-01-02',100),
('MUMBAI','2022-01-03',300),
('CHENNAI','2022-01-01',100),
('CHENNAI','2022-01-02',200),
('CHENNAI','2022-01-03',150),
('BANGALORE','2022-01-01',100),
('BANGALORE','2022-01-02',300),
('BANGALORE','2022-01-03',200),
('BANGALORE','2022-01-04',400);

-- Find cities with increasing number of covid cases every day.
SELECT * FROM covid;

select city
from (select * ,cast(dense_rank()over (partition by city order by cases)as signed)-cast(dense_rank()over(partition by city order by days)as signed) as r
from covid) as a
group by city
having count(distinct r)=1;
-------------------------------------------------------------------------

CREATE TABLE students(
 studentid INT NULL,
 studentname NVARCHAR(255) NULL,
 subject NVARCHAR(255) NULL,
 marks INT NULL,
 testid INT NULL,
 testdate DATE NULL
);

INSERT INTO students VALUES 
(2,'Max Ruin','Subject1',63,1,'2022-01-02'),
(3,'Arnold','Subject1',95,1,'2022-01-02'),
(4,'Krish Star','Subject1',61,1,'2022-01-02'),
(5,'John Mike','Subject1',91,1,'2022-01-02'),
(4,'Krish Star','Subject2',71,1,'2022-01-02'),
(3,'Arnold','Subject2',32,1,'2022-01-02'),
(5,'John Mike','Subject2',61,2,'2022-11-02'),
(1,'John Deo','Subject2',60,1,'2022-01-02'),
(2,'Max Ruin','Subject2',84,1,'2022-01-02'),
(2,'Max Ruin','Subject3',29,3,'2022-01-03'),
(5,'John Mike','Subject3',98,2,'2022-11-02');


-- Write a SQL query to get the percentage of students who scored 90 or above in any subject amongst total students

select concat(round((select count(distinct studentid) from students where marks>90)*100/(select count(distinct studentid) from students)),'%')
 as percentage;

-- Write a SQL query to get the second highest and second lowest marks for each subject

WITH cte as (select *,dense_rank()over(partition by subject order by marks)as l,dense_rank()over(partition by subject order by marks desc)as h from students)
select subject,(select marks from cte as b where a.subject=b.subject and l=2)as 2ndlow,(select marks from cte as c where a.subject=c.subject and h=2)as 2ndhigh
from cte as a
group by subject;
----------------------------------------------------------------

CREATE TABLE icc_world_cup
(
Team_1 VARCHAR(20),
Team_2 VARCHAR(20),
Winner VARCHAR(20)
);

INSERT INTO icc_world_cup values
('India','SL','India'),
('SL','Aus','Aus'),
('SA','Eng','Eng'),
('Eng','NZ','NZ'),
('Aus','India','India');

with cte as(
select team_1
from icc_world_cup
union all
select team_2
from icc_world_cup),
cte2 as(select team_1 as team,count(*)as mp from cte group by team_1)
select team,mp,ifnull(w,0)as w,mp-ifnull(w,0) as l
from cte2 as d
left join (select winner,count(*) as w from icc_world_cup group by winner)as f
on d.team=f.winner;
-----------------------------------------------------------------

CREATE TABLE events (
ID INT,
event VARCHAR(255),
YEAR INt,
GOLD VARCHAR(255),
SILVER VARCHAR(255),
BRONZE VARCHAR(255)
);

INSERT INTO events VALUES 
(1,'100m',2016, 'Amthhew Mcgarray','donald','barbara'),
(2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith'),
(3,'500m',2016, 'Charles','Nichole','Susana'),
(4,'100m',2016, 'Ronald','maria','paula'),
(5,'200m',2016, 'Alfred','carol','Steven'),
(6,'500m',2016, 'Nichole','Alfred','Brandon'),
(7,'100m',2016, 'Charles','Dennis','Susana'),
(8,'200m',2016, 'Thomas','Dawn','catherine'),
(9,'500m',2016, 'Thomas','Dennis','paula'),
(10,'100m',2016, 'Charles','Dennis','Susana'),
(11,'200m',2016, 'jessica','Donald','Stefeney'),
(12,'500m',2016,'Thomas','Steven','Catherine');
select * from events;
-- PUSH YOUR LIMITS --
-- Write a query to find number of gold medal per swimmers for swimmers who only won gold medals.
-- Subquery

select gold,count(*)as total
from (select * from events where gold not in (select SILVER from events) and gold not in (select bronze from events)) as a
group by gold;

-- Having by, with cte

with cte as(select silver from events union select BRONZE from events)
select gold,count(*)
from events
group by gold
having gold not in (select silver from cte);
----------------------------------------------------------------


CREATE TABLE emp_salary
(
    emp_id INTEGER  NOT NULL,
    name VARCHAR(20)  NOT NULL,
    salary VARCHAR(30),
    dept_id INTEGER
);

INSERT INTO emp_salary VALUES
(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

-- Write a SQL query to return all employees whose salary is same in same department
	-- Using CTE
    
    with cte as(select *,lag(salary) over(partition by dept_id order by salary)as pre from emp_salary )
    select emp_id ,dept_id,salary
    from cte as c
    where salary=(select salary from cte as c2 where salary=pre and c.dept_id=c2.dept_id);
    
	-- Using joins(inner join and left join)

select e1.emp_id,e1.dept_id,e1.salary
from emp_salary as e1
join emp_salary as e2
on e1.dept_id=e2.dept_id and e1.salary=e2.salary and e1.emp_id!=e2.emp_id;

----------------------------------------------------------------------

CREATE TABLE emp_2020
(
emp_id INT,
designation VARCHAR(20)
);

CREATE TABLE emp_2021
(
emp_id INT,
designation VARCHAR(20)
);

INSERT INTO emp_2020 VALUES 
(1,'Trainee'), 
(2,'Developer'),
(3,'Senior Developer'),
(4,'Manager');

INSERT INTO emp_2021 VALUES 
(1,'Developer'), 
(2,'Developer'),
(3,'Manager'),
(5,'Trainee');

-- Find the change in employee status.Types of status can only be - Promoted, No change, Resigned, New

with cte as (SELECT *,case when designation='Trainee' then 1
				when designation='Developer' then 2
                when designation='Senior Developer' then 3
                when designation='Manager' then 4
                else 0
                end as p
FROM emp_2020),
cte2 as (SELECT *,case when designation='Trainee' then 1
				when designation='Developer' then 2
                when designation='Senior Developer' then 3
                when designation='Manager' then 4
                else 0
                end as p
FROM emp_2021),
cte3 as(select c.emp_id,c.p,c2.p as f
from cte as c
left join cte2 as c2
on c.emp_id=c2.emp_id
union
select c2.emp_id,c.p,c2.p as f
from cte as c
right join cte2 as c2
on c.emp_id=c2.emp_id)
select emp_id,case when f>p then 'promoted'
				when p is null then 'new'
                when f is null then 'resigned'
                else 'No change'
                end as status
from cte3;

------------------------------------------------------------------


CREATE TABLE hospital ( 
emp_id INT,
action VARCHAR(10),
time DATETIME);

INSERT INTO hospital VALUES 
('1', 'in', '2019-12-22 09:00:00'),
('1', 'out', '2019-12-22 09:15:00'),
('2', 'in', '2019-12-22 09:00:00'),
('2', 'out', '2019-12-22 09:15:00'),
('2', 'in', '2019-12-22 09:30:00'),
('3', 'out', '2019-12-22 09:00:00'),
('3', 'in', '2019-12-22 09:15:00'),
('3', 'out', '2019-12-22 09:30:00'),
('3', 'in', '2019-12-22 09:45:00'),
('4', 'in', '2019-12-22 09:45:00'),
('5', 'out', '2019-12-22 09:40:00');

SELECT * FROM hospital;

-- Write a SQL Query to find the total number of people present inside the hospital
-- 1-out, 2-in, 3-in, 4-in, 5-out

with cte as (select emp_id,action,count(*)as c from hospital group by emp_id,action)
select sum(x)as total
from (select emp_id,coalesce((select c from cte as a where a.emp_id=c.emp_id and action='in'),0)-
coalesce((select c from cte as b where b.emp_id=c.emp_id and action ='out'),0) as x
from cte as c
group by emp_id) as f
where x>0;