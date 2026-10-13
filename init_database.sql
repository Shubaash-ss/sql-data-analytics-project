-- =============================================================
-- DataWarehouseAnalytics (MySQL version)
-- Creates the 'gold' database, its three tables, and loads the CSVs.
-- WARNING: drops the 'gold' database if it already exists.
-- =============================================================

SET GLOBAL local_infile = 1;

DROP DATABASE IF EXISTS gold;
CREATE DATABASE gold;
USE gold;

-- ---------- Tables ----------
CREATE TABLE dim_customers(
    customer_key INT,
    customer_id INT,
    customer_number VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    marital_status VARCHAR(50),
    gender VARCHAR(50),
    birthdate DATE,
    create_date DATE
);

CREATE TABLE dim_products(
    product_key INT,
    product_id INT,
    product_number VARCHAR(50),
    product_name VARCHAR(50),
    category_id VARCHAR(50),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    maintenance VARCHAR(50),
    cost INT,
    product_line VARCHAR(50),
    start_date DATE
);

CREATE TABLE fact_sales(
    order_number VARCHAR(50),
    product_key INT,
    customer_key INT,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INT,
    quantity TINYINT UNSIGNED,
    price INT
);

-- ---------- Load data ----------
-- Change these paths to where the CSVs are on your machine (use / not \).

LOAD DATA LOCAL INFILE 'D:/SQL Full concepts(Data with Bara)/sql-data-analytics-project/scripts/gold.dim_customers.csv'
INTO TABLE dim_customers
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(customer_key, customer_id, customer_number, first_name, last_name, country,
 marital_status, gender, @birthdate, @create_date)
SET birthdate   = NULLIF(TRIM(TRAILING '\r' FROM @birthdate), ''),
    create_date = NULLIF(TRIM(TRAILING '\r' FROM @create_date), '');

LOAD DATA LOCAL INFILE 'D:/SQL Full concepts(Data with Bara)/sql-data-analytics-project/scripts/gold.dim_products.csv'
INTO TABLE dim_products
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(product_key, product_id, product_number, product_name, category_id, category,
 subcategory, maintenance, @cost, product_line, @start_date)
SET cost       = NULLIF(@cost, ''),
    start_date = NULLIF(TRIM(TRAILING '\r' FROM @start_date), '');

LOAD DATA LOCAL INFILE 'D:/SQL Full concepts(Data with Bara)/sql-data-analytics-project/scripts/gold.fact_sales.csv'
INTO TABLE fact_sales
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_number, product_key, customer_key, @order_date, @shipping_date, @due_date,
 sales_amount, quantity, @price)
SET order_date    = NULLIF(@order_date, ''),
    shipping_date = NULLIF(@shipping_date, ''),
    due_date      = NULLIF(@due_date, ''),
    price         = NULLIF(TRIM(TRAILING '\r' FROM @price), '');

-- ---------- Check the load ----------
SELECT 'dim_customers' AS tbl, COUNT(*) AS row_count FROM dim_customers
UNION ALL SELECT 'dim_products', COUNT(*) FROM dim_products
UNION ALL SELECT 'fact_sales', COUNT(*) FROM fact_sales;