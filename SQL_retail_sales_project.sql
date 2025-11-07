SELECT * FROM retail_sales;

SELECT * FROM retail_sales
WHERE transactions_id IS NULL 
   OR sales_date IS NULL
   OR sales_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sales IS NULL ;
 -- data cleaning 

   SELECT * FROM retail_sales
WHERE transactions_id IS NULL 
   OR sales_date IS NULL
   OR sales_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sales IS NULL ;

 DELETE  FROM retail_sales
WHERE transactions_id IS NULL 
   OR sales_date IS NULL
   OR sales_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sales IS NULL ;

   -- Data Exploration 
   -- How Many sales we have 
    SELECT COUNT(*) AS total_sales
	FROM retail_sales
   -- How Many Unique Customer we have

    SELECT COUNT(DISTINCT(customer_id)) AS total_sales
	FROM retail_sales

   -- How many category we have
   SELECT DISTINCT category 
	FROM retail_sales;

-- Data Analysis & Business Key Problem
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

 SELECT * FROM retail_sales
 WHERE sales_date= '2022-11-05';

 -- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 4 or mere in the month of Nov-2022
 
 SELECT * FROM retail_sales
 WHERE category='Clothing' 
 AND quantity >= 4 
 AND TO_CHAR(sales_date,'YYYY-MM') = '2022-11';

 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 
  SELECT  category, SUM(quantity) AS total_sales
  FROM retail_sales
  GROUP BY category
  ORDER BY SUM(quantity) DESC; 

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age) AS Avg_age
FROM retail_sales
WHERE category='Beauty';

   --  Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

 SELECT *
 FROM retail_sales
 WHERE total_sales >1000;

 -- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

 SELECT gender, category, COUNT(transactions_id) AS number_of_transactions
 FROM retail_sales
 GROUP BY gender, category;
 
 -- Q.7 Write a SQL query to calculate the average sale for each month. Find out best two selling month in each year


 SELECT * FROM
             (
   SELECT EXTRACT( YEAR FROM sales_date) AS year,
   TO_CHAR(sales_date,'FMmonth') AS month,
   ROUND(AVG(total_sales)) AS avg_sales,
   RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sales_date)ORDER BY ROUND(AVG(total_sales))DESC) as rank
   FROM retail_sales 
   GROUP BY 1,2)  as t1
 WHERE rank IN (1,2);


 -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
 
 SELECT customer_id, SUM(total_sales) AS total_sale
 FROM retail_sales
 GROUP BY customer_id
 ORDER BY 2 DESC
 LIMIT 5;

 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
 
 SELECT category , COUNT(DISTINCT customer_id) 
 FROM retail_sales
 WHERE category IN ('Electronics','Clothing','Beauty')
 GROUP BY category 


 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sales AS 
(
SELECT *,
CASE 
     WHEN EXTRACT( HOUR FROM sales_time) <=12 THEN 'Morning'
	 WHEN EXTRACT( HOUR FROM sales_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	 ELSE 'Evening'
	 END AS Shift
FROM retail_sales
)
SELECT shift, COUNT(*) 
FROM hourly_sales
GROUP BY shift;

-- END of Project 
 