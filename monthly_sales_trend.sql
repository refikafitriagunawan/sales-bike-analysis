-- Monthly Sales Trend

SELECT Year,
	Month,
	SUM(Revenue) AS Monthly_Revenue,
	SUM(Profit) AS Monthly_Profit
FROM salesdata_cleaned
GROUP BY Year, Month
ORDER BY Year, Month;