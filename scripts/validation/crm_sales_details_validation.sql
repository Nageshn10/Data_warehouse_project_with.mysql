/*
========================================================
TABLE : crm_sales_details
PURPOSE: Validate transactional sales accuracy
RULE  : Expect ZERO rows
========================================================
*/

-- Invalid order dates
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0
   OR LENGTH(sls_order_dt) <> 8
   OR sls_order_dt > 20500101;

-- Order date sequence check
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

-- Sales = Quantity × Price validation
SELECT *
FROM bronze.crm_sales_details
WHERE sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
   OR sls_sales <> sls_quantity * sls_price;

