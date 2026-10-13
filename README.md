# sql-data-analytics-project

SQL analysis of a retail sales data warehouse (gold layer: `dim_customers`, `dim_products`, `fact_sales`) built on **MySQL 8**.

## Data
- 18,467 customers, 295 products, 60,379 sales records

## Analyses
| Script | Question answered | Techniques |
|---|---|---|
| change over time analysis | How do sales, customers and quantity trend by month? | YEAR(), MONTH(), DATE_FORMAT() |
| cumulative analysis | What are running totals and moving average price by year? | SUM() OVER, AVG() OVER |
| performance analysis | How does each product's yearly sales compare to its average and to the previous year? | LAG(), CTE, CASE |
| part-to-whole analysis | Which categories contribute most to total sales? | SUM() OVER (), CAST |
| data segmentation analysis | How do products fall into cost ranges, and customers into VIP / Regular / New? | CASE, TIMESTAMPDIFF() |
| customer report | Customer-level KPIs: segment, age group, recency, avg order value | View, CTEs |
| product report | Product-level KPIs: segment, recency, avg monthly revenue | View, CTEs |

## Notes
- Originally written for SQL Server; converted to MySQL (e.g. `DATETRUNC` → `DATE_FORMAT`, `DATEDIFF(month, ...)` → `TIMESTAMPDIFF`, `GETDATE()` → `CURDATE()`, `CAST AS FLOAT` → `DECIMAL`).
- Recency is measured from today's date, so values are large for this historical dataset.
- - Dataset and project idea: Data with Baraa. MySQL conversion and execution: me.

## Tools
MySQL 8, MySQL Workbench
