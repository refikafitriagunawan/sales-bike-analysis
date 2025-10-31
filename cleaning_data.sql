CREATE TABLE salesdata_uncleaned (
	Date DATE,
	Day INT,
	Month TEXT,
	Year INT,
	Customer_Age INT,
	Age_Group TEXT,
	Customer_Gender TEXT,
	Country TEXT,
	State TEXT,
	Product_Category TEXT,
	Sub_Category TEXT,
	Product TEXT,
	Order_Quantity INT,
	Unit_Cost INT,
	Unit_Price INT,
	Profit INT,
	Cost INT,
	Revenue INT
);

SELECT * FROM salesdata_uncleaned

COPY salesdata_uncleaned FROM 'C:\Program Files\PostgreSQL\18\sales_data.csv' DELIMITER ',' CSV HEADER;

-- STANDARDIZE THE DATA
-- drop column age_group
ALTER TABLE salesdata_uncleaned
DROP COLUMN Age_Group;

-- add a new column age_group
ALTER TABLE salesdata_uncleaned
ADD COLUMN Age_Group TEXT;

-- fill in the new age_group column based on customer_age
UPDATE salesdata_uncleaned
SET Age_Group = CASE
	WHEN Customer_Age < 25 THEN 'Youth'
	WHEN Customer_Age <= 34 THEN 'Youth Adults'
	WHEN Customer_Age <= 64 THEN 'Adults'
	ELSE 'Seniors'
END;



-- REMOVE DUPLICATES
-- check data for duplicates
SELECT
	Date,Day,Month,Year,Customer_Age,Age_Group,Customer_Gender,
	Country,State,Product_Category,Sub_Category,Product,
	Order_Quantity,Unit_Cost,Unit_Price,Profit,Cost,Revenue,
	COUNT (*) AS duplicates_data
FROM salesdata_uncleaned
GROUP BY 
	Date,Day,Month,Year,Customer_Age,Age_Group,Customer_Gender,
	Country,State,Product_Category,Sub_Category,Product,
	Order_Quantity,Unit_Cost,Unit_Price,Profit,Cost,Revenue
HAVING COUNT(*) > 1;

-- drop duplicates data
WITH CTE AS(
	SELECT *,
		ROW_NUMBER() OVER(
PARTITION BY Date,Day,Month,Year,Customer_Age,Age_Group,Customer_Gender,
	Country,State,Product_Category,Sub_Category,Product,
	Order_Quantity,Unit_Cost,Unit_Price,Profit,Cost,Revenue 
		) AS row_num
	FROM salesdata_uncleaned
)
DELETE FROM salesdata_uncleaned
WHERE (Date,Day,Month,Year,Customer_Age,Age_Group,Customer_Gender,
	Country,State,Product_Category,Sub_Category,Product,
	Order_Quantity,Unit_Cost,Unit_Price,Profit,Cost,Revenue) IN (SELECT Date,Day,Month,Year,Customer_Age,Age_Group,Customer_Gender,
	Country,State,Product_Category,Sub_Category,Product,
	Order_Quantity,Unit_Cost,Unit_Price,Profit,Cost,Revenue
	FROM CTE
	WHERE row_num > 1
);



-- NULL VALUES OR BLANK VALUES
-- check data is empty
SELECT *
FROM salesdata_uncleaned
WHERE Date IS NULL
	OR Day IS NULL
	OR Month IS NULL
	OR Year IS NULL
	OR Customer_Age IS NULL
	OR Age_Group IS NULL
	OR Customer_Gender IS NULL
	OR Country IS NULL
	OR State IS NULL
	OR Product_Category IS NULL
	OR Sub_Category IS NULL
	OR Product IS NULL
	OR Order_Quantity IS NULL
	OR Unit_Cost IS NULL
	OR Unit_Price IS NULL
	OR Profit IS NULL
	OR Cost IS NULL
	OR Revenue IS NULL;



-- CREATE CLEANED TABLE
CREATE TABLE salesdata_cleaned AS
SELECT DISTINCT
	Date,
	Day,
	Month,
	Year,
	Customer_Age,
	Age_Group,
	Customer_Gender,
	Country,
	State,
	Product_Category,
	Sub_Category,
	Product,
	Order_Quantity,
	Unit_Cost,
	Unit_Price,
	Profit,
	Cost,
	Revenue
FROM salesdata_uncleaned;

SELECT * FROM salesdata_cleaned;