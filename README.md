# Data Warehouse Project using MySQL

## Overview
This project demonstrates how to build a simple Data Warehouse using MySQL.

The goal is to:
- collect raw data
- clean and standardize it
- prepare it for reporting and analytics

The warehouse follows a 3-layer architecture.


## Architecture

Bronze → Silver → Gold

Bronze : Raw source data  
Silver : Cleaned and validated data  
Gold   : Business-ready analytics tables  


## Layer Details

### Bronze (Raw Layer)
Stores data exactly as received from source systems.

No transformations are applied.

Example tables:
- crm_cust_info
- crm_prd_info
- crm_sales_details
- erp_cust_az12
- erp_loc_a101
- erp_px_cat_g1v2


### Silver (Clean Layer)
Data is cleaned and standardized.

Operations performed:
- remove nulls
- trim spaces
- fix formats
- validate business rules
- convert data types


### Gold (Analytics Layer)
Reporting-ready tables for dashboards and analysis.

Tables:
- dim_customers
- dim_products
- fact_sales


## Project Structure

docs/
- data_catalog.md
- naming_conventions.md
- er_diagram.png

sql/
- bronze/
- silver/
- gold/
- validations/

diagrams/
- architecture.png
- data_flow.png
- integration_model.png
- data_mart.png


## Tools Used
- MySQL
- SQL
- draw.io for diagrams


## Author
Nagesh
