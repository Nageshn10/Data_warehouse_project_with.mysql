/*
========================================================
TABLE   : silver.erp_px_cat_g1v2
LAYER   : Silver (Clean Layer)
PURPOSE : Validate product category and subcategory data
RULE    : All queries must return ZERO rows
========================================================
*/

-- Category and subcategory must not be null or blank
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE CAT IS NULL OR CAT = ''
   OR SUBCAT IS NULL OR SUBCAT = '';

-- No unwanted spaces
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE CAT <> TRIM(CAT)
   OR SUBCAT <> TRIM(SUBCAT);

-- Review standardized category values
SELECT DISTINCT CAT, SUBCAT
FROM silver.erp_px_cat_g1v2;



