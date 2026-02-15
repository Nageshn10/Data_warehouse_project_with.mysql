-- =========================================
-- GOLD VALIDATION : dim_customers
-- Purpose : Final checks before reporting
-- =========================================

-- Check 1: No duplicate customers (primary key must be unique)
SELECT cst_id, COUNT(*)
FROM gold.dim_customers
GROUP BY cst_id
HAVING COUNT(*) > 1;


-- Check 2: No NULL customer IDs (mandatory key)
SELECT *
FROM gold.dim_customers
WHERE cst_id IS NULL;


-- Check 3: Record count should match silver after joins
SELECT COUNT(*) FROM silver.crm_cust_info;
SELECT COUNT(*) FROM gold.dim_customers;


-- Check 4: Important columns should not be empty
SELECT *
FROM gold.dim_customers
WHERE cst_firstname IS NULL
   OR cst_lastname IS NULL;

-- =========================================
-- GOLD VALIDATION : dim_products
-- =========================================

-- Check 1: No duplicate products
SELECT prd_key, COUNT(*)
FROM gold.dim_products
GROUP BY prd_key
HAVING COUNT(*) > 1;


-- Check 2: No NULL product keys
SELECT *
FROM gold.dim_products
WHERE prd_key IS NULL;


-- Check 3: Only active products loaded (no historical)
SELECT *
FROM gold.dim_products
WHERE prd_end_dt IS NOT NULL;


-- Check 4: Product cost should not be negative
SELECT *
FROM gold.dim_products
WHERE prd_cost < 0;

-- =========================================
-- GOLD VALIDATION : fact_sales
-- =========================================

-- Check 1: No duplicate transactions
SELECT order_id, COUNT(*)
FROM gold.fact_sales
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Check 2: No NULL foreign keys
SELECT *
FROM gold.fact_sales
WHERE cst_id IS NULL
   OR prd_key IS NULL;


-- Check 3: Sales amount should be positive
SELECT *
FROM gold.fact_sales
WHERE sales_amount <= 0;


-- Check 4: Total sales should match silver totals
SELECT SUM(sales_amount) FROM silver.sales_data;
SELECT SUM(sales_amount) FROM gold.fact_sales;


