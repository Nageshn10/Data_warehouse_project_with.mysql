/*
====================================================
Silver Layer ETL Script
Database : MySQL
Purpose  : Clean and transform Bronze data
Author   : Nagesh

How to run:
CALL silver.load_silver();
====================================================
*/

DELIMITER $$

CREATE PROCEDURE silver.load_silver()
BEGIN

-- =================================================
-- CRM CUSTOMER INFO
-- Remove duplicates
-- Clean names
-- Standardize gender & marital status
-- =================================================
SELECT 'Loading: silver.crm_cust_info';

TRUNCATE TABLE silver.crm_cust_info;

INSERT INTO silver.crm_cust_info
SELECT
    cst_id,
    cst_key,
    TRIM(cst_firstname),
    TRIM(cst_lastname),

    CASE
        WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
        WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
        ELSE 'n/a'
    END,

    CASE
        WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
        ELSE 'n/a'
    END,

    cst_create_date

FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) rn
    FROM bronze.crm_cust_info
    WHERE NULLIF(cst_id,'') IS NOT NULL
) t
WHERE rn = 1;



-- =================================================
-- CRM PRODUCT INFO
-- Fix product keys
-- Handle cost nulls
-- Create end date using LEAD()
-- =================================================
SELECT 'Loading: silver.crm_prd_info';

TRUNCATE TABLE silver.crm_prd_info;

INSERT INTO silver.crm_prd_info
SELECT
    prd_id,
    REPLACE(SUBSTRING(prd_key,1,5),'-','_'),
    SUBSTRING(prd_key,7),
    prd_nm,
    IFNULL(NULLIF(TRIM(prd_cost),''),0),

    CASE
        WHEN UPPER(TRIM(prd_line))='M' THEN 'Mountain'
        WHEN UPPER(TRIM(prd_line))='R' THEN 'Road'
        WHEN UPPER(TRIM(prd_line))='T' THEN 'Touring'
        ELSE 'n/a'
    END,

    prd_start_dt,

    DATE_SUB(
        LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt),
        INTERVAL 1 DAY
    )
FROM bronze.crm_prd_info;



-- =================================================
-- CRM SALES DETAILS
-- Fix invalid dates
-- Correct wrong sales values
-- =================================================
SELECT 'Loading: silver.crm_sales_details';

TRUNCATE TABLE silver.crm_sales_details;

INSERT INTO silver.crm_sales_details
SELECT
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,

    STR_TO_DATE(NULLIF(sls_order_dt,0),'%Y%m%d'),
    STR_TO_DATE(NULLIF(sls_ship_dt,0),'%Y%m%d'),
    STR_TO_DATE(NULLIF(sls_due_dt,0),'%Y%m%d'),

    ROUND(
        CASE
            WHEN sls_sales IS NULL OR sls_sales<=0
            THEN sls_quantity*ABS(sls_price)
            ELSE sls_sales
        END,2),

    sls_quantity,

    ROUND(
        CASE
            WHEN sls_price IS NULL OR sls_price<=0
            THEN sls_sales/NULLIF(sls_quantity,0)
            ELSE sls_price
        END,2)

FROM bronze.crm_sales_details;



-- =================================================
-- ERP CUSTOMER
-- Clean ID
-- Validate birth date
-- =================================================
SELECT 'Loading: silver.erp_cust_az12';

TRUNCATE TABLE silver.erp_cust_az12;

INSERT INTO silver.erp_cust_az12
SELECT
    CASE
        WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4)
        ELSE CID
    END,

    CASE
        WHEN BDATE > CURDATE() THEN NULL
        ELSE BDATE
    END,

    CASE
        WHEN UPPER(TRIM(GEN)) IN ('F','FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(GEN)) IN ('M','MALE') THEN 'Male'
        ELSE 'n/a'
    END
FROM bronze.erp_cust_az12;



-- =================================================
-- ERP LOCATION
-- Clean country codes
-- =================================================
SELECT 'Loading: silver.erp_loc_a101';

TRUNCATE TABLE silver.erp_loc_a101;

INSERT INTO silver.erp_loc_a101
SELECT
    REPLACE(cid,'-',''),

    CASE
        WHEN TRIM(CNTRY)='DE' THEN 'Germany'
        WHEN TRIM(CNTRY) IN ('US','USA') THEN 'United States'
        WHEN TRIM(CNTRY)='' OR CNTRY IS NULL THEN 'n/a'
        ELSE TRIM(CNTRY)
    END
FROM bronze.erp_loc_a101;



-- =================================================
-- ERP PRODUCT CATEGORY
-- Simple copy
-- =================================================
SELECT 'Loading: silver.erp_px_cat_g1v2';

TRUNCATE TABLE silver.erp_px_cat_g1v2;

INSERT INTO silver.erp_px_cat_g1v2
SELECT * FROM bronze.erp_px_cat_g1v2;

END$$
DELIMITER ;

