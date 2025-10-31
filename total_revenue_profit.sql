-- Total Revenue, Profit, and Margin per Product Category

SELECT Product_Category,
	SUM(Revenue) AS Total_Revenue,
	SUM(Profit) AS Total_Profit,
	ROUND(SUM(Profit*1.0)/SUM(Revenue)*100,2) AS Margin_Percentage
FROM salesdata_cleaned
GROUP BY Product_Category
ORDER BY Total_Profit DESC;