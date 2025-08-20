USE DB;

SELECT *
FROM superstore;

-- Q1. What is the difference between COUNT(*), COUNT(expression), 
		-- and COUNT(DISTINCT expression)?
        
-- Q2. Do basic Exploratory data analysis (EDA) of the dataset. For example-
		-- How many rows do we have?
        -- How many orders were placed?
		-- How many customers do we have?
		-- How much profit did we make in total?
		-- How many days orders were placed?
		-- What was the highest and lowest sales per quantity ?
        
-- Q3- Write a query to get total profit, first order date and latest order date for each category

select sum(profit) as total,min(order_date) as f_O,max(order_date) as L_o
from store;

-- Q4. How many orders were placed on each day?

select order_date,count(*)
from store
group by order_date;

-- Q5. How many orders were placed for each type of Ship mode? 
    
    select Ship_mode ,count(*)
    from store
    group by ship_mode;
    
-- Q6. How many orders were placed on each day for Furniture Category?

select order_date,count(*)
from store
where category='Furniture'
group by order_date;

-- Q7. How many orders were placed per day 
		-- for the days when sales was greater than 1000?

select order_date,count(*)
from store
where sales>1000
group by order_date;

-- Q8. What will below codes return? What is the issue here?
		SELECT category, sub_category, SUM(profit) AS profit
		FROM store
		GROUP BY category,sub_category;

		SELECT category, SUM(profit) AS profit
		FROM superstore
		GROUP BY category, sub_category;
	
-- Q9. How many Sub categories and products are there for each categories?

select count(distinct(sub_category)),count(distinct(product_id))
from store
group by category;

-- Q10. Find sales, profit and Quantites sold for each categories.

select sum(sales),sum(profit),sum(quantity)
from store
group by category;

-- Q11. Write a query to find top 5 sub categories in west region by total quantity sold

select sub_category
from store
where region='west'
group by sub_category
order by sum(quantity) desc
limit 5;

-- Q12. Write a query to find total sales for each region and ship mode combination for orders in year 2020

select region,ship_mode,sum(sales)
from store
where year(order_date)=2020
group by region,ship_mode;

-- Q13. Find quantities sold for combination of each category and subcategory

select category,sub_category,count(distinct(order_id))
from store
group by category,sub_category;

-- Q14. Find quantities sold for combination of each category and subcategory 
		-- when quantity sold is greater than 2

select category,sub_category,sum(quantity)
from store
where quantity>2
group by category,sub_category;

-- Q15. Find quantities sold for combination of each category and subcategory 
		-- when quantity sold in the combination is greater than 1000

select category,sub_category,sum(quantity)
from store
group by category,sub_category
having sum(quantity)>1000
order by sum(quantity);

-- Q16. Write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category

select sub_category,avg(profit),max(profit)/2
from store
group by sub_category
having avg(profit)>(max(profit)/2);

-- Q17. Create the exams table with below script
-- Write a query to find students who have got same marks in Physics and Chemistry.

CREATE TABLE exams 
(student_id int, 
subject varchar(20), 
marks int);

INSERT INTO exams VALUES 
(1,'Chemistry',91),
(1,'Physics',91),
(1,'Maths',92),
(2,'Chemistry',80),
(2,'Physics',90),
(3,'Chemistry',80),
(3,'Maths',80),
(4,'Chemistry',71),
(4,'Physics',54),
(5,'Chemistry',79);

select student_id
from exams
where subject!='Maths'
group by student_id
having count(distinct (marks))=1 and count(marks)=2;
