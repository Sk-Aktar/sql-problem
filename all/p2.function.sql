USE Sample_DB;

SELECT * FROM superstore;

SELECT row_id, product_name, customer_name,
"NA" as useLEFT,
"NA" as useRIGHT, 
"NA" as useSUBSTR,
"NA" as useLENGTH,
"NA" as useINSTR,
"NA" as useREPLACE,
"NA" as useREVERSE,
"NA" as useCONCAT,
"NA" as useUPPER,
"NA" as useLOWER
FROM superstore;

-- Q1. Change the Category "Office Supplies" to "School Supplies".
select *,replace(category,category,'School Supplies')
from store
where category='Office Supplies';

-- Q2. Change the Category "Office Supplies" to "School Supplies" only when Ship Mode is "Second Class".

select *,replace(category,category,'School Supplies')
from store
where category='Office Supplies' and Ship_mode='Second Class';

-- Q3. Get the first three letters of Customer Name and make them capital.

select upper(left(Customer_Name,3))
from store;

-- Q4. Get the first name of Customer Name. (Hint: Find the occurence of the first space)

select left(Customer_Name,position(' ' in Customer_Name)-1) as first_name
from store;

-- Q5. Get the last name of Customer Name. Get the last word from the Product Name.

select reverse(left(reverse(Customer_Name),position(' ' in reverse(Customer_Name)))) as last_name,right(Product_Name,1) as ri
from store;

-- Q6. Divide Profit by Quantity. 
		-- Did you notice anything strange? What can be done to resolve the issue?

select round(profit*1.0/quantity,2) as per
from store;

-- Q7. Write a query to get records where the length of the Product Name is less than or equal to 10.

select *
from store
where length(Product_Name)<=10;

-- Q8. Get details of records where first name of Customer Name is greater than 4.

select left(Customer_Name,position(' ' in Customer_Name)-1) as first_name
from store
where length(left(Customer_Name,position(' ' in Customer_Name)-1))>4;

-- Q9. Get records from alternative rows.

select *
from store
where Row_Id%2=0;

-- Q10. Create a column to get both Category and Sub Catergory. For example: "Furniture - Bookcases".

select concat(Category,' - ',Sub_category)
from store;

-- Q11. Remove last three characters for the Customer Name.

select customer_name,substr(customer_name,1,length(customer_name)-3)
from store;

-- Q12. Get the records which have smallest Product Name.

select product_name
from store
where length(Product_name)=(select min(length(Product_Name)) from store);

select product_name
from store
order by length(product_Name) 
limit 1;

-- Q13. Get the records where the Sub Category contains character "o" after 2nd character.

select * from store
where Sub_Category like '__%o%';

-- Q14. Find the number of spaces in Product Name.

select product_name,length(product_name)-length(replace(product_name,' ',''))

from store;
