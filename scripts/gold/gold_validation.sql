/* =====================================================
   GOLD LAYER VALIDATION
   Project : Data Warehouse (MySQL)
   Author  : Nagesh

   Purpose:
   - Check duplicates
   - Check NULL keys
   - Check foreign key integrity
   - Ensure data ready for reporting

   Run all checks → expect ZERO rows for errors
   ===================================================== */



-- =========================================
-- GOLD VALIDATION : dim_customers
-- =========================================

-- No duplicate customers
SELECT customer_id, COUNT(*)
FROM gold.dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- No NULL business key
SELECT *
FROM gold.dim_customers
WHERE customer_id IS NULL;

-- No NULL surrogate key
SELECT *
FROM gold.dim_customers
WHERE customer_key IS NULL;



-- =========================================
-- GOLD VALIDATION : dim_products
-- =========================================

-- No duplicate products
SELECT product_id, COUNT(*)
FROM gold.dim_products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- No NULL business key
SELECT *
FROM gold.dim_products
WHERE product_id IS NULL;

-- No NULL surrogate key
SELECT *
FROM gold.dim_products
WHERE product_key IS NULL;

-- Cost should not be negative
SELECT *
FROM gold.dim_products
WHERE cost < 0;



-- =========================================
-- GOLD VALIDATION : fact_sales
-- =========================================

-- No NULL foreign keys
SELECT *
FROM gold.fact_sales
WHERE customer_key IS NULL
   OR product_key IS NULL;

-- Sales math check (sales = qty * price)
SELECT *
FROM gold.fact_sales
WHERE sales_amount <> quantity * price;

-- No negative values
SELECT *
FROM gold.fact_sales
WHERE sales_amount < 0
   OR quantity < 0
   OR price < 0;
