SELECT 
SUM(sales_amount) AS total_sales, --total sales amount
SUM(quantity) AS total_quantity, -- total sold items
AVG(price) AS avg_price, -- average selling price
COUNT(DISTINCT order_number) AS total_orders --total number of orders
FROM gold.fact_sales

SELECT
COUNT(product_key) AS total_products -- total number of products
FROM gold.dim_products;

SELECT
COUNT (customer_key) AS total_customers -- total number of customers
FROM gold.dim_customers;

SELECT
COUNT (DISTINCT customer_key) AS total_customers -- total number of customers that placed an order
FROM gold.fact_sales;

SELECT
'Total Sales' as measure_name,
SUM(sales_amount) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
'Total Quantity' AS measure_name,
SUM (quantity) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
'Average Price' AS measure_name,
AVG (price) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
'Total Nr. Orders' AS measure_name,
COUNT (DISTINCT order_number)
FROM gold.fact_sales
UNION ALL
SELECT
'Total Nr. Products' AS measure_name,
COUNT (product_name) AS measure_value
FROM gold.dim_products
UNION ALL
SELECT
'Total Nr. Customers' AS measure_name,
COUNT (customer_key) AS measure_value
FROM gold.dim_customers
