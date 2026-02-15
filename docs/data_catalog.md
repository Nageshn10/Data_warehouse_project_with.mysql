# Data Catalog

Project: Data Warehouse using MySQL  
Layer: Gold (Analytics Layer)

This layer contains reporting-ready tables used for dashboards and business analysis.  
All tables here are cleaned, validated, and optimized for reporting.

---

## 1. gold.dim_customers

### Purpose
Stores one row per customer with demographic and location details.

| Column | Type | Description | Example |
|--------|--------|-------------|-----------|
| customer_key | bigint | Surrogate primary key | 1 |
| customer_id | int | CRM customer ID | 101 |
| customer_number | text | Customer business code | CUST001 |
| first_name | text | Customer first name | John |
| last_name | text | Customer last name | Smith |
| country | text | Customer country | USA |
| marital_status | text | Marital status | Married |
| gender | text | Standardized gender value | Male |
| birthdate | text | Date of birth | 1990-05-10 |
| create_date | text | Account creation date | 2024-01-01 |

### Example
Used to analyze customers by country, gender, or demographics.

---

## 2. gold.dim_products

### Purpose
Stores one row per product with category and pricing information.

| Column | Type | Description | Example |
|--------|--------|-------------|-----------|
| product_key | bigint | Surrogate primary key | 1 |
| product_id | int | Product ID from CRM | 10 |
| product_number | text | Product business code | PRD001 |
| product_name | text | Product name | Laptop |
| category_id | varchar(50) | Category ID | CAT01 |
| category | text | Category name | Electronics |
| subcategory | text | Subcategory name | Computers |
| maintenance | text | Maintenance or service type | Warranty |
| cost | text | Product cost price | 50000 |
| product_line | text | Product line | Road |
| start_date | date | Product active start date | 2023-01-01 |

### Example
Used to analyze sales by product, category, or product line.

---

## 3. gold.fact_sales

### Purpose
Stores transactional sales data and links customers with products.

| Column | Type | Description | Example |
|--------|--------|-------------|-----------|
| order_number | varchar(20) | Unique order number | ORD1001 |
| product_key | bigint | Links to dim_products | 1 |
| customer_key | bigint | Links to dim_customers | 1 |
| order_date | date | Order placed date | 2024-01-01 |
| shipping_date | date | Shipping date | 2024-01-02 |
| due_date | date | Delivery due date | 2024-01-05 |
| sales_amount | decimal(15,2) | Total sales value | 10000.00 |
| quantity | int | Number of units sold | 2 |
| price | decimal(15,2) | Price per unit | 5000.00 |

### Example
Used to calculate revenue, monthly sales, top products, and top customers.

