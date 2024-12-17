-- Creating Table
CREATE TABLE retail_sales
   (
   transactions_id INT PRIMARY KEY,
   sale_date DATE,	
   sale_time TIME,	
   customer_id	INT,
   gender	VARCHAR (10),
   age	INT,
   category VARCHAR (15),	
   quantiy	INT,
   price_per_unit	FLOAT,
   cogs	FLOAT,
   total_sale FLOAT
);

-- Counting total number of record and pulling everything
SELECT * FROM RETAIL_sALES

-- Counting no of customers
SELECT COUNT(CUSTOMER_ID)
FROM RETAIL_sALES;

----Data Cleaning
-- CHecking null values in sales_Date column
Select * From Retail_sales
where sale_Date IS NULL;

--checking null values in Sale_time
Select * From Retail_sales
where sale_time IS NULL;

--checking null values in customer_id 
Select * From Retail_sales
where CUSTOMER_ID IS NULL;

-- CHECKING NULL VALUES IN GENDER
SELECT * FROM RETAIL_SALES
WHERE GENDER IS NULL;


-- CHECKING NULL VALUES IN AGE
SELECT * FROM RETAIL_SALES
WHERE AGE IS NULL;

--CHECK NULL VALUES WITH ONLY ONE QUERY
SELECT * FROM RETAIL_SALES
WHERE 
sale_Date IS NULL
OR
sale_time IS NULL
OR
 CUSTOMER_ID IS NULL
 OR
 GENDER IS NULL
OR
AGE IS NULL
OR
CATEGORY IS NULL
OR 
QUANTIY IS NULL
OR 
PRICE_PER_UNIT IS NULL
OR
COGS IS NULL
OR
TOTAL_SALE IS NULL;

--deleting ROWS

DELETE FROM RETAIL_SALES
WHERE 
sale_Date IS NULL
OR
sale_time IS NULL
OR
 CUSTOMER_ID IS NULL
 OR
 GENDER IS NULL
OR
AGE IS NULL
OR
CATEGORY IS NULL
OR 
QUANTIY IS NULL
OR 
PRICE_PER_UNIT IS NULL
OR
COGS IS NULL
OR
TOTAL_SALE IS NULL;

-- Data Exploration

--How many sales we have?
select count(*) from retail_Sales


-- How many unique customer we have?
select count(distinct(customer_id))
from retail_Sales;


--how many unique categories we have
Select count(distinct(category))
from retail_Sales;



--what are the name of those 3 categories
select distinct(category) from retail_sales;



--Data Analysis & Business Key Problems & Answers



--MY Analysis & Findings
--Q.1 Write a SQL Query to retrieve all columns for sales made on '2022-11-05'
Select * from retail_Sales
where sale_Date = '2022-11-05';



---Q2.  Write a SQL Query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than or equal to 4 in the month of NOV 2022.
Select * from retail_sales
where category = 'Clothing'
and 
TO_CHAR (sale_date, 'YYYY-MM')= '2022-11'
AND 
QUANTIY >=4;



-Q3. Write a SQL Query to calculate the total sales(total_sale) for each category.

Select category, sum(total_sale) as total_Sales
from retail_Sales
group by category;



--Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty Category'.
select round(avg(age),2) as avg_age
from retail_sales
where category='Beauty';



--Q5. Write a SQL Query to find all transcations where the total_Sale is greater than 1000.
Select transactions_id
from retail_Sales
where total_Sale>1000



--Q6. Write a sql query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender, category, count(transactions_id) as total_transactions
from retail_sales
group by gender,category
;



--Q7. Write a SQL to calculate the average sale for each month. Find out best selling month in each year.
SELECT MONTH, YEAR, avg_Sale from(
Select 
round(avg(total_sale)::numeric,2) as avg_Sale,
TO_CHAR (SALE_DATE, 'mm') as Month,
TO_CHAR (SALE_dATE,'YYYY') AS Year,
RANK ()over( partition by TO_CHAR (SALE_dATE,'YYYY') order by avg(total_sale) DESC) 
from retail_Sales
group by 2,3
order by 3) AS T1
WHERE rank = 1



--Q8. Write a SQL Query to find the top 5 customers based on the highest total sales
select customer_id, sum(total_sale) as total_sales
from retail_Sales
group by 1
order by 1,2
limit 5;




--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.

select 
count(distinct(customer_id)) AS UNIQUE_CUSTOMER, category
from retail_sales
group by category;




--Q10. Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12& 17, Evening>17)
with hourly_Sale 
as(
Select *, 
case
when extract(hour from sale_time) <12 then 'Morning'
when extract(hour from sale_time) Between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales)

select shift, 
count(transactions_id) as total_orders
from hourly_Sale
group by shift;

--END OF PROJECT


