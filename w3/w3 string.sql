use w3;
-- 1. Write a MySQL query to get the job_id and related employees id.

select job_id,group_concat(EMPLOYEE_ID,' ') as emp
from employees
group by job_id;

-- 2. Write a MySQL query to update the portion of the phone_number in the employees table, 
-- within the phone number the substring '124' will be replaced by '999'.

select replace(phone_number,124,999)
from employees;

-- 3. Write a MySQL query to get the details of the employees where the length of the first name greater than or equal to 8.

select *
from employees
where length(FIRST_NAME)>=8;

-- 4. Write a MySQL query to display leading zeros before maximum and minimum salary.

SELECT job_id,lpad(min_salary,6,'0')as min,concat('0',max_salary)as max
FROM jobs;

-- 5. Write a MySQL query to append '@example.com' to email field.

select concat(email,'@example.com')
from employees;

-- 6. Write a MySQL query to get the employee id, first name and hire month.

select employee_id,first_name,monthname(hire_date)
from employees;

-- 7. Write a MySQL query to get the employee id, email id (discard the last three characters).

select employee_id,substr(email,1,length(email)-3)
from employees;

-- 8. Write a MySQL query to find all employees where first names are in upper case.

select *
from employees
where binary first_name=upper(first_name);

-- 9. Write a MySQL query to extract the last 4 character of phone numbers.

select substr(phone_number,length(phone_number)-3,4)
from employees;

-- 10. Write a MySQL query to get the last word of the street address.

select substr(street_address,length(street_address),1)
from locations;

-- 11. Write a MySQL query to get the locations that have minimum street length.

select *
from locations
where length(street_address)=(select min(length(street_address))from locations);

-- 12. Write a MySQL query to display the first word from those job titles which contains more than one words.

select substr(job_title,1,instr(job_title,' ')-1) 
from jobs
where instr(job_title,' ')-1>1;

-- 13. Write a MySQL query to display the first name and last name for employees 
-- where first occurrence of last name contain character 'c' after 2nd position.

select first_name,last_name
from employees
where last_name like '__%c%';

-- 14. Write a MySQL query that displays the first name and the length of the first name for all employees 
-- whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees first names.

select first_name,length(first_name)
from employees
where first_name like 'A%' or first_name like 'J%' or first_name like 'M%'
order by first_name;

-- 15. Write a MySQL query to display the first name and salary for all employees. Format the salary to be 10 characters long, 
-- left-padded with the $ symbol. Label the column SALARY.

select first_name,lpad(lpad(salary,9,'0'),10,'$')
from employees;

-- 16. Write a MySQL query to display the first eight characters of the employees first names and indicates the amounts of their salaries with '$' sign.
-- Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary.

select left(first_name,8),repeat('$',salary/1000)
from employees
order by salary desc;

-- 17. Write a MySQL query to display the employees with their code, first name, last name and hire date 
-- who hired either on seventh day of any month or seventh month in any year.

select employee_id,last_name,hire_date
from employees
where  month(hire_date)=7 or day(hire_date)=7;