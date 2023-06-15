USE wfsdata;

/* ALTER TABLE emloyeedata RENAME employeedata; */

-- Find the latest record date for each employee and calculate the number of days since their last record update.
WITH latest_record AS (
SELECT EmployeeID, 
	recorddate_key,
	ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY recorddate_key DESC) AS record_date_count
FROM Employeedata
)
SELECT EmployeeID, str_to_date(recorddate_key, '%m/%d/%y' )
FROM latest_record
WHERE record_date_count =1;

-- Find the average age of employees in each department.
SELECT department_name, 
       ROUND(AVG(age)) AS AVG_Age
FROM employeedata
GROUP BY department_name;

-- Calculate the cumulative length of service for each employee, ordered by their hire date.
SELECT employeeID, 
       SUM(length_of_service) AS cumulative_length_of_service
FROM employeedata
GROUP BY employeeID;

-- Determine the top 5 cities with the highest number of employees.
SELECT city_name, 
       COUNT(EmployeeID) AS Employee_count
FROM employeedata
GROUP BY city_name
ORDER BY Employee_counT DESC
LIMIT 5;

-- Calculate the percentage of male and female employees in each department.
WITH employee_percentage AS (

SELECT department_name,
COUNT(gender_full) AS total_count,
COUNT(CASE WHEN gender_full ="Male" THEN gender_full END) AS male_count,
COUNT(CASE WHEN gender_full ="Female" THEN gender_full END) AS female_count
FROM employeedata
GROUP BY department_name 
)
SELECT department_name,
       total_count, 
       ROUND((male_count/total_count) * 100.00, 2) AS male_percentage, 
       ROUND((female_count/total_count) * 100.00, 2) AS female_percentage
FROM employee_percentage;

								/* OR USING PARTITION BY */ 
SELECT department_name, 
       gender_full,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY department_name),2) AS gender_percentage
FROM employeedata
GROUP BY department_name, gender_full;
 
-- Find the most common job title among laid-off employees.
SELECT job_title, 
       COUNT(EmployeeID) AS'employees_laid-off'
FROM employeedata
WHERE termreason_desc = "layoff"
GROUP BY job_title
ORDER BY COUNT(EmployeeID);

-- Calculate the average age of employees at each store, considering only active employees.
SELECT store_name,
       ROUND(AVG(age))
FROM employeedata
WHERE status = "ACTIVE"
GROUP BY store_name;

-- Determine the tenure of employees by calculating the difference between their termination date and hire date.
SELECT EmployeeID, orighiredate_key, terminationdate_key,
DATEDIFF(terminationdate_key, orighiredate_key) AS tenure
FROM employeedata;



-- Calculate the number of employees hired in each year.
/*UPDATE employeedata
SET orighiredate_key = (select str_to_date(orighiredate_key, '%m/%d/%Y')); */

SELECT   YEAR(orighiredate_key) AS Year_of_hire, 
	 COUNT(employeeID) AS Employee_count
FROM Employeedata
GROUP BY  YEAR(orighiredate_key)
ORDER BY Employee_count DESC;


-- Determine the average length of service for terminated employees in each business unit
SELECT Business_unit, AVG(length_of_service) AS avg_service_length
FROM employeedata
WHERE STATUS = 'TERMINATED'
GROUP BY Business_unit;

SELECT * FROM employeedata;
