-- Create Tablce
drop table if exists retail_sales
create table retail_sales
	 (
	    transaction_id INT PRIMARY KEY,	
	    sale_date DATE,	 
	    sale_time TIME,	
	    customer_id	INT,
	    gender	VARCHAR(15),
	    age	INT,
	    category VARCHAR(15),	
	    quantity INT,
	    price_per_unit FLOAT,	
	    cogs	FLOAT,
	    total_sale FLOAT
	    );


select *
from retail_sales
limit 10


-- Retail Sales Analysis

select *
from retail_sales

	-- find null values present
	select *
	from retail_sales
	where
	transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or
	customer_id is null
	or
	total_sale is null

	-- delete null values not needed
	delete 
	from retail_sales
	where 
    transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or
	customer_id is null
	or
	total_sale is null

	-- Analysis and findings
	-- Find all sales made on '2022-11-05'
	select *
	from retail_sales
	where to_char(sale_date,'yyyy-mm-dd') = '2022-11-05'
	group by 1
	order by 2 desc
	
	-- Sum of sales per category made on '2022-11-05'
	select category, sum(total_sale)
	from retail_sales
	where to_char(sale_date,'yyyy-mm-dd') = '2022-11-05'
	group by 1
	order by 2 desc


	-- Find sales made under the category 'clothing', quantity sold is > 3, and they were made in  of November 2022
	select *
	from retail_sales
	where 
	category = 'Clothing'
	and
	quantity >= 3
	and
	to_char(sale_date,'yyyy-mm') ='2022-11'
	order by sale_date desc

	-- Find total sales for each category
	select category, sum(total_sale) as total_sales
	from retail_sales
	group by 1
	order by 2 desc

	-- Find the average age of customers who purchased from each category
	select category, round(avg(age),0)
	from retail_sales
	group by 1
	order by 2

	-- All transactions where total sales are greater than 1000
	select *
	from retail_sales
	where total_sale > 1000
	order by total_sale
	
	-- Find the total number of transactions made by each gender in each category
	select gender, category, count(transactions_id) number_of_transactions
	from retail_sales
	group by 1,2
	order by 2, 3 desc


	-- Find the average sale for each month, find the best selling month in each year

	select extract(year from sale_date) as year,
	       extract(month from sale_date) as month,
		   avg(total_sale),
		   rank() over(partition by extract(year from sale_date)  order by avg(total_sale) desc) as rank
	from retail_sales
	group by 1,2

	-- Finding the best performing month by introducing cte table
	with t1 as
	(select extract(year from sale_date) as year,
	       extract(month from sale_date) as month,
		   avg(total_sale) average_sales,
		   rank() over(partition by extract(year from sale_date)  order by avg(total_sale) desc) as rank
	from retail_sales
	group by 1,2)

	select year, month, round(average_sales),1
	from t1
	where rank = 1

	-- Find top 5 customers based on total sales
	select customer_id, sum(total_sale)
	from retail_sales
	group by 1
	order by 2 desc
	limit 5

	-- Find the number of unique clients who purchased from each category
	select category, count(distinct customer_id) unique_customers
	from retail_sales
	group by 1
	order by 2 desc

	-- Create shifts and find the number of orders based on the set shifts
	-- Shifts are categorized as morning(before 12:oo) Afternoon(Between 12:01 and 5:oo) and evening (after )
	select *,
		case
		when extract(hour from sale_time) <12 then 'Morning'
		when extract(hour from sale_time) between 12 and 5 then 'Afternoon'
		else 'Evening'
		end as order_window
	from retail_sales
	-- Introduce cte to find the number of orders for every order_window
	with t1 as
	(select *,
		case
		when extract(hour from sale_time) <12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
		end as order_window
	from retail_sales
	)

	select order_window, count(*) number_of_transactions
	from t1
	group by 1
	order by 2 desc

	




	
