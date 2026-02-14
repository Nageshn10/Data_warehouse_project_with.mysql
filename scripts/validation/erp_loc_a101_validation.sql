/*
========================================================
TABLE : erp_loc_a101
LAYER : Bronze → Silver
PURPOSE: Validate and standardize location information
RULE  : All queries should return ZERO rows
========================================================
*/

-- Null or empty customer IDs
SELECT *
FROM bronze.erp_loc_a101
WHERE CID IS NULL OR CID = '';

-- Country values review (standardization check)
SELECT DISTINCT CNTRY
FROM bronze.erp_loc_a101;

-- Unwanted spaces
SELECT *
FROM bronze.erp_loc_a101
WHERE CNTRY <> TRIM(CNTRY);

