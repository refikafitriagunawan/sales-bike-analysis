-- Top States and Countries

SELECT Country,
	State,
	SUM(Revenue) AS Total_Revenue,
	SUM(Profit) AS Total_Profit
FROM salesdata_cleaned
GROUP BY Country, State
ORDER BY Total_Profit DESC
LIMIT 10;