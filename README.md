
# sql_retail_sales_analysis
## **Project Overview**
**Project Title** Retail Sales Analysis


This project is designed to use techniques that are for exploring, cleaning, and analyzing retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 


## *OBJECTIVES*
1. **Set up retail sales database** Create and populate a retail sales database with the provided sales data
2. **Data cleaning** Identify and remove records with missing or null values
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Deriving Insight** Answer business specific questions


## Project Structure

## 1 Database Setup
- **Database Creation** The database was created.**Table Creation**
- The table created was `retail_sales` table.
  

 
```sql
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
```
## 2 Database Exploration and Cleaning

``` sql
select count(*)
from retail_sales
```
**Finding unique clients in the dataset**
``` sql	
select count(distinct customer_id)
from retail_sales
```
**Identifying all unique product categories**
``` sql
select distinct category
from retail_sales
```
**Find null values present**
``` sql
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
```
**delete null values not needed**
```sql
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
```

## 3 Data Analysis and findings

-**The following questions were answered to give more insight to business**

- **Sales made on a particular day as requested by business**
```sql
select *
from retail_sales
where to_char(sale_date,'yyyy-mm-dd') = '2022-11-05'
group by 1
order by 2 desc
```	
	
 -**Sales per category made on a particular day as requested by business**
```sql
select category, sum(total_sale)
from retail_sales
where to_char(sale_date,'yyyy-mm-dd') = '2022-11-05'
group by 1
order by 2 desc
```

**Sales made under the category 'clothing', quantity sold is > 3, and they were made in  of November 2022**
```sql
select *
from retail_sales
where 
category = 'Clothing'
and
quantity >= 3
and
to_char(sale_date,'yyyy-mm') ='2022-11'
order by sale_date desc
```
**Total sales for each category**
```sql
	select category, sum(total_sale) as total_sales
	from retail_sales
	group by 1
	order by 2 desc
```
**Average age of customers who purchased from each category**
```sql
select category, round(avg(age),0)
from retail_sales
group by 1
order by 2
```
**Transactions where total sales are greater than 1000**
```sql
select *
from retail_sales
where total_sale > 1000
order by total_sale
```	
**Total number of transactions made by each gender in each category**
```sql
select gender, category, count(transactions_id) number_of_transactions
from retail_sales
group by 1,2
order by 2, 3 desc
```

**Average sale for each month, find the best selling month in each year**
```sql
select extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale),
rank() over(partition by extract(year from sale_date)  order by avg(total_sale) desc) as rank
from retail_sales
group by 1,2

	
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
```
**Top 5 customers based on total sales**
```sql
select customer_id, sum(total_sale)
from retail_sales
group by 1
order by 2 desc
limit 5
```
	

**Creating shifts to find the number of orders based on the set shifts**
**Shifts are categorized as morning(before 12:oo) Afternoon(Between 12:01 and 5:oo) and evening (after )**
```sql	
 select *,
	case
	when extract(hour from sale_time) <12 then 'Morning'
	when extract(hour from sale_time) between 12 and 5 then 'Afternoon'
	else 'Evening'
	end as order_window
	from retail_sales
	
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
```
-End of project

