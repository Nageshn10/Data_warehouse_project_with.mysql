/*
========================================================
TABLE   : silver.crm_sales_details
LAYER   : Silver (Clean Layer)
PURPOSE : Validate transactional sales data before Gold load
RULE    : All queries must return ZERO rows
========================================================
*/

-- Check 1: Order date must exist
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt IS NULL;


-- Check 2: Date sequence must be correct
-- order <= ship <= due
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_ship_dt  > sls_due_dt;


-- Check 3: No negative or zero quantity
SELECT *
FROM silver.crm_sales_details
WHERE sls_quantity <= 0;


-- Check 4: No negative or zero price
SELECT *
FROM silver.crm_sales_details
WHERE sls_price <= 0;


-- Check 5: Sales amount must equal quantity × price
SELECT *
FROM silver.crm_sales_details
WHERE sls_sales <> sls_quantity * sls_price;


-- Check 6: No missing critical fields
SELECT *
FROM silver.crm_sales_details
WHERE sls_prd_key IS NULL
   OR sls_cust_id IS NULL;


