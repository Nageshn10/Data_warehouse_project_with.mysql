Data Catalog

Project: Data Warehouse using MySQL
Layer: Gold (Analytics Layer)

This layer contains reporting-ready tables used for dashboards and business analysis.

gold.dim_customers

Purpose
Stores one row per customer with demographic and location details.

Column	Type	Description	Example
customer_key	bigint	Surrogate primary key	1
customer_id	int	CRM customer ID	101
customer_number	text	Customer code	CUST001
first_name	text	First name	John
last_name	text	Last name	Smith
country	text	Customer country	USA
marital_status	text	Marital status	Married
gender	text	Standardized gender	Male
birthdate	text	Date of birth	1990-05-10
create_date	text	Account created date	2024-01-01

Example
Used to analyze customers by country or demographics.

gold.dim_products

Purpose
Stores one row per product with category and pricing information.

Column	Type	Description	Example
product_key	bigint	Surrogate primary key	1
product_id	int	Product ID	10
product_number	text	Product code	PRD001
product_name	text	Product name	Laptop
category_id	varchar(50)	Category ID	CAT01
category	text	Category name	Electronics
subcategory	text	Subcategory name	Computers
maintenance	text	Maintenance type	Warranty
cost	text	Product cost	50000
product_line	text	Product line	Road
start_date	date	Start date	2023-01-01

Example
Used to analyze sales by category or product line.

gold.fact_sales

Purpose
Stores sales transactions and links customers with products.

Column	Type	Description	Example
order_number	varchar(20)	Order number	ORD1001
product_key	bigint	Links to dim_products	1
customer_key	bigint	Links to dim_customers	1
order_date	date	Order date	2024-01-01
shipping_date	date	Ship date	2024-01-02
due_date	date	Due date	2024-01-05
sales_amount	decimal(15,2)	Total sale value	10000.00
quantity	int	Units sold	2
price	decimal(15,2)	Price per unit	5000.00

Example
Used to calculate revenue, monthly sales, and top customers.
