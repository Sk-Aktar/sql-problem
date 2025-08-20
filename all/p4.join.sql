USE Sample_db;

CREATE TABLE IF NOT EXISTS employees(
emp_id INT,
emp_name VARCHAR(20),
department_id INT,
salary INT,
manager_id INT,
emp_age INT
);

SELECT * FROM employees;

INSERT INTO employees VALUES 
(1, 'Ankit', 100, 10000, 4, 30),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6,55),
(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),
(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51),
(10, 'Rakesh',300,7000,6,50);

CREATE TABLE department(
dep_id INT,
dep_name VARCHAR(20)
);

INSERT INTO department VALUES
(100, 'Analytics'),
(300, 'IT');

-- Q1. Given EMPLOYEES and DEPARTMENT table. How many rows will be returned after using left, right, inner, full outer joins
    
    select *
    from employees as e
    inner join department as d
    on e.department_id=d.dep_id;
    
	select *
    from employees as e
    left join department as d
    on e.department_id=d.dep_id;
	select *
    from employees as e
    right join department as d
    on e.department_id=d.dep_id;
    
	select *
    from employees as e
    left join department as d
    on e.department_id=d.dep_id
    union
    select *
    from employees as e
    right join department as d2
    on e.department_id=d2.dep_id;
    
-- Q2. Create new column for department name in the EMPLOYEES table

select e.*,d.dep_name
from employees as e
left join department as d
on e.department_id=d.dep_id;

-- Q3. In case if the department does not exist, the default department should be "NA".

select e.*,ifnull(dep_name,'NA')
from employees as e
left join department as d
on e.department_id=d.dep_id;

-- Q4. Find employees which are in Analytics department.

select emp_name
from employees as e
left join department as d
on e.department_id=d.dep_id
where dep_name='Analytics';

-- Q5. Find the managers of the employees

select e.*,e2.emp_name
from employees as e 
left join employees as e2
on e.manager_id=e2.emp_id;

-- Q6. Find all employees who have the salary more than their manager salary.

select e1.*,e2.salary
from employees e1 join employees e2
on e1.manager_id=e2.emp_id
where e1.salary>e2.salary;

-- Q7. Find number of employees in each department

select dep_name ,count(*)
from employees as e left join department as d
on e.department_id=d.dep_id
group by dep_name
having dep_name is not null;

-- Q8. Find the highest paid employee in each department

select dep_name ,max(salary)
from employees as e left join department as d
on e.department_id=d.dep_id
group by dep_name
having dep_name is not null;

-- Q9. Which department recieves more salary

select dep_name
from employees as e left join department as d
on e.department_id=d.dep_id
group by dep_name
having sum(salary)=(select max(sal)
from (select sum(salary) as sal
from employees as e left join department as d
on e.department_id=d.dep_id
group by dep_name
having sum(salary) and dep_name is not null)as a)
;

-- Q10. What is cross join? What it can be used for?

select *
from employees
cross join department;