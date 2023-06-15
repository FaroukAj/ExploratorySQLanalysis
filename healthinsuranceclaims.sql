USE wfsdata;
SHOW COLUMNS FROM claims_data;


-- Calculate the average age of patients in the dataset.
SELECT ROUND(AVG(AGE))
FROM claims_data;


-- Determine the gender distribution of patients in the dataset.
SELECT SEX, 
       COUNT(SEX) AS gender_distribution
FROM claims_data
GROUP BY SEX;

/* OR USING PARTITION BY */

SELECT DISTINCT SEX, 
       COUNT(SEX) OVER (PARTITION BY SEX) AS gender_distribution
FROM claims_data;


-- Identify the most common medical diagnosis in the dataset.
WITH diagnosis_countt AS (
SELECT DISTINCT DIAGNOSIS, COUNT(DIAGNOSIS) OVER (PARTITION BY DIAGNOSIS) AS Diagnosis_count
FROM claims_data
ORDER BY Diagnosis_count DESC)
SELECT * 
FROM diagnosis_countt
LIMIT 1;



-- Find the total amount paid by each company.
UPDATE claims_data
SET TOTAL_PRICE  = (Select CAST(TOTAL_PRICE AS DECIMAL(10,2)));

SELECT company, 
       SUM(TOTAL_PRICE) AS Total_amount
FROM claims_data
GROUP BY company;


-- Calculate the total claimed amount for each service type.
SELECT service_type, 
       SUM(TOTAL_PRICE) AS Total_amount
FROM claims_data
GROUP BY service_type;



-- Identify the top 5 providers with the highest total claimed amount.
SELECT Provider_name, 
       SUM(TOTAL_PRICE) AS Total_amount
FROM claims_data
GROUP BY Provider_name
ORDER BY Total_amounT DESC
LIMIT 5;

-- Find the total number of claims per patient age group (e.g., 0-18, 19-30, 31-45, etc.).
SELECT CASE
         WHEN AGE BETWEEN 0 AND 18 THEN '0-18'
         WHEN AGE BETWEEN 19 AND 30 THEN '19-30'
         WHEN AGE BETWEEN 31 AND 45 THEN '31-45'
         ELSE 'Over 45'
       END AS AgeGroup,
       COUNT(*) AS Claim_count
FROM claims_data
GROUP BY AgeGroup
ORDER BY Claim_count DESC;


-- Determine the average total price of medical claims by plan.
SELECT PLAN, AVG(TOTAL_PRICE) AS Average_Total_Price
FROM claims_data
GROUP BY PLAN;


SELECT * FROM claims_data;
