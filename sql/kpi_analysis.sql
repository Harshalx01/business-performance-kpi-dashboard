/* ============================================================
   Business Performance & KPI Analysis
   Dataset: Retail Business Sales
   Tool: MySQL
   ============================================================ */
-- These queries support the KPIs and insights shown in the Power BI dashboard


/* ------------------------------------------------------------
   Q1. Overall Business Size
   Question:
   What is the total sales volume and how many unique products
   are included in the dataset?
   ------------------------------------------------------------ */

SELECT
    SUM(sales_volume) AS total_sales_volume,
    COUNT(DISTINCT product_id) AS total_products
FROM sales_data;


/* ------------------------------------------------------------
   Q2. Average Sales Performance
   Question:
   What is the average sales volume per product?
   ------------------------------------------------------------ */

SELECT
    AVG(sales_volume) AS avg_sales_per_product
FROM sales_data;


/* ------------------------------------------------------------
   Q3. Promotion Impact on Sales
   Question:
   How does average sales differ between promoted and
   non-promoted products?
   ------------------------------------------------------------ */

SELECT
    promotion,
    AVG(sales_volume) AS avg_sales_volume
FROM sales_data
GROUP BY promotion;


/* ------------------------------------------------------------
   Q4. Contribution of Promotions to Total Sales
   Question:
   What percentage of total sales is generated from promoted
   products?
   ------------------------------------------------------------ */

SELECT
    ROUND(
        SUM(CASE WHEN promotion = 'yes' THEN sales_volume ELSE 0 END)
        / SUM(sales_volume) * 100, 2
    ) AS promotion_sales_percentage
FROM sales_data;


/* ------------------------------------------------------------
   Q5. Store Position Performance
   Question:
   Which store position generates the highest average sales
   per product?
   ------------------------------------------------------------ */

SELECT
    product_position,
    AVG(sales_volume) AS avg_sales_volume
FROM sales_data
GROUP BY product_position
ORDER BY avg_sales_volume DESC;


/* ------------------------------------------------------------
   Q6. Seasonal vs Non-Seasonal Performance
   Question:
   Do seasonal products perform better than non-seasonal
   products in terms of average sales?
   ------------------------------------------------------------ */

SELECT
    seasonal,
    AVG(sales_volume) AS avg_sales_volume
FROM sales_data
GROUP BY seasonal;


/* ------------------------------------------------------------
   Q7. Top 5 Best-Selling Products
   Question:
   Which products contribute the most to total sales volume?
   ------------------------------------------------------------ */

SELECT
    product_name,
    SUM(sales_volume) AS total_sales_volume
FROM sales_data
GROUP BY product_name
ORDER BY total_sales_volume DESC
LIMIT 5;


/* ------------------------------------------------------------
   Q8. Sales Distribution by Product Category
   Question:
   How is total sales distributed across product categories?
   ------------------------------------------------------------ */

SELECT
    product_category,
    SUM(sales_volume) AS total_sales_volume
FROM sales_data
GROUP BY product_category
ORDER BY total_sales_volume DESC;


/* ------------------------------------------------------------
   Q9. Promotion Effect Within Store Positions
   Question:
   Does promotion effectiveness vary by store position?
   ------------------------------------------------------------ */

SELECT
    product_position,
    promotion,
    AVG(sales_volume) AS avg_sales_volume
FROM sales_data
GROUP BY product_position, promotion
ORDER BY product_position, avg_sales_volume DESC;


/* ------------------------------------------------------------
   Q10. High-Level Sales Concentration Check
   Question:
   Are sales concentrated among a small set of products?
   ------------------------------------------------------------ */

SELECT
    COUNT(*) AS products_above_avg_sales
FROM sales_data
WHERE sales_volume >
      (SELECT AVG(sales_volume) FROM sales_data);


/* ===================== END OF ANALYSIS ====================== */
