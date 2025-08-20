use w3;
-- 1. Write a MySQL query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.

select DEPARTMENT_NAME,l.location_id,street_address,city,state_province,country_name
from locations as l
join departments as d
on l.LOCATION_ID=d.LOCATION_ID
join countries as c
on l.COUNTRY_ID=c.COUNTRY_ID
;

-- 2. Write a MySQL query to find the name (first_name, last name), department ID and name of all the employees.

select first_name,last_name,e.department_id,department_name
from employees as e
join departments as d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID;

-- 3. Write a MySQL query to find the name (first_name, last_name), job, department ID and name of the employees who works in London.

select first_name,last_name,job_title,e.department_id,department_name
from employees as e
join departments as d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID
join jobs as j
on e.JOB_ID=j.JOB_ID
where d.LOCATION_ID=(select location_id from locations where city='London');

-- 4. Write a MySQL query to find the employee id, name (last_name) along with their manager_id and name (last_name).

select e.employee_id,e.last_name,e.MANAGER_ID,e2.LAST_NAME
from employees as e
join employees as e2
on e.MANAGER_ID=e2.EMPLOYEE_ID;

-- 5. Write a MySQL query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'.

select first_name,last_name,hire_date
from employees
where HIRE_DATE>(select hire_date from employees where last_name ='Jones');

-- 6. Write a MySQL query to get the department name and number of employees in the department.

select department_name,count(*)
from employees as e 
join departments as d
on e.DEPARTMENT_ID=d.DEPARTMENT_ID
group by DEPARTMENT_NAME;

-- 7. Write a MySQL query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90.

select employee_id,job_title,timestampdiff(day,start_date,end_date)
from job_history
join jobs
on job_history.job_id=jobs.job_id
where department_id=90;

-- 8. Write a MySQL query to display the department ID and name and first name of manager.

select e.department_id,department_name,e.first_name
from employees as e
join departments as d
on d.manager_id =e.employee_id;

-- 9. Write a MySQL query to display the department name, manager name, and city.

select d.department_name,e.first_name,
(select city from locations as l where l.location_id=d.location_id) as c
from employees as e
join departments as d
on d.manager_id=e.employee_id;

-- 10. Write a MySQL query to display the job title and average salary of employees.

select (select job_title from jobs where jobs.job_id=e.job_id)as j,avg(salary)
from employees as e 
group by job_id;

-- 11. Write a MySQL query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.

select job_title,concat(first_name,' ',last_name),e.salary-j.min_salary as s
from employees as e
join jobs as j
on e.job_id=j.job_id;

-- 12. Write a MySQL query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.

select j.*
from employees as e
join job_history as j
on e.employee_id=j.employee_id
where salary>10000;

-- 13. Write a MySQL query to display department name, name (first_name, last_name), hire date, 
-- salary of the manager for all managers whose experience is more than 15 years.

select department_name,concat(first_name,' ',last_name),hire_date,salary
from employees as e
join departments as d
on d.manager_id=e.employee_id
where year(current_date())-year(hire_date)>15;

with cte as (select distinct(concat(e2.first_name,' ' ,e2.last_name))as n,e2.hire_date,e2.salary,e2.department_id
	from employees as e
	join employees as e2
	on e.manager_id=e2.employee_id)
select d.department_name,cte.n,cte.hire_date,cte.salary
from cte
join departments as d
on d.department_id=cte.department_id
where timestampdiff(year,cte.hire_date,current_date())>15;

select * from employees;