/*
========================================================
TABLE : crm_prd_info
PURPOSE: Validate product master data
RULE  : Expect ZERO rows
========================================================
*/

-- Duplicate product IDs
SELECT prd_id, COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Null or negative costs
SELECT *
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;

-- Invalid date ranges
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- Unwanted spaces
SELECT *
FROM bronze.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm);

-- Product line consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;

