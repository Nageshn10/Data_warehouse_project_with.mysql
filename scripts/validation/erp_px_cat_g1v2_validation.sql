/*
========================================================
TABLE : erp_px_cat_g1v2
LAYER : Bronze → Silver
PURPOSE: Validate product category hierarchy
RULE  : All queries should return ZERO rows
========================================================
*/

-- Unwanted spaces in category names
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE CAT <> TRIM(CAT)
   OR SUBCAT <> TRIM(SUBCAT);

-- Null category values
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE CAT IS NULL OR SUBCAT IS NULL;

-- Distinct category review
SELECT DISTINCT CAT, SUBCAT
FROM bronze.erp_px_cat_g1v2;

