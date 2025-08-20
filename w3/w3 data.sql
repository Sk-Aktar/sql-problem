use w3;

-- 1. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000.

select first_name,LAST_NAME,salary
from employees
where salary not between 15000 and 10000;

-- 2. Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order.

select FIRST_NAME,LAST_NAME,DEPARTMENT_ID
from employees
where DEPARTMENT_ID=30 or DEPARTMENT_ID=100
order by DEPARTMENT_ID asc;

-- 3. Write a query to display the name (first_name, last_name) and salary for all employees 
-- whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100.

select FIRST_NAME,LAST_NAME,SALARY
from employees
where SALARY not between 10000 and 15000 and DEPARTMENT_ID=30 or DEPARTMENT_ID=100;

-- 4. Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987.

select FIRST_NAME,LAST_NAME,HIRE_DATE
from employees
where year(hire_date)=1987;

-- 5. Write a query to display the first_name of all employees who have both "b" and "c" in their first name.

select FIRST_NAME
from employees
where FIRST_NAME like '%b%' and FIRST_NAME like '%c%';

-- 6. Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer or a Shipping Clerk, 
-- and whose salary is not equal to $4,500, $10,000, or $15,000.

select LAST_NAME,JOB_TITLE,salary
from employees as e
join jobs as j
on e.JOB_ID=j.JOB_ID
where JOB_TITLE='Programmer'or JOB_TITLE='Shipping Clerk' and SALARY not in (4500,10000,15000);

-- 7. Write a query to display the last name of employees whose names have exactly 6 characters.

select LAST_NAME
from employees
where length(last_name)=6;

-- 8. Write a query to display the last name of employees having 'e' as the third character.

select LAST_NAME
from employees
where LAST_NAME like '__e%';

-- 9. Write a query to display the jobs/designations available in the employees table.

select distinct job_id
from employees;

-- 10. Write a query to display the name (first_name, last_name), salary and PF (15% of salary) of all employees.

select first_name,last_name,salary,salary*15/100.0 as pf
from employees;

-- 11. Write a query to select all record from employees where last name in 'BLAKE', 'SCOTT', 'KING' and 'FORD'.

select *
from employees
where last_name in ('BLAKE','SCOTT','KING','FORD');
