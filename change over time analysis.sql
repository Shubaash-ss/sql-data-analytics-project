/*
===============================================================================
Change Over Time Analysis (MySQL version)
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: YEAR(), MONTH(), DATE_FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

USE gold;

-- 1) Quick date functions
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- 2) First day of each month (MySQL replacement for DATETRUNC)
SELECT
    DATE_FORMAT(order_date, '%Y-%m-01') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
ORDER BY DATE_FORMAT(order_date, '%Y-%m-01');

-- 3) Year-Month label (MySQL replacement for FORMAT)
SELECT
    DATE_FORMAT(order_date, '%Y-%b') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE_FORMAT(order_date, '%Y-%b'), YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);