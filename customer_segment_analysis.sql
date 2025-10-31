-- Customer Segment Analysis

SELECT Age_Group,
	Customer_Gender,
	SUM(Revenue) AS Total_Revenue,
	SUM(Profit) AS Total_Profit
FROM salesdata_cleaned
GROUP BY Age_Group, Customer_Gender
ORDER BY Total_Profit DESC;