WITH product_segment AS (
SELECT
product_key,
product_name,
cost,
CASE 
	WHEN cost < 100 THEN 'Below 100'
	WHEN cost BETWEEN 100 and 500 THEN '100-500'
	WHEN cost between 500 and 1000 THEN '500-1000'
	ELSE 'Above 1000'
END cost_range
FROM gold.dim_products )

SELECT 
cost_range,
COUNT (product_key) AS total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products DESC

/*
Group Customers into three segments based on their spending behavior:
-VIP: Customerswith at least 12 months of history and spending more than $5000
-Regular: Customers with at least 12 months of history but spending less than $5000
-New: Customers with a lifespan less than 12 months.
And findthe total number of customer by each group
*/
WITH customer_spending AS (
SELECT
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX (order_date) AS last_order,
DATEDIFF (month, MIN(order_date), MAX(order_date)) AS lifespan 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key)
SELECT
customer_segment,
COUNT(customer_key) AS total_customers
FROM (
SELECT
customer_key,
CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
	WHEN lifespan >=12 AND total_spending <= 5000 Then ' Regular'
	ELSE 'New'
END customer_segment
FROM customer_spending)t
GROUP BY customer_segment
ORDER BY total_customers DESC
