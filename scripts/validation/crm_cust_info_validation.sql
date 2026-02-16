/*
========================================================
TABLE   : silver.crm_cust_info
LAYER   : Silver (Clean Layer)
PURPOSE : Ensure customer data is clean before Gold load
RULE    : All queries must return ZERO rows
========================================================
*/

-- Check 1: No duplicate customer IDs
SELECT cst_id, COUNT(*) AS duplicate_count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;


-- Check 2: No NULL or empty customer IDs
SELECT *
FROM silver.crm_cust_info
WHERE cst_id IS NULL OR cst_id = '';


-- Check 3: No extra spaces in names
SELECT *
FROM silver.crm_cust_info
WHERE cst_firstname <> TRIM(cst_firstname)
   OR cst_lastname  <> TRIM(cst_lastname);


-- Check 4: Validate gender values only (Male/Female/n/a)
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;



