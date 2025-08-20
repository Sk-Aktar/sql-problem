USE DB;

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
truncate table useractivity;
-- Get the second most recent activity. If there is only one activity then return that one also.

select username,activity,startdate,enddate
from (select *,dense_rank() over (order by startdate desc)as r,
count(*) over (partition by username)as c
from useractivity) as a
where r=2 or c=1;
;
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
from (select *,lead(marks) over(partition by student_id) as n
		from exams
		where subject in ('Chemistry','Physics'))as a
where marks=n;

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

select city
from (SELECT *,cast(dense_rank() over(partition by city order by days)as signed) - cast(dense_rank() over(partition by city order by cases)as signed)as r
fROM covid) as c 
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
(5,'John Mike','Subject2',90,2,'2022-11-02'),
(1,'John Deo','Subject2',60,1,'2022-01-02'),
(2,'Max Ruin','Subject2',84,1,'2022-01-02'),
(2,'Max Ruin','Subject3',29,3,'2022-01-03'),
(5,'John Mike','Subject3',98,2,'2022-11-02');

truncate students;
SELECT * FROM students;
-- Write a SQL query to get the list of students who scored above average marks in each subject

with cte as (select *,avg(marks) over(partition by subject)as a from students),
	cte2 as (select studentid from cte where marks>a ),
    cte3 as (select studentid,count(*)as x from cte group by studentid),
    cte4 as (select studentid,count(*)as y from cte2 group by studentid)
    select cte3.studentid 
    from cte3
    join cte4
    on cte3.studentid=cte4.studentid
    where cte3.x=cte4.y;    

-- Write a SQL query to get the percentage of students who scored 90 or above in any subject amongst total students
    
   with cte as (select studentid,max(marks) from students where marks>=90 group by studentid)
   select count(*)*100.0/(select count(distinct studentid) from students) as percent from cte;

-- Write a SQL query to get the second highest and second lowest marks for each subject

with cte as (select subject,studentid,marks,dense_rank() over(partition by subject order by marks)as l,
dense_rank() over(partition by subject order by marks desc)as h from students)
select subject,
(select marks from cte as e where h=2 and c.subject=e.subject)as 2ndhigh,
(select marks from cte as d where l=2 and c.subject=d.subject)as 2ndlow
from cte as c
group by subject;

-- For each student and test, identify if their marks increased or decreased from the previous test.

with cte as(select studentid,testid,marks,testdate,lag(marks)over(partition by studentid order by testid)as pre
from students)
select studentid,testid,marks,testdate,case 
	when pre>marks then 'increment'
    when marks>pre then 'decrement'
    else 'first test'
end as status
from cte
;

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

SELECT * FROM icc_world_cup;

-- Create three columns - Matches_played, No_of_wins, No_of_losses

with cte as(
select team_1,if(team_1=winner,1,0) as won
from icc_world_cup
union all
select team_2,if(team_2=winner,1,0) as won
from icc_world_cup)
select team_1 as team,count(*)as match_P,sum(won)as won,count(*)-sum(won)as loss
from cte 
group by team_1;

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
-- Write a query to find number of gold medal per swimmers for swimmers who only won gold medals.

select gold,count(*)as times
from events
where gold not in (select silver from events union select bronze from events)
group by gold;

-- Subquery
-- Having by, with cte

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
select * from emp_salary;
-- Write a SQL query to return all employees whose salary is same in same department
	-- Using CTE
    
with cte as(select dept_id,salary from emp_salary group by dept_id,salary having count(*)>1)
select dept_id,name,salary from emp_salary as e where salary=(select salary from cte as c where c.dept_id=e.dept_id);

	-- Using joins(inner join and left join)

select e.dept_id,e.name,e.salary
from emp_salary as e
join emp_salary as e2
on e.dept_id=e2.dept_id and e.salary=e2.salary and e.emp_id!=e2.emp_id
;
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
select * from emp_2021;
select * from emp_2020;
-- Find the change in employee status.
	 -- Types of status can only be - Promoted, No change, Resigned, New
    
with cte as (
select * ,case when designation='Trainee' then 1 
			when designation='Developer' then 2 
            when designation='Senior Developer' then 3 
            when designation='Manager' then 4
            else null
            end as p
from emp_2020),
cte2 as (select * ,case when designation='Trainee' then 1 
			when designation='Developer' then 2 
            when designation='Senior Developer' then 3 
            when designation='Manager' then 4
            else null
            end as f
from emp_2021),
cte3 as(select c.emp_id,c.designation as d1,c2.designation as d2,p,f
from cte as c
left join cte2 as c2
on c.emp_id=c2.emp_id
union
select c2.emp_id,c.designation as d1,c2.designation as d2,p,f
from cte as c
right join cte2 as c2
on c.emp_id=c2.emp_id)
select emp_id,case when f>p then 'promoted'
                    when d1 is null then 'new'
                    when d2 is null then 'resigned'
                    else 'no change'
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

-- Write a SQL Query to find the total number of people present 
	-- inside the hospital
-- 1-out, 2-in, 3-in, 4-in, 5-out

with cte as(select emp_id,max(time)as m
from hospital as a
group by emp_id),
cte2 as (
select h.emp_id,case when h.action="out" then 0 else 1 end as q
from hospital as h join cte as c
on h.emp_id=c.emp_id and h.time=c.m)
select sum(q) as no_of_emp
from cte2;
