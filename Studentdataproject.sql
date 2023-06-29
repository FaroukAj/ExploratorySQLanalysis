USE housing;


SHOW COLUMNS
FROM student_data;

SELECT * FROM student_data
LIMIT 5;

-- Retrieve the total number of students in each field of study.
SELECT COUNT( DISTINCT student_ID) AS student_count
	   , Field_of_study
FROM student_data
GROUP BY Field_of_study
ORDER BY student_count DESC;


-- Calculate the average age of students in each specialization.

/* UPDATE D.O.B DATA TYPE TO DATE*/
UPDATE student_data
SET Date_of_Birth = (SELECT str_to_date(Date_of_Birth, '%m/%d/%y'));


SELECT Specialization, ROUND(AVG(YEAR(CURDATE()) -(Extract(Year FROM Date_of_Birth)))) AS Average_Age
FROM student_data
GROUP BY Specialization;




-- Find the number of students who are expected to graduate in each year.
SELECT Expected_Year_of_Graduation
	, COUNT(Distinct Student_ID) AS Student_count
FROM student_data
GROUP BY Expected_Year_of_Graduation;


-- Determine the total fees collected for each year of admission.
SELECT Year_of_admission AS Year
	, SUM(Fees) AS Total_fees
FROM student_data
GROUP BY Year_of_admission
ORDER BY  Total_fees DESC;


-- Calculate the average discount on fees for each field of study.
SELECT Field_of_Study
	,ROUND(AVG(Discount_on_Fees),2) AS Average_dicount
FROM student_data
GROUP BY Field_of_Study;

-- Identify the student(s) with the highest discount on fees.
SELECT Student_ID
	, SUM(Discount_on_Fees) AS Total_discount
FROM student_data
GROUP BY Student_ID
ORDER BY Total_discount DESC
LIMIT 10;
    
    

-- Find the field of study with the highest total fees collected.

SELECT Field_of_Study
	, SUM(Fees) AS Total_Fees
FROM student_data
GROUP BY Field_of_Study
ORDER BY Total_Fees
LIMIT 1;

-- Identify the students who have the same field of study, specialization, and expected year of graduation.

SELECT 
	DISTINCT Field_of_Study
    , Specialization
	, Expected_Year_of_Graduation
    ,COUNT( Student_ID) OVER( PARTITION BY Field_of_Study
	, Specialization
	, Expected_Year_of_Graduation) AS Total_Graduating_students
FROM student_data