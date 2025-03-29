CREATE DATABASE retails_sales_analysis_project;
use retails_sales_analysis_project;
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
select * from retail_sales;
select count(*) from retail_sales;

-- data cleaning

-- finding the null values
select * from retail_sales
where 
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or 
    customer_ID is null
    or
    gender is null
    or
    age is null
    or 
    category is null
    or
    quantity is null
    or
    price_per_unit is null
    or 
    cogs is null
    or
    total_sale is null;
    
-- data exploration
-- how many sales we have
select count(*) as total_sales from retail_sales;

-- how many unique customers we have
select count(distinct customer_id) from retail_sales;

select distinct category from retail_sales;

-- data analysis and business key problems and answers
-- Q1 : write a sql query to retrive all columns fro sales made on 2022-11-05
select * 
from retail_sales
where sale_date = '2022-11-05';

/* Q2:  Write a SQL query to retrieve all transactions where the category is'Clothing' and the quantity sold
 is more than 4 in the month of Nov-2022: */
select * 
from retail_sales
where category = "Clothing"
And Date_format(sale_date, '%Y-%m') = '2022-11'
And quantity >= 4;

-- Q3: Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale)
from retail_sales
group by category;

-- Q4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select Round(avg(age), 2)
from retail_sales
where category = "beauty";

-- Q5: Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * 
from retail_sales
where total_sale > 1000;

-- Q6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select count(transactions_id), gender, category
from retail_sales
group by gender, category
order by category;
 
-- Q7: Write a SQL query to calculate the average sale for each month. 
select 
	extract(year from sale_date) as year,
    extract(month from sale_date) as month,
    avg(total_sale)
from retail_sales
group by year, month
order by year, month;

select * from retail_sales;
-- q8: Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id, sum(total_sale)
from retail_sales
group by customer_id
order by sum(total_sale) DESC
limit 5;

-- Q9: Write a SQL query to find the number of unique customers who purchased items from each category.:
select count(distinct customer_id), category
from retail_sales
group by category;

-- Q10: Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;