/*
========================================================
TABLE   : silver.erp_cust_az12
LAYER   : Silver (Clean Layer)
PURPOSE : Validate ERP customer demographic data
RULE    : All queries must return ZERO rows
========================================================
*/

-- Check 1: Customer ID must exist
SELECT *
FROM silver.erp_cust_az12
WHERE CID IS NULL OR CID = '';


-- Check 2: Birthdate must be valid
-- no future dates, no unrealistic old dates
SELECT *
FROM silver.erp_cust_az12
WHERE BDATE IS NULL
   OR BDATE < '1924-01-01'
   OR BDATE > CURDATE();


-- Check 3: Gender values consistency review
-- Expect only Male / Female / Unknown (or your standard)
SELECT DISTINCT GEN
FROM silver.erp_cust_az12;

