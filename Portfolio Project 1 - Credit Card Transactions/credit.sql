create database pro;
select * from credit_card_transcations;

-- 1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

select city,sum(amount),sum(amount)*100.0/(select sum(amount) from credit_card_transcations) as percent
from credit_card_transcations as c
group by city
order by sum(amount) desc
limit 5;

select city,total,total*100.0/(select sum(amount) from credit_card_transcations)as percent
from(select city,sum(amount)as total,dense_rank()over(order by sum(amount) desc)as rn
from credit_card_transcations
group by city)as a
where rn in (1,2,3,4,5);

WITH cte1 as(
	SELECT city, SUM(amount) as total_spend
	FROM credit_card_transcations
	GROUP BY city
), cte2 as(
	SELECT SUM(amount) as total_amount 
	FROM credit_card_transcations
)
SELECT cte1.*, ROUND(total_spend*1.0/total_amount*100, 2) as percentage_contribution 
FROM cte1
INNER JOIN cte2
ON 1=1
ORDER BY total_spend DESC
LIMIT 5;

-- 2- write a query to print highest spend month for each year and amount spent in that month for each card type

with cte as (select year(transaction_date)as y,month(transaction_date)as m,sum(amount)as spend
			from credit_card_transactions 
            group by year(transaction_date),month(transaction_date)),
     cte2 as(select y,max(spend) as ms from cte as c group by y ),
     cte3 as(select year(transaction_date)as y,month(transaction_date)as m,card_type,sum(amount)as spend
			from credit_card_transcations 
            group by year(transaction_date),month(transaction_date),card_type)
			select y,m,(select spend from cte3 as d where c.y=d.y and c.m=d.m and card_type='Gold')as gold,
            (select spend from cte3 as d where c.y=d.y and c.m=d.m and card_type='Silver')as sil,
            (select spend from cte3 as d where c.y=d.y and c.m=d.m and card_type='Platinum')as pla,
            (select spend from cte3 as d where c.y=d.y and c.m=d.m and card_type='Signature')as sig,spend as total_spend
            from cte as c
            where spend=(select ms from cte2 where c.y=cte2.y);

WITH cte1 as(
	SELECT card_type, YEAR(transaction_date) yt,
	MONTH(transaction_date) mt, SUM(amount) as total_spend
	FROM credit_card_transactions
	GROUP BY card_type, YEAR(transaction_date), MONTH(transaction_date)
), cte2 as(
	SELECT *, DENSE_RANK() OVER(PARTITION BY card_type ORDER BY total_spend DESC) as rn
	FROM cte1
)
SELECT *
FROM cte2
WHERE rn =1;

-- 3- write a query to print the transaction details(all columns from the table) for each card type when
	-- it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

with cte as(select *,sum(amount)over(partition by card_type order by transaction_date,transaction_id)as total
from credit_card_transactions)
select *
from cte
where total>1000000 and total-amount<1000000;

WITH cte1 as(
	SELECT *, SUM(amount) OVER(PARTITION BY card_type ORDER BY transaction_date, transaction_id) as total_spend
	FROM credit_card_transactions
), cte2 as(
	SELECT *, DENSE_RANK() OVER(PARTITION BY card_type ORDER BY total_spend) as rn  
	FROM cte1 WHERE total_spend >= 1000000
)
SELECT *
FROM cte2
WHERE rn=1;

-- 4- write a query to find city which had lowest percentage spend for gold card type

with cte as(select city,card_type,sum(amount)as spend
from credit_card_transactions
group by city,card_type),
cte2 as (select city,sum(amount)as total from credit_card_transactions group by city),
cte3 as (select city,card_type,spend*100.0/(select total from cte2 as c2 where c.city=c2.city) as percent
from cte as c
order by city)
select city
from cte3
where percent=(select min(percent) from cte3 where card_type='Gold');
-- ****************************************************************
WITH cte as(
	SELECT city, card_type, SUM(amount) as amount,
    SUM(CASE WHEN card_type='Gold' THEN amount END) as gold_amount
	FROM credit_card_transactions
	GROUP BY city, card_type
)
SELECT city, SUM(gold_amount)*1.0/SUM(amount) as gold_ratio
FROM cte
GROUP BY city
HAVING COUNT(gold_amount) > 0 AND SUM(gold_amount)>0
ORDER BY gold_ratio;

-- 5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

with cte as (select city,exp_type,sum(amount)as spend
from credit_card_transactions
group by city,exp_type),
cte2 as (
	SELECT *,
    DENSE_RANK() OVER(PARTITION BY city ORDER BY spend DESC) h,
    DENSE_RANK() OVER(PARTITION BY city ORDER BY spend ASC) l
	FROM cte)
select city,(select exp_type from cte2 as c where c.city=d.city and h=1)as high,(select exp_type from cte2 as c where c.city=d.city and l=1)as low
from cte as d
group by city;

WITH cte1 as (
	SELECT city, exp_type, SUM(amount) as total_amount 
    FROM credit_card_transactions
	GROUP BY city, exp_type
), cte2 as (
	SELECT *,
    DENSE_RANK() OVER(PARTITION BY city ORDER BY total_amount DESC) rn_desc,
    DENSE_RANK() OVER(PARTITION BY city ORDER BY total_amount ASC) rn_asc
	FROM cte1
)
SELECT city, 
MAX(CASE WHEN rn_asc=1 THEN exp_type END) as lowest_exp_type, 
MIN(CASE WHEN rn_desc=1 THEN exp_type END) as highest_exp_type
FROM cte2
GROUP BY city;


-- 6- write a query to find percentage contribution of spends by females for each expense type

with cte as (select exp_type,gender,sum(amount)as spend
from credit_card_transcations
group by exp_type,gender)
select exp_type,round((select spend from cte as d where c.exp_type=d.exp_type and gender='F')*100.0/
(select sum(spend) from cte as e where c.exp_type=e.exp_type),2) as percent
from cte as c
group by exp_type;
-- ****************************************************************
SELECT exp_type,
SUM(CASE WHEN gender='F' THEN amount ELSE 0 END)*1.0/SUM(amount) as percentage_female_contribution
FROM credit_card_transcations
GROUP BY exp_type
ORDER BY percentage_female_contribution DESC;

-- 7- which card and expense type combination saw highest month over month growth in Jan-2014

with cte as(select card_type,exp_type,month(transaction_date)as m,year(transaction_date)as y,amount
			from credit_card_transactions
            where month(transaction_date)=1 and year(transaction_date)=2014 or month(transaction_date)=12 and year(transaction_date)=2013),
	cte2 as(select card_type,exp_type,m,sum(amount)as spend
			from cte
			group by card_type,exp_type,m),
	cte3 as(select card_type,exp_type,(select spend from cte2 as d where m=1 and c.card_type=d.card_type and c.exp_type=d.exp_type)-
            (select spend from cte2 as d where m=12 and c.card_type=d.card_type and c.exp_type=d.exp_type)as diff
            from cte2 as c
            group by card_type,exp_type)
            select card_type,exp_type,(select spend from cte2 as d where d.card_type=f.card_type and d.exp_type=f.exp_type and m=1) as spend,
            diff as mg,(select spend from cte2 as d where d.card_type=f.card_type and d.exp_type=f.exp_type and m=12) as pre_month_spend
            from cte3 as f
            where diff=(select max(diff) from cte3)
            ;

WITH cte1 as(
	SELECT card_type, exp_type, YEAR(transaction_date) yt, 
    MONTH(transaction_date) mt, SUM(amount) as total_spend
	FROM credit_card_transactions
	GROUP BY card_type, exp_type, YEAR(transaction_date), MONTH(transaction_date)
), cte2 as(
	SELECT *, 
    LAG(total_spend,1) OVER(PARTITION BY card_type, exp_type ORDER BY yt,mt) as prev_mont_spend
	FROM cte1
)
SELECT *, (total_spend-prev_mont_spend) as mom_growth
FROM cte2
WHERE prev_mont_spend IS NOT NULL AND yt=2014 AND mt=1
ORDER BY mom_growth DESC
LIMIT 1;


-- 8- during weekends which city has highest total spend to total no of transcations ratio 

select city,sum(amount)/count(*) as c
from credit_card_transactions
where weekday(transaction_date) >=5
group by city
order by c desc
limit 1;
-- ************************************************************************************************
SELECT city , SUM(amount)*1.0/COUNT(1) as ratio
FROM credit_card_transactions
WHERE DAYNAME(transaction_date) in ('Saturday','Sunday')
GROUP BY city
ORDER BY ratio DESC
LIMIT 1;


-- 9- which city took least number of days to reach its 500th transaction after the first transaction in that city

with cte as (select *,rank()over(partition by city order by transaction_date,transaction_id)as rn
from credit_card_transcations),
cte2 as(select city,timestampdiff(day,(select transaction_date from cte as d where c.city=d.city and rn=1),(select transaction_date from cte as d where c.city=d.city and rn=500))as diff
from cte as c
group by city
having count(rn)>=500)
select city from cte2 where diff=(select min(diff) from cte2);

WITH cte as(
	SELECT *,
    ROW_NUMBER() OVER(PARTITION BY city ORDER BY transaction_date, transaction_id) as rn
	FROM credit_card_transactions
)
SELECT city, TIMESTAMPDIFF(DAY, MIN(transaction_date), MAX(transaction_date)) as datediff1
FROM cte
WHERE rn=1 or rn=500
GROUP BY city
HAVING COUNT(1)=2
ORDER BY datediff1
LIMIT 1; 


SELECT * FROM credit_card_transcations;
