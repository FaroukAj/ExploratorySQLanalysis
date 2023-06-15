USE groceries;


SHOW COLUMNS FROM supermarket;

SELECT * FROM supermarket;



-- Calculate the total sales revenue and explore the distribution of sales across different product lines and branches.
SELECT (ROUND(SUM(Total),2))
FROM supermarket;

SELECT Branch, 
       (ROUND(SUM(Total),2)) AS Total_revenue
FROM supermarket
GROUP BY Branch
ORDER BY Branch;

SELECT Product_line,
       (ROUND(SUM(Total),2)) AS Total_revenue
FROM supermarket
GROUP BY Product_line
ORDER BY product_line;

SELECT Branch, 
       Product_line, (ROUND(SUM(Total),2)) AS Total_revenue
FROM supermarket
GROUP BY Branch, Product_line
ORDER BY Branch;


-- Calculate the average unit price for each product line and identify the top-selling and highest-priced products.

SELECT Product_line, 
       ROUND(AVG(Unit_price),2) AS Avg_product_line_price
FROM supermarket
GROUP BY Product_line;

-- Calculate the average rating for each branch and product line, and determine what product lines are the highest rated at each branch.
WITH Avg_rating AS (
SELECT Branch, Product_line, AVG(rating), 
ROW_NUMBER() OVER(PARTITION BY Branch ORDER BY AVG(rating)DESC) AS product_rating_per_branch
FROM supermarket
GROUP BY Branch, Product_line
)
SELECT * FROM Avg_rating;


-- Analyze the distribution of payment methods used by customers and identify the most common payment method for each branch.
SELECT payment, 
       COUNT(Payment)
FROM supermarket
GROUP BY Payment;

WITH AVG_payment AS (
SELECT Branch, Payment, COUNT(payment) AS payment_method_count, 
RANK() OVER (PARTITION BY Branch ORDER BY COUNT(Payment) DESC) AS Payment_method_rank
FROM supermarket
GROUP BY Branch, Payment
ORDER BY Branch,COUNT(payment) DESC

)
SELECT * FROM AVG_payment
WHERE Payment_method_rank = 1;


-- Determine the highest grossing day sales, and identify highest monthly Total sales trends.
SELECT STR_TO_DATE(Date, '%m/%d/%y')
FROM supermarket;

UPDATE supermarket
SET Date = (SELECT STR_TO_DATE(Date, '%m/%d/%y')
);

SELECT Date, 
       ROUND(SUM(Total),2) AS Daily_Total
FROM supermarket
GROUP BY Date
ORDER BY ROUND(SUM(Total),2) DESC;



SELECT monthname(Date) AS Month, 
       ROUND(SUM(Total),2) AS Monthly_Total
FROM supermarket
GROUP BY  monthname(Date)
ORDER BY ROUND(SUM(Total),2) DESC;


-- Calculate the total tax amount and analyze the distribution of tax percentages across different product lines and branches.
SELECT ROUND(SUM(Five_percent_tax),2)
FROM supermarket;

WITH revenue_percent AS (
SELECT Product_line, ROUND(SUM(Total),2) AS Total_revenue_per_product,
ROUND(SUM(Five_percent_tax),2) AS Total_tax_on_each_product
FROM supermarket
GROUP BY Product_line
)
SELECT Product_line, 
       Total_revenue_per_product, 
       Total_tax_on_each_product,
       (Total_tax_on_each_product/Total_revenue_per_product * 100.00) AS Tax_percentage
FROM revenue_percent;


WITH branch_percent AS (
SELECT Branch, ROUND(SUM(Total),2) AS Total_revenue_per_branch,
ROUND(SUM(Five_percent_tax),2) AS Total_tax_at_each_branch
FROM supermarket
GROUP BY Branch
)
SELECT Branch,
       Total_revenue_per_branch, 
Total_tax_at_each_branch,
(Total_tax_at_each_branch/Total_revenue_per_branch * 100.00) AS Branch_tax_percentage
FROM branch_percent;




-- Compare sales performance across different cities, determine the city with the highest sales.
SELECT DISTINCT City, 
                ROUND(Sum(Total),2), RANK() OVER (ORDER BY Sum(Total) DESC) AS City_revenue_rank
FROM supermarket
GROUP BY City
