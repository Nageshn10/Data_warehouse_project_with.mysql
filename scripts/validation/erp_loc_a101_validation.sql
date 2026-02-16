/*
========================================================
TABLE   : silver.erp_loc_a101
LAYER   : Silver (Clean Layer)
PURPOSE : Validate and standardize customer location data
RULE    : All queries must return ZERO rows
========================================================
*/

-- Check 1: Customer ID must exist
SELECT *
FROM silver.erp_loc_a101
WHERE CID IS NULL OR CID = '';


-- Check 2: Country must not be null or blank
SELECT *
FROM silver.erp_loc_a101
WHERE CNTRY IS NULL OR CNTRY = '';


-- Check 3: Remove unwanted spaces
SELECT *
FROM silver.erp_loc_a101
WHERE CNTRY <> TRIM(CNTRY);


-- Check 4: Country values review for standardization
-- Expect consistent values like India, USA, UK (not mixed cases)
SELECT DISTINCT CNTRY
FROM silver.erp_loc_a101;


