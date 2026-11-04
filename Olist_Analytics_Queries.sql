
-- Olist E-Commerce Customer Experience & Delivery Analytics
-- SQL analysis queries for the Brazilian Olist e-commerce dataset.
-- Run this script after importing the source tables into the olist_analytics schema.
-- Sales figures below use item price and exclude freight; they are not profit.

USE olist_analytics;

-- =====================================================
-- 1. BASIC BUSINESS KPIs
-- =====================================================

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'delivered' THEN o.order_id
    END) AS delivered_orders,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'canceled' THEN o.order_id
    END) AS canceled_orders,
    ROUND(SUM(p.payment_value), 2) AS total_payment_value,
    -- Average payment record value (not average order value)
    ROUND(AVG(p.payment_value), 2) AS average_payment_record_value
FROM orders_import o
LEFT JOIN order_payments_import p
    ON o.order_id = p.order_id;


-- =====================================================
-- 2. ORDER STATUS ANALYSIS
-- =====================================================

SELECT
    order_status,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT order_id) * 100.0 /
        (SELECT COUNT(DISTINCT order_id) FROM orders_import),
        2
    ) AS order_percentage
FROM orders_import
GROUP BY order_status
ORDER BY total_orders DESC;


-- =====================================================
-- 3. MONTHLY SALES ANALYSIS
-- Delivered orders; sales are item price only
-- =====================================================

SELECT
    DATE_FORMAT(
        STR_TO_DATE(o.order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'),
        '%Y-%m'
    ) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(i.price), 2) AS total_sales
FROM orders_import o
INNER JOIN order_items_import i
    ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;


-- =====================================================
-- 4. DELIVERY PERFORMANCE ANALYSIS
-- =====================================================

SELECT
    COUNT(*) AS eligible_delivered_orders,

    SUM(CASE
        WHEN STR_TO_DATE(o.order_delivered_customer_date, '%Y-%m-%d %H:%i:%s')
          <= STR_TO_DATE(o.order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
        THEN 1 ELSE 0
    END) AS on_time_orders,

    SUM(CASE
        WHEN STR_TO_DATE(o.order_delivered_customer_date, '%Y-%m-%d %H:%i:%s')
          > STR_TO_DATE(o.order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
        THEN 1 ELSE 0
    END) AS late_orders,

    ROUND(AVG(
        DATEDIFF(
            STR_TO_DATE(o.order_delivered_customer_date, '%Y-%m-%d %H:%i:%s'),
            STR_TO_DATE(o.order_purchase_timestamp, '%Y-%m-%d %H:%i:%s')
        )
    ), 2) AS average_delivery_days,

    ROUND(
        SUM(CASE
            WHEN STR_TO_DATE(o.order_delivered_customer_date, '%Y-%m-%d %H:%i:%s')
              <= STR_TO_DATE(o.order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*), 2
    ) AS on_time_delivery_percentage

FROM orders_import o
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_delivered_customer_date <> ''
  AND o.order_estimated_delivery_date IS NOT NULL
  AND o.order_estimated_delivery_date <> '';


-- =====================================================
-- 5. DELIVERY PERFORMANCE BY CUSTOMER STATE
-- =====================================================

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_delivered_orders,

    SUM(CASE
        WHEN STR_TO_DATE(o.order_delivered_customer_date, '%Y-%m-%d %H:%i:%s')
          > STR_TO_DATE(o.order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
        THEN 1 ELSE 0
    END) AS late_orders,

    ROUND(
        SUM(CASE
            WHEN STR_TO_DATE(o.order_delivered_customer_date, '%Y-%m-%d %H:%i:%s')
              > STR_TO_DATE(o.order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*), 2
    ) AS late_delivery_percentage

FROM orders_import o
INNER JOIN customers_import c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_delivered_customer_date <> ''
  AND o.order_estimated_delivery_date IS NOT NULL
  AND o.order_estimated_delivery_date <> ''
GROUP BY c.customer_state
ORDER BY late_delivery_percentage DESC;


-- =====================================================
-- 6. STATE-WISE SALES ANALYSIS
-- Delivered orders; item price only, excluding freight
-- =====================================================

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(i.price), 2) AS total_sales
FROM orders_import o
INNER JOIN customers_import c
    ON o.customer_id = c.customer_id
INNER JOIN order_items_import i
    ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_sales DESC;


-- =====================================================
-- 7. PRODUCT CATEGORY PERFORMANCE
-- =====================================================

SELECT
    COALESCE(
        NULLIF(TRIM(t.product_category_name_english), ''),
        NULLIF(TRIM(p.product_category_name), ''),
        'Unknown'
    ) AS product_category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(i.order_item_id) AS total_items_sold,
    ROUND(SUM(i.price), 2) AS total_sales
FROM orders_import o
INNER JOIN order_items_import i
    ON o.order_id = i.order_id
INNER JOIN products_import p
    ON i.product_id = p.product_id
LEFT JOIN category_translation_import t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY product_category
ORDER BY total_sales DESC;


-- =====================================================
-- 8. CUSTOMER REVIEW SCORE ANALYSIS
-- =====================================================

SELECT
    review_score,
    COUNT(*) AS total_review_records,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM order_reviews_import
         WHERE review_score IS NOT NULL),
        2
    ) AS review_percentage
FROM order_reviews_import
WHERE review_score IS NOT NULL
GROUP BY review_score
ORDER BY review_score;


-- =====================================================
-- 9. ON-TIME VS LATE DELIVERY AND REVIEW SCORES
-- Average review score per order is used
-- =====================================================

SELECT
    delivery_groups.delivery_status,
    COUNT(*) AS total_orders,
    ROUND(AVG(review_groups.avg_review_score), 2)
        AS average_review_score
FROM
(
    SELECT
        o.order_id,
        CASE
            WHEN STR_TO_DATE(o.order_delivered_customer_date, '%Y-%m-%d %H:%i:%s')
               <= STR_TO_DATE(o.order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
            THEN 'On Time'
            ELSE 'Late'
        END AS delivery_status
    FROM orders_import o
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
      AND o.order_delivered_customer_date <> ''
      AND o.order_estimated_delivery_date IS NOT NULL
      AND o.order_estimated_delivery_date <> ''
) AS delivery_groups
INNER JOIN
(
    SELECT
        order_id,
        AVG(review_score) AS avg_review_score
    FROM order_reviews_import
    WHERE review_score IS NOT NULL
    GROUP BY order_id
) AS review_groups
    ON delivery_groups.order_id = review_groups.order_id
GROUP BY delivery_groups.delivery_status;


-- =====================================================
-- 10. REPEAT CUSTOMER ANALYSIS
-- Based on customer_unique_id
-- =====================================================

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_order_count > 1 THEN 1 ELSE 0 END)
        AS repeat_customers,
    SUM(CASE WHEN customer_order_count = 1 THEN 1 ELSE 0 END)
        AS one_time_customers,
    ROUND(
        SUM(CASE WHEN customer_order_count > 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS repeat_customer_percentage
FROM
(
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS customer_order_count
    FROM orders_import o
    INNER JOIN customers_import c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
) AS customer_summary;


-- =====================================================
-- 11. TOP 10 SELLING PRODUCT CATEGORIES
-- =====================================================

SELECT
    COALESCE(
        NULLIF(TRIM(t.product_category_name_english), ''),
        NULLIF(TRIM(p.product_category_name), ''),
        'Unknown'
    ) AS product_category,
    COUNT(i.order_item_id) AS items_sold,
    ROUND(SUM(i.price), 2) AS total_sales
FROM orders_import o
INNER JOIN order_items_import i
    ON o.order_id = i.order_id
INNER JOIN products_import p
    ON i.product_id = p.product_id
LEFT JOIN category_translation_import t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY product_category
ORDER BY items_sold DESC, total_sales DESC, product_category
LIMIT 10;


-- =====================================================
-- 12. LOWEST SELLING PRODUCT CATEGORIES
-- =====================================================

SELECT
    COALESCE(
        NULLIF(TRIM(t.product_category_name_english), ''),
        NULLIF(TRIM(p.product_category_name), ''),
        'Unknown'
    ) AS product_category,
    COUNT(i.order_item_id) AS items_sold,
    ROUND(SUM(i.price), 2) AS total_sales
FROM orders_import o
INNER JOIN order_items_import i
    ON o.order_id = i.order_id
INNER JOIN products_import p
    ON i.product_id = p.product_id
LEFT JOIN category_translation_import t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY product_category
ORDER BY items_sold ASC, total_sales ASC, product_category
LIMIT 10;
