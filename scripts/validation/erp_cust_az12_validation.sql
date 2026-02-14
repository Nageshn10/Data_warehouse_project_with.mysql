/*
========================================================
TABLE : erp_cust_az12
LAYER : Bronze → Silver
PURPOSE: Validate customer demographic data from ERP
RULE  : All queries should return ZERO rows
========================================================
*/

-- Invalid or unrealistic birth dates
SELECT *
FROM bronze.erp_cust_az12
WHERE BDATE < '1924-01-01'
   OR BDATE > CURDATE();

-- Null customer IDs
SELECT *
FROM bronze.erp_cust_az12
WHERE CID IS NULL OR CID = '';

-- Gender normalization review
SELECT DISTINCT GEN
FROM bronze.erp_cust_az12;

-- If rows returned → clean before Silver load
