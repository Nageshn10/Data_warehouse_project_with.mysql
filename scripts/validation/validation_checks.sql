/*
========================================================
DATA VALIDATION CHECKS
Project : Data Warehouse (MySQL)
Purpose : Verify data quality before Silver load
Author  : Nagesh

How to use:
Run each section and expect ZERO rows for errors
========================================================
*/


/* =====================================================
   CRM CUSTOMER INFO
===================================================== */

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

-- Gender consistency
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info;



/* =====================================================
   CRM PRODUCT INFO
===================================================== */

-- Duplicate product IDs
SELECT prd_id, COUNT(*) AS duplicate_count
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

-- Line/category consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;



/* =====================================================
   CRM SALES DETAILS
===================================================== */

-- Invalid order dates
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0
   OR LENGTH(sls_order_dt) <> 8
   OR sls_order_dt > 20500101;

-- Order after ship/due date
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

-- Sales mismatch check (sales != qty * price)
SELECT *
FROM bronze.crm_sales_details
WHERE sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
   OR sls_sales <> sls_quantity * sls_price;



/* =====================================================
   ERP CUSTOMER
===================================================== */

-- Out of range birth dates
SELECT *
FROM bronze.erp_cust_az12
WHERE BDATE < '1924-01-01'
   OR BDATE > CURDATE();

-- Gender consistency
SELECT DISTINCT GEN
FROM bronze.erp_cust_az12;



/* =====================================================
   ERP LOCATION
===================================================== */

-- Country cleanup review
SELECT DISTINCT
    CNTRY
FROM bronze.erp_loc_a101;



/* =====================================================
   ERP PRODUCT CATEGORY
===================================================== */

-- Unwanted spaces
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE CAT <> TRIM(CAT)
   OR SUBCAT <> TRIM(SUBCAT);

-- Category consistency
SELECT DISTINCT CAT
FROM bronze.erp_px_cat_g1v2;

