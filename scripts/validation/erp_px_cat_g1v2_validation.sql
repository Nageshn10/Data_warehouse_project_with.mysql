/*
========================================================
TABLE   : erp_px_cat_g1v2
LAYER   : Bronze → Silver
PURPOSE : Validate product category and subcategory data
RULE    : All queries must return ZERO rows
========================================================
*/

-- Check 1: Category and subcategory must not be null or blank
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE CAT IS NULL OR CAT = ''
   OR SUBCAT IS NULL OR SUBCAT = '';


-- Check 2: Remove unwanted spaces
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE CAT <> TRIM(CAT)
   OR SUBCAT <> TRIM(SUBCAT);


-- Check 3: Distinct category review
SELECT DISTINCT CAT, SUBCAT
FROM bronze.erp_px_cat_g1v2;


