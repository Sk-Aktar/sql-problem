-- 1. Write a query to list the number of jobs available in the employees table.

select count(distinct job_id) from employees;

-- 2. Write a query to get the total salaries payable to employees.

select sum(salary)as total
from employees;

-- 3. Write a query to get the minimum salary from employees table.

select min(salary)
from employees;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer.

select max(salary)
from employees
where job_id='IT_PROG';

-- 5. Write a query to get the average salary and number of employees working the department 90.

select avg(salary),count(*)
from employees
where DEPARTMENT_ID=90;

-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees.

select max(salary),min(salary),avg(salary),sum(salary)
from employees;

-- 7. Write a query to get the number of employees with the same job.

select job_id,count(*)
from employees
group by JOB_ID;

-- 8. Write a query to get the difference between the highest and lowest salaries.

select max(salary)-min(salary)
from employees;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.

select MANAGER_ID,salary
from employees
where salary=(select min(salary) from employees);

-- 10. Write a query to get the department ID and the total salary payable in each department.

select department_id,sum(salary)
from employees
group by DEPARTMENT_ID;

-- 11. Write a query to get the average salary for each job ID excluding programmer.

select job_id,avg(salary)
from employees
group by JOB_ID
having job_id !='IT_PROG';

-- 12. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.

select job_id,sum(salary),max(salary),min(salary),avg(salary)
from employees
where DEPARTMENT_ID=90
group by job_id;

-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.

select job_id,max(salary)
from employees
group by JOB_ID
having max(salary)>=4000;

-- 14. Write a query to get the average salary for all departments employing more than 10 employees.

select DEPARTMENT_ID,avg(salary)
from employees
group by department_id
having count(*)>10;