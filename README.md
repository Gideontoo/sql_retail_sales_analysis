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
