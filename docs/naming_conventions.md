# Naming Standards

Project: Data Warehouse using MySQL

This document explains how tables, columns, and database objects are named in the warehouse.
Consistent naming helps everyone read, write, and maintain the system easily.

--------------------------------------------------

## General Rules

- Use lowercase letters only
- Use snake_case (example: customer_id)
- Do not use spaces or special symbols
- Use simple and meaningful English names
- Avoid SQL reserved words

Good:
order_date, sales_amount, product_key

Avoid:
OrderDate, ordDt, temp1

--------------------------------------------------

## Warehouse Layers

The warehouse has three layers.  
Each layer has a different purpose and naming style.

bronze  → raw source data  
silver  → cleaned and prepared data  
gold    → reporting and analytics data  

--------------------------------------------------

## Table Naming

### Bronze Layer (Raw Data)

Stores data exactly as received from source systems.

Format:
<source>_<original_table>

Examples:
crm_cust_info
erp_loc_a101

Notes:
- Keep original table names
- No renaming
- No transformations
- Pure copy of source

--------------------------------------------------

### Silver Layer (Clean Data)

Stores validated and standardized data.

Format:
<source>_<table>

Examples:
crm_sales_details
erp_px_cat_g1v2

Notes:
- Fix data types
- Remove duplicates
- Handle null values
- Apply cleaning rules
- Keep structure close to source

--------------------------------------------------

### Gold Layer (Business Data)

Stores final tables used by dashboards and reports.

Format:
dim_<name>   for descriptive tables  
fact_<name>  for transactional tables  

Examples:
dim_customers
dim_products
fact_sales

Notes:
- Use business-friendly names
- Easy for analysts to understand
- Optimized for reporting

--------------------------------------------------

## Column Naming

Use clear and readable names that describe the data.

Examples:
first_name
last_name
country
order_date
sales_amount

Avoid short or unclear names:
fn, x1, val

--------------------------------------------------

## Keys

Primary key (surrogate key):
<entity>_key
Example: customer_key

Foreign key:
<entity>_key
Example: product_key

Reason:
Same naming style makes joins simple and consistent.

--------------------------------------------------

## Technical Columns

System-generated or metadata columns use a prefix.

Format:
dwh_<name>

Examples:
dwh_load_date
dwh_created_at

Used for:
- tracking loads
- audit history
- system information

--------------------------------------------------

## Stored Procedures

Loading procedures follow this pattern:

load_<layer>

Examples:
load_bronze
load_silver
load_gold

This makes the process easy to identify.

--------------------------------------------------

## Quick Reference

bronze  → raw copy  
silver  → cleaned data  
gold    → reporting tables  

Follow these rules to keep the warehouse clean, structured, and professional.
