/*
========================================================
TABLE   : silver.crm_sales_details
LAYER   : Silver (Clean Layer)
PURPOSE : Validate transactional sales data before Gold load
RULE    : All queries must return ZERO rows
========================================================
*/

-- Check 1: check for invalid dates
SELECT nullif(sls_cust_id,0) FROM bronze.crm_sales_details
where sls_order_dt <=0
or length(sls_order_dt) !=8 
or sls_order_dt >20500101
or sls_ship_dt <19000101


-- Check 2: Invalid Date Orders
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

-- Check 5:
--  data consistency : Between Sales,Quantity,and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero, or negative.

SELECT distinct
sls_sales,
sls_quantity,
sls_price 
from bronze.crm_sales_details
where sls_sales!= sls_quantity *sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <=0 or sls_quantity <=0 or sls_price <=0
order by sls_sales,sls_quantity,sls_price


