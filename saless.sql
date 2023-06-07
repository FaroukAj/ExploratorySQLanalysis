USE customers;

SHOW COLUMNS FROM customerinfo;

SELECT * FROM customerinfo;

-- Modify the empty profession field as 'other'.
UPDATE customerinfo
SET Profession = "Other"
WHERE profession = "";


-- Calculate the average annual income and spending score for each gender.
SELECT Gender, ROUND(AVG(Annual_income),2)AS Avg_salary, AVG(spending_score)
FROM customerinfo
GROUP BY Gender;

-- Find the top 5 professions with the highest average annual income.
SELECT Profession, ROUND(AVG(Annual_income),2)AS Avg_salary
FROM customerinfo
GROUP BY Profession
ORDER BY Avg_salary DESC
LIMIT 5;


-- Calculate the average spending score for each age group.

SELECT 
    CASE
        WHEN Age BETWEEN 19 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '50+'
    END AS Age_group,
    AVG(Spending_score) AS Avg_Spending_Score
FROM customerinfo
GROUP BY Age_group;


-- Determine the 5 highest AND LOWEST customer count per profession
SELECT Profession, COUNT(CustomerID) AS customer_count
FROM customerinfo
GROUP BY Profession 
ORDER BY customer_count DESC
LIMIT 5;

SELECT Profession, COUNT(CustomerID) AS customer_count
FROM customerinfo
GROUP BY Profession 
ORDER BY customer_count ASC
LIMIT 5;


-- Find the TOP 10 customers with the highest and lowest spending score and their corresponding professions.
SELECT CustomerID, spending_score, profession
FROM customerinfo
ORDER BY spending_score DESC
LIMIT 10;

SELECT CustomerID, spending_score, profession
FROM customerinfo
ORDER BY spending_score ASC
LIMIT 10;


-- Calculate the average annual income for customers with a family size greater than 4.
SELECT ROUND(AVG(Annual_income),2)AS Avg_salary
FROM customerinfo
WHERE Family_size >4;

-- Calculate the total number of customers in each age group.
SELECT 
    CASE
        WHEN Age BETWEEN 19 AND 30 THEN '19-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '50+'
    END AS Age_group,
    COUNT(CustomerID) AS Customer_count
FROM customerinfo
GROUP BY Age_group;

/*(SELECT DISTINCT AGE
FROM customerinfo;)*/

-- Determine the average work experience for customers in each age group.
SELECT 
    CASE
        WHEN Age BETWEEN 19 AND 30 THEN '19-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '50+'
    END AS Age_group,
    AVG(work_experience) AS Avg_Work_experience
FROM customerinfo
GROUP BY Age_group;