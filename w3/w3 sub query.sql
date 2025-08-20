use w3;

-- 1. Write a MySQL query to find the name (first_name, last_name) and the salary of the employees who have a higher salary 
-- than the employee whose last_name='Bull'.

select FIRST_NAME,last_name,SALARY
from employees
where salary>(select salary from employees where LAST_NAME='Bull');

-- 2. Write a MySQL query to find the name (first_name, last_name) of all employees who works in the IT department.

select first_name,last_name
from employees
where department_id in (select department_id from departments where DEPARTMENT_NAME='IT');

-- 3. Write a MySQL query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department.

select first_name,last_name
from employees 
where manager_id is not null and department_id in (
			select department_id 
            from departments 
            where location_id in (
					select location_id 
                    from locations 
                    where country_id='US'
                    )
			)
;

-- 4. Write a MySQL query to find the name (first_name, last_name) of the employees who are managers.

select first_name,last_name
from employees
where employee_id in (select manager_id from employees);

-- 5. Write a MySQL query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.

select first_name,last_name
from employees
where salary > (select avg(salary) from employees);

-- 6. Write a MySQL query to find the name (first_name, last_name), and salary of the employees 
-- whose salary is equal to the minimum salary for their job grade.

select first_name,last_name
from employees as e
where salary = (select min_salary from jobs where e.job_id=jobs.job_id);

-- 7. Write a MySQL query to find the name (first_name, last_name), and salary of the employees 
-- who earns more than the average salary and works in any of the IT departments.

select first_name,last_name
from employees
where department_id in(
			select department_id 
            from departments 
            where department_name like 'IT%')
	and salary >(select avg(salary) from employees);

-- 8. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell.

select first_name,last_name,salary
from employees
where salary>(select salary from employees where last_name='Bell');


-- 9. Write a MySQL query to find the name (first_name, last_name), and salary of the employees 
-- who earn the same salary as the minimum salary for all departments.

select first_name,last_name,salary,department_id
from employees as e1
where salary = (select min(salary) from employees as e2 group by department_id having e1.department_id=e2.department_id);

-- 10. Write a MySQL query to find the name (first_name, last_name), and salary of the employees 
-- whose salary is greater than the average salary of each department.

select first_name,last_name,salary
from employees as e1
where salary > (select avg(salary) from employees as e2 where e1.department_id=e2.department_id);

-- 11. Write a MySQL query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher 
-- than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest.

select first_name,last_name,salary
from employees
where salary> (select max(salary) from employees where job_id = 'SH_CLERK')
order by salary;

-- 12. Write a MySQL query to find the name (first_name, last_name) of the employees who are not supervisors.

select first_name,last_name
from employees
where employee_id not in (select manager_id from employees);

-- 13. Write a MySQL query to display the employee ID, first name, last name, and department names of all employees.

select employee_id,first_name,last_name,(select department_name from departments as d where e.department_id=d.department_id) as department
from employees as e;

-- 14. Write a MySQL query to display the employee ID, first name, last name, salary of all employees 
-- whose salary is above average for their departments.

select employee_id,first_name,last_name,salary
from employees e1
where salary>(select avg(salary) from employees e2 where e1.department_id=e2.department_id);

-- 15. Write a MySQL query to fetch even numbered records from employees table.

select *
from employees
where employee_id%2=0;

-- 16. Write a MySQL query to find the 5th maximum salary in the employees table.

select salary 
 from (select *,dense_rank () over(order by salary desc)as r
from employees) as a
where r=5;

select distinct salary
from employees
order by salary desc
limit 1 offset 4;

select min(salary)
from (select distinct salary from employees order by salary desc limit 5) as a;

-- 17. Write a MySQL query to find the 4th minimum salary in the employees table.

select distinct salary
from employees
order by salary
limit 1 offset 3;

-- 18. Write a MySQL query to select last 10 records from a table.

select *
from (select * from employees order by employee_id desc limit 10)as a
order by employee_id;


-- 19. Write a MySQL query to list the department ID and name of all the departments where no employee is working.

select department_id,department_name
from departments
where department_id not in (select distinct department_id from employees);

-- 20. Write a MySQL query to get 3 maximum salaries.

select distinct salary
from employees
order by salary desc
limit 3;

-- 21. Write a MySQL query to get 3 minimum salaries.

select distinct salary
from employees
order by salary 
limit 3;

-- 22. Write a MySQL query to get nth max salaries of employees.

select distinct salary
from employees
order by salary desc
limit 1 offset n-1;