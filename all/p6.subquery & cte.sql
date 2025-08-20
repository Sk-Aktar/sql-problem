USE db;

-- Q1- write a query to find premium customers from superstore data.Premium customers are those 
-- who have done more orders than average no of orders per customer.

select customer_id,Customer_Name
from store
group by customer_id,Customer_Name
having count(distinct order_id)>(select (count(distinct order_id)*1.0/count(distinct customer_id)) as avg_o from store);

-- Q2- write a query to find employees whose salary is more than average salary of employees in their department

with cte as(select department_id,avg(salary) as avg_s
from employees
group by department_id)
select e.*
from employees as e
join cte
on cte.department_id=e.department_id
where salary>avg_s;

-- Q3- write a query to find employees whose age is more than average age of all the employees.
    
    select *
    from employees
    where emp_age>(select avg(emp_age) from employees);

-- Q4- write a query to print emp name, salary and dep id of highest salaried employee in each department 

select emp_name,salary,department_id
from employees as e
where salary = (select max(salary) from employees as d where e.department_id=d.department_id);

select emp_name,salary,department_id
from (select emp_name,salary,department_id,rank() over (partition by department_id order by salary desc)as r from employees )as a
where r=1;

-- Q5- write a query to print emp name, salary and dep id of highest salaried employee overall

select emp_name,salary,department_id
from employees
where salary=(select max(salary) from employees);

-- Q6- write a query to print product id and total sales of highest selling products (by no of units sold) in each category

with cte as (select Category,Product_ID,sum(Quantity)as q,sum(sales) as s,
			rank() over(partition by Category order by sum(Quantity) desc)as r from store group by Category,Product_ID )
select category,Product_ID,s
from cte
where r=1;