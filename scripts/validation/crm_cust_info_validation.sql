/*
========================================================
TABLE : crm_cust_info
LAYER : Bronze → Silver
PURPOSE: Validate customer master data quality
RULE  : Queries should return ZERO rows
========================================================
*/

-- Duplicate customer IDs
SELECT cst_id, COUNT(*) AS duplicate_count
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

-- Null or empty IDs
SELECT *
FROM bronze.crm_cust_info
WHERE cst_id IS NULL OR cst_id = '';

-- Unwanted spaces in names
SELECT *
FROM bronze.crm_cust_info
WHERE cst_firstname <> TRIM(cst_firstname)
   OR cst_lastname  <> TRIM(cst_lastname);

-- Gender consistency check
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info;

-- If rows returned → fix data before Silver load


