use w3;

-- 1. Write a query to display the first day of the month (in datetime format) three months before the current month.

select date_format(adddate(CURRENT_DATE(), INTERVAL -3 MONTH),'01-%m-%y %h-%m-%s');

-- 2. Write a query to display the last day of the month (in datetime format) three months before the current month.

select date_format(last_day(adddate(CURRENT_DATE(), INTERVAL -3 MONTH)),'%d-%m-%y %h-%m-%s');

-- 3. Write a query to get the distinct Mondays from hire_date in employees tables.

select distinct hire_date
from employees
where weekday(hire_date)=1;

-- 4. Write a query to get the first day of the current year.

select date_format(curdate(),'01-01-%Y');

-- 5. Write a query to get the last day of the current year.

select last_day(current_date());

-- 6. Write a query to calculate the age in year.

select timestampdiff(year,'1999-08-06',curdate());

-- 7. Write a query to get the current date in the following format.
-- Sample date : 2014-09-04
-- Output : September 4, 2014

select date_format(curdate(),'%M %e, %Y');

-- 8. Write a query to get the current date in Thursday September 2014 format.
-- Thursday September 2014

select date_format(curdate(),'%W %M %Y');

-- 9. Write a query to extract the year from the current date.

select year(curdate());
select extract(year from curdate());

-- 10. Write a query to get the DATE value from a given day (number in N).
-- Sample days: 730677
-- Output : 2000-07-11

select from_days(730677);

-- 11. Write a query to get the first name and hire date from employees table where hire date between '1987-06-01' and '1987-07-30'

select first_name,hire_date
from employees
where hire_date>'1987-06-01' and hire_date<'1987-07-30' ;

-- 12. Write a query to display the current date in the following format.
-- Sample output: Thursday 4th September 2014 00:00:00

select date_format(now(),'%W %D %M %Y %h %m %s');

-- 13. Write a query to display the current date in the following format.
-- Sample output: 05/09/2014

select date_format(current_date(),'%d/%m/%Y');

-- 14. Write a query to display the current date in the following format.
-- Sample output: 12:00 AM Sep 5, 2014

select date_format(now(),'%h:%m %p %b %e, %Y');

-- 15. Write a query to get the firstname, lastname who joined in the month of June.

select first_name,last_name,hire_date
from employees
where monthname(hire_date)='June';

-- 16. Write a query to get the years in which more than 10 employees joined.

select year(hire_date)
from employees
where timestampdiff(year,hire_date,curdate())>10;

-- 17. Write a query to get first name of employees who joined in 1987.

select first_name
from employees
where year(hire_date)=1987;

-- 18. Write a query to get department name, manager name, and salary of the manager for all managers whose experience is more than 5 years.

select department_name,concat(first_name,' ',last_name)as name,salary
from departments as d
join employees as e
on d.manager_id=e.employee_id
where timestampdiff(year,hire_date,curdate())>5;

-- 19. Write a query to get employee ID, last name, and date of first salary of the employees.

select employee_id,last_name,adddate(hire_date,interval 1 month)
from employees;

-- 20. Write a query to get first name, hire date and experience of the employees.

select first_name,hire_date,hire_date,timestampdiff(year,hire_date,curdate())
from employees;

-- 21. Write a query to get the department ID, year, and number of employees joined.

select department_id,year(hire_date),count(*)
from employees as e
group by department_id,year(hire_date);
