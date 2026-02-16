/*
========================================================
TABLE   : silver.crm_prd_info
LAYER   : Silver (Clean Layer)
PURPOSE : Ensure product data is clean before Gold load
RULE    : All queries must return ZERO rows
========================================================
*/

-- Check 1: No duplicate or NULL product IDs
SELECT prd_id, COUNT(*) AS duplicate_count
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;


-- Check 2: Cost must exist and cannot be negative
SELECT *
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;


-- Check 3: End date cannot be before start date
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;


-- Check 4: No extra spaces in product names
SELECT *
FROM silver.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm);


-- Check 5: Review allowed product lines (manual check)
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;


