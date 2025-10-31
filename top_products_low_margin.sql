-- Top 10 Products by Revenue and Low Profit Margin

WITH Product_Summary AS (
	SELECT product,
		SUM(Revenue) AS Total_Revenue,
		SUM(Profit) AS Total_Profit,
		ROUND(SUM(Profit*1.0)/SUM(Revenue)*100,2) AS Profit_Margin
	FROM salesdata_cleaned
	GROUP BY Product
)
SELECT *
FROM Product_Summary
WHERE Profit_Margin < 20
ORDER BY Total_Revenue DESC
LIMIT 10;