# 🛒 Olist E-Commerce Customer Experience & Delivery Analytics

### Turning E-Commerce Data into Business Insights

**Project Type:** Data Analytics | **Domain:** E-Commerce | **Level:** Beginner / Portfolio Project

**Tools:** Python · pandas · MySQL · SQL · Data Visualization · Power BI Dashboard Design

---

## 📌 1. Project Overview

This project analyses the Brazilian E-Commerce Public Dataset by Olist to understand order performance, delivery efficiency, product sales, customer geography, and customer satisfaction.

The objective is to transform raw e-commerce data into meaningful business insights that can help a business identify operational issues, understand sales trends, and improve the customer experience.

The project follows a practical data analysis workflow, including data inspection, data quality checks, SQL-based analysis, KPI calculations, dashboard design, and business recommendations.

> **Business question:** How can e-commerce order, delivery, sales, and review data help identify opportunities to improve operational performance and customer satisfaction?

## 🎯 2. Business Objectives

- Analyse order volume and order status distribution.
- Measure on-time and late delivery performance.
- Identify high-performing product categories.
- Analyse product sales trends over time.
- Compare customer activity and sales across Brazilian states.
- Examine the relationship between delivery performance and customer review scores.
- Develop business recommendations based on the findings.
- Design dashboard layouts that communicate KPIs and insights clearly.

---

## 📂 3. Dataset Description

The project uses the [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

The dataset contains approximately 100,000 orders and multiple related CSV files.

| Dataset | Approximate records | Purpose |
|---|---:|---|
| Orders | 99,441 | Order status and timestamps |
| Customers | 99,441 | Customer locations and identifiers |
| Order Items | 112,650 | Product prices and freight |
| Payments | 103,886 | Payment information |
| Reviews | 99,224 in original inspection | Customer review scores and comments |
| Products | 32,951 | Product details and categories |
| Sellers | 3,095 | Seller information |
| Geolocation | 1,000,163 | Geographic reference data |
| Category Translation | 71 | Translation of Portuguese category names |

*Record counts can vary slightly between source files and imported tables.*

The raw CSV files are not included in this repository. Please download them from the original source and follow the dataset's usage terms.

---

## 🛠️ 4. Tools and Technologies

| Tool | Purpose |
|---|---|
| Python | Data inspection and exploratory analysis |
| pandas | Data cleaning checks, transformations, and calculations |
| MySQL | Data querying, joins, filtering, and aggregations |
| SQL | Business metrics and analytical queries |
| Dashboard design | Static visual representations of the results |
| Power BI / DAX | Planned dashboard implementation and example measures for future use |

### Why these tools?

- **Python** helped inspect data quality and calculate delivery metrics.
- **SQL** helped combine related tables and answer business questions.
- **Dashboard design** helped organise findings into a clear visual story.
- **DAX examples** document how selected metrics could be implemented in a future Power BI report.

**Project status:** Python and SQL analyses were performed, and static dashboard designs were prepared. An interactive Power BI dashboard has  been completed.

---

## 🔄 5. Project Workflow

1. **Data collection:** Obtained the Olist public dataset containing multiple CSV files.
2. **Data inspection:** Examined table structures, row counts, missing values, and duplicate patterns using Python and pandas.
3. **Data preparation:** Reviewed date fields, delivery timestamps, product categories, and relationships between tables.
4. **SQL analysis:** Used MySQL to join tables and calculate order, sales, delivery, geographic, and review metrics.
5. **KPI calculation:** Measured on-time delivery, late deliveries, product sales, and review scores.
6. **Dashboard design:** Prepared static dashboard visuals to communicate the findings.
7. **Business interpretation:** Identified patterns and developed recommendations for further investigation.

---

## 📊 6. Key Performance Indicators (KPIs)

| KPI | Verified result |
|---|---:|
| Total orders | 99,441 |
| Delivered orders | 96,478 |
| Delivered orders as a share of all orders | 97.02% |
| Delivered orders with assessable delivery dates | 96,470 |
| On-time deliveries | 88,644 |
| On-time delivery rate | 91.88% |
| Late deliveries | 7,826 |
| Late delivery rate | 8.12% |
| Delivered product sales | R$13,221,498.11 |

**Metric definitions:**

- On-time delivery rate = On-time deliveries ÷ Assessable delivered orders.
- Late delivery rate = Late deliveries ÷ Assessable delivered orders.
- Delivered product sales = Sum of item prices for delivered orders; freight is excluded.

These sales figures represent product sales, not profit.

---

## 🔍 7. Key Findings and Business Insights

### A. Order Performance

A total of 99,441 orders were recorded, of which 96,478 were marked as delivered.

**Business insight:** Delivered orders account for approximately 97.02% of all recorded orders. The remaining orders include shipped, cancelled, unavailable, and other statuses.

### B. Delivery Performance

Among 96,470 delivered orders with sufficient delivery-date information:

- 91.88% were delivered on time.
- 8.12% were delivered late.

**Business insight:** Delivery reliability is a useful operational KPI. Investigating late deliveries by state, carrier, and estimated delivery date could help identify areas for improvement.

### C. Product Category Performance

The leading categories in the analysed delivered product sales results were:

| Product category | Delivered product sales |
|---|---:|
| Health & Beauty | R$1,233,131.72 |
| Watches & Gifts | R$1,166,176.98 |
| Bed, Bath & Table | R$1,023,434.76 |
| Sports & Leisure | R$954,852.55 |
| Computers & Accessories | R$888,724.61 |

**Business insight:** Health & Beauty and Watches & Gifts are strong categories in the analysed results. Further analysis of margins, demand, and stock availability would be needed before making investment decisions.

### D. Customer Geography

São Paulo recorded approximately R$5.07 million in delivered product sales and 40,501 delivered customers in the analysed results.

The late-delivery rate was 13.47% in Rio de Janeiro compared with 5.89% in São Paulo.

**Business insight:** São Paulo is an important market, while state-level delivery differences suggest opportunities to investigate regional logistics performance. Late-delivery rates should be considered alongside order volumes.

### E. Customer Experience

The average review scores were:

| Delivery status | Average review score |
|---|---:|
| On-time orders | 4.29 / 5 |
| Late orders | 2.57 / 5 |

**Business insight:** Late orders were associated with lower average review scores. This is a relationship observed in the data, not proof that delivery delays alone caused lower customer satisfaction.

---

## 🖥️ 8. Dashboard Design and Visualizations

The dashboard concept is divided into five areas. Each area answers a different business question and contributes to the overall analysis.

### Dashboard 1 — Business Overview

**Objective:** Present the overall health of the e-commerce business through headline KPIs.

**Planned visuals:**
- KPI cards for total orders and delivered orders.
- On-time delivery rate.
- Late delivery count.
- Delivered product sales.
- Order status distribution chart.

**Business question:** What does the overall order and delivery performance look like?

**Screenshot:**

![Business Overview Dashboard](dashboard/olist_dashboard_overview.png)

[Open the overview dashboard image](dashboard/olist_dashboard_overview.png)

---

### Dashboard 2 — Delivery Performance

**Objective:** Evaluate delivery reliability and identify regional differences.

**Planned visuals:**
- On-time versus late delivery doughnut chart.
- Late-delivery rate by state using a horizontal bar chart.
- Average review score by delivery status.
- KPI cards for on-time and late deliveries.

**Business question:** Where should the business investigate delivery delays?

**Key finding:** 8.12% of assessable delivered orders were late.

**Screenshot:**

![Delivery Performance Dashboard](dashboard/olist_dashboard_delivery.png)

[Open the delivery dashboard image](dashboard/olist_dashboard_delivery.png)

---

### Dashboard 3 — Sales and Product Categories

**Objective:** Understand which product categories contribute most to delivered product sales and how sales change over time.

**Planned visuals:**
- Horizontal bar chart of top product categories.
- Monthly delivered product sales line chart.
- KPI card for delivered product sales.
- Category comparison table.

**Business question:** Which categories are contributing most to product sales?

**Key finding:** Health & Beauty recorded approximately R$1.23 million in delivered product sales in the analysed results.

**Screenshot:**

![Sales and Product Categories Dashboard](dashboard/olist_dashboard_sales.png)

[Open the sales dashboard image](dashboard/olist_dashboard_sales.png)

---

### Dashboard 4 — Customer Geography

**Objective:** Compare customer activity, product sales, and delivery performance across states.

**Planned visuals:**
- Bar chart of delivered customers by state.
- Bar chart of delivered product sales by state.
- Optional map visual for geographic comparison.
- Table comparing state-level late-delivery rates.

**Business question:** Which regions contribute most to sales, and where might logistics need attention?

**Key finding:** São Paulo was the leading state in the analysed delivered customer and sales results.

**Screenshot placeholder:**

<!-- Add your Customer Geography dashboard screenshot here when available. -->

---

### Dashboard 5 — Customer Experience and Reviews

**Objective:** Examine how customer review scores differ between on-time and late orders.

**Planned visuals:**
- Average review score by delivery status.
- Bar chart showing review-score distribution.
- Optional trend chart for average review scores over time.

**Business question:** How do review scores differ between on-time and late deliveries?

**Key finding:** On-time orders averaged 4.29 out of 5, while late orders averaged 2.57 out of 5.

**Screenshot placeholder:**

<!-- Add your Customer Experience dashboard screenshot here when available. -->

---

## 💻 9. SQL Analysis Examples

The project used SQL to analyse order status, delivery performance, product sales, customer geography, and review scores.

The examples below illustrate the calculation logic. Table and column names may need to be adjusted to match the final imported schema.

### Example 1 — Order Status Distribution

```sql
SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_orders
FROM orders_import
GROUP BY order_status
ORDER BY total_orders DESC;
```

**Purpose:** Understand the distribution of orders across different statuses.

### Example 2 — Delivery Performance

This example assumes the table contains a calculated `delivery_status` column with the values `On Time` and `Late`.

```sql
SELECT
    delivery_status,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders_analysis
WHERE delivery_status IN ('On Time', 'Late')
GROUP BY delivery_status;
```

**Purpose:** Compare on-time and late deliveries using only orders that can be assessed.

### Example 3 — Product Sales by Category

This example assumes category translations have been joined to products and order items.

```sql
SELECT
    p.product_category_name_english AS product_category,
    ROUND(SUM(oi.price), 2) AS product_sales
FROM order_items_import AS oi
JOIN orders_import AS o
    ON oi.order_id = o.order_id
JOIN products_import AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name_english
ORDER BY product_sales DESC
LIMIT 10;
```

**Purpose:** Identify the highest-selling product categories by item price.

*Before using these examples as final project code, verify the actual table names, column names, data types, and category-translation joins in your MySQL schema.*

---

## 🐍 10. Python Analysis Examples

Python and pandas were used for data inspection and delivery metric calculations.

### Example 1 — Inspect a Dataset

```python
import pandas as pd

orders = pd.read_csv("olist_orders_dataset.csv")

print("Dataset shape:", orders.shape)
print(orders.head())
print(orders.info())
print(orders.isnull().sum())
```

### Example 2 — Check Duplicate Records

```python
print("Duplicate rows:", orders.duplicated().sum())
print(
    "Duplicate order IDs:",
    orders["order_id"].duplicated().sum()
)
```

### Example 3 — Calculate Delivery Time

```python
orders["order_purchase_timestamp"] = pd.to_datetime(
    orders["order_purchase_timestamp"],
    errors="coerce"
)

orders["order_delivered_customer_date"] = pd.to_datetime(
    orders["order_delivered_customer_date"],
    errors="coerce"
)

orders["delivery_days"] = (
    orders["order_delivered_customer_date"]
    - orders["order_purchase_timestamp"]
).dt.total_seconds() / 86400

print(
    "Average delivery time:",
    round(orders["delivery_days"].mean(), 2),
    "days"
)
```

These are illustrative examples of the analysis approach. Use your saved, tested notebook as the authoritative record of the actual code executed in the project.

---

## 📐 11. Example Power BI DAX Measures

The following measures illustrate how selected KPIs could be implemented in Power BI after the required tables, relationships, and calculated delivery status are configured.

### On-Time Orders

```dax
On-Time Orders =
CALCULATE(
    DISTINCTCOUNT(Orders[order_id]),
    Orders[delivery_status] = "On Time"
)
```

### Late Orders

```dax
Late Orders =
CALCULATE(
    DISTINCTCOUNT(Orders[order_id]),
    Orders[delivery_status] = "Late"
)
```

### On-Time Delivery Rate

```dax
On-Time Delivery Rate =
DIVIDE(
    [On-Time Orders],
    [On-Time Orders] + [Late Orders],
    0
)
```

Format this measure as a percentage.

### Delivered Product Sales

```dax
Delivered Product Sales =
CALCULATE(
    SUM(Items[price]),
    Orders[order_status] = "delivered"
)
```

**Important:** These are example measures for future implementation. They have not been presented as executed or validated in a completed interactive Power BI report.

---

## 💡 12. Business Recommendations

Based on the findings, the following actions are recommended for further investigation:

1. **Improve delivery reliability:** Investigate delivery delays by state, carrier, and estimated delivery date accuracy.
2. **Monitor customer feedback:** Review low-scoring orders and customer comments to identify possible service issues.
3. **Protect key markets:** Monitor sales and service quality in São Paulo while investigating opportunities in other states.
4. **Use category-level insights:** Explore inventory and marketing opportunities in high-performing product categories.
5. **Track performance over time:** Monitor delivery rates, sales trends, and review scores to assess future improvements.

These recommendations are proposed actions, not claims that business changes have already been implemented.

---

## ⚠️ 13. Data Quality, Limitations, and Assumptions

- Eight delivered orders did not have actual delivery dates and were excluded from the assessable delivery calculation.
- The on-time and late rates use 96,470 assessable delivered orders as the denominator.
- Some orders have multiple review records; review comparisons require order-level aggregation.
- The average delivery-time results from earlier Python and SQL checks differed slightly (12.56 versus 12.50 days). This discrepancy should be reconciled before reporting a single final average.
- Product sales represent item prices and exclude freight; they are not profit.
- The static dashboard images are visual designs, not an interactive Power BI report.
- SQL and Python examples in this README are illustrative unless explicitly matched to the saved, tested project files.

---

## 📚 14. Learning Outcomes

Through this project, I practised:

- Inspecting and understanding multi-table datasets.
- Checking missing values and duplicate records.
- Working with date and delivery metrics.
- Using SQL joins, grouping, filtering, and aggregations.
- Calculating business KPIs.
- Interpreting category, geographic, and customer review patterns.
- Communicating findings through dashboard designs.
- Translating data insights into practical business recommendations.

---

## 🚀 15. Future Improvements

- Reconcile all Python and SQL metrics and document the final calculation rules.
- Save and publish the complete SQL query file.
- Include the cleaned and documented Python notebook.
- Build and validate an interactive Power BI dashboard when suitable hardware is available.
- Add customer review distributions and monthly trends.
- Investigate repeat purchasing, seller performance, and delivery carrier patterns.
- Extend the analysis with profitability data if suitable cost information becomes available.

---

## ✅ 16. Conclusion

The Olist E-Commerce Customer Experience and Delivery Analytics project demonstrates a practical data analysis workflow, from data inspection and SQL analysis to business interpretation and dashboard design.

The analysis identified delivery performance patterns, leading product categories, geographic differences, and an association between delivery status and customer review scores.

These findings provide a foundation for further investigation into logistics, sales performance, and customer experience.

**Project status:** Python and SQL analysis performed; static dashboard designs prepared; interactive Power BI dashboard planned for future development.

---

### 👤 Author

**Data Analyst Portfolio Project**

Interested in data analytics, SQL, Python, business intelligence, and data-driven decision-making.

