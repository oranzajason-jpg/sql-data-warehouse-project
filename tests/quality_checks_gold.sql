/*
*****************************************************************************************
Quality Checks
****************************************************************************************
Scirpt Purpose:
  This script performs quality chjecks to validate the integrity, consistency, 
  and accuracy of the Gold layer, These chesck ensure:
  -Uniqueness of surrogate keys in dimension tables
  -Referential integrity between fact and dimension tables.
  -Validation of relationships in the data model for analytical purpose.

Usage Notes:
  -Run these checks after data loading the silver layer.
  -Investigate and resolve any discrepancies found during the checks.
***************************************************************************************
*/
-- *******************************************************
-- Checking 'gold.dim_customer'
-- *******************************************************
-- Check for uniqueness of customer key in gold.dim_customers
-- Expectation: No Results
SELECT 
  customer_key
  COUNT(*) AS duplicate_count
FROM gold.dim_customer
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- *******************************************************
-- Checking 'gold.product_key'
-- *******************************************************
-- Check for uniqueness of Product Key in gold.dim_products
-- Expectation: No Results
SELECT
  product_key,
  COUNT (*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT (*) > 1;

-- *******************************************************
-- Checking 'gold.fact_sales'
-- *******************************************************
-- Check the data model connectivity between fact and dimensions
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customer c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key is NULL
