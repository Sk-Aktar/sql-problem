-- 1. Write a SQL statement to change the email column of employees table with 'not available' for all employees.

update employees 
set email='not available';

-- 2. Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for all employees.

update employees 
set email='not available',comission_pct=0.10;

-- 3. Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for those employees 
-- whose department_id is 110.

update employees 
set email='not available',comission_pct=0.10
where department_id=110;

-- 4. Write a SQL statement to change the email column of employees table with 'not available' for those employees whose department_id is 80 
-- and gets a commission_pct is less than .20

update employees 
set email='not available'
where department_id=80 and comission_pct<0.20;

-- 5. Write a SQL statement to change the email column of employees table with 'not available' for those employees who belongs to the 'Accouning' department.

update employees 
set email='not avilable'
where department_id=(select department_id from departments where department_name='Accounting');

-- 6. Write a SQL statement to change salary of employee to 8000 whose ID is 105, if the existing salary is less than 5000.

update employees  
set salary=8000.00
where employee_id=105 and salary>5000;

-- 7. Write a SQL statement to change job ID of employee which ID is 118, to SH_CLERK if the employee belongs to department, 
-- which ID is 30 and the existing job ID does not start with SH.

update employees 
set job_id ='SH_CLERK'
where employee_id=118 and department_id=30 and job_id not like 'SH%';

-- 8. Write a SQL statement to increase the salary of employees under the department 40, 90 and 110 according to the company rules that,
-- salary will be increased by 25% for the department 40, 15% for department 90 and 10% for the department 110 and 
-- the rest of the departments will remain same.

update employees
set salary = case 
				when department_id=40 then salary+salary*0.25
                when department_id=90 then salary+salary*0.15
                when department_id=110 then salary+salary*0.1
                else salary
			end
;

-- 9. Write a SQL statement to increase the minimum and maximum salary of PU_CLERK by 2000 as well as the salary for those employees by 20% 
-- and commission percent by .10.

update jobs ,employees
set jobs.min_salary=min_salary+2000,
	jobs.max_salary=max_salary+2000,
    employees.salary=salary+salary*0.2,
    employees.comission_pct=comission_pct+0.10
where jobs.job_id='PU_CLERK' and employees.job_id='PU_CLERK';
