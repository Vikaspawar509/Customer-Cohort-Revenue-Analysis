-- Identify the first purchase month of each customer.
select customer_id, 
    date_format(min(str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s')),'%Y-%m') as order_month
	from orders
    group by customer_id;
    
    
-- Create customer cohorts based on first purchase month.
with first_order_month as(
	select customer_id, 
    min(date_format(str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'),'%Y-%m')) as cohort_month
    from orders
    group by customer_id
), 
customers_orders as(
	select customer_id,
    date_format(str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'),'%Y-%m') as order_month
	from orders
)
select 
	c.customer_id,
    f.cohort_month,
    c.order_month
from customers_orders as c
join first_order_month as f
on c.customer_id = f.customer_id;
	
    
    
-- Calculate cohort retention after month 1, 2, and 3.
WITH first_purchase AS (
    SELECT 
        customer_id,
        DATE_FORMAT(
            MIN(STR_TO_DATE(order_purchase_timestamp,'%Y-%m-%d %H:%i:%s')),
            '%Y-%m'
        ) AS cohort_month
    FROM orders
    GROUP BY customer_id
),

customer_orders AS (
    SELECT 
        customer_id,
        DATE_FORMAT(
            STR_TO_DATE(order_purchase_timestamp,'%Y-%m-%d %H:%i:%s'),
            '%Y-%m'
        ) AS order_month
    FROM orders
),

cohort_data AS (
    SELECT 
        c.customer_id,
        f.cohort_month,
        c.order_month,
        TIMESTAMPDIFF(
            MONTH,
            STR_TO_DATE(f.cohort_month, '%Y-%m'),
            STR_TO_DATE(c.order_month, '%Y-%m')
        ) AS month_number
    FROM customer_orders c
    JOIN first_purchase f
        ON c.customer_id = f.customer_id
),

cohort_counts AS (
    SELECT 
        cohort_month,
        month_number,
        COUNT(DISTINCT customer_id) AS num_customers
    FROM cohort_data
    WHERE month_number IN (0,1,2,3)
    GROUP BY cohort_month, month_number
),

cohort_size AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT customer_id) AS total_customers
    FROM first_purchase
    GROUP BY cohort_month
)

SELECT 
    cc.cohort_month,
    MAX(CASE WHEN cc.month_number = 0 THEN cc.num_customers END) AS month_0,
    MAX(CASE WHEN cc.month_number = 1 THEN cc.num_customers END) AS month_1,
    MAX(CASE WHEN cc.month_number = 2 THEN cc.num_customers END) AS month_2,
    MAX(CASE WHEN cc.month_number = 3 THEN cc.num_customers END) AS month_3,

    ROUND(MAX(CASE WHEN cc.month_number = 1 THEN cc.num_customers END) * 100.0 / cs.total_customers,2) AS retention_m1,
    ROUND(MAX(CASE WHEN cc.month_number = 2 THEN cc.num_customers END) * 100.0 / cs.total_customers,2) AS retention_m2,
    ROUND(MAX(CASE WHEN cc.month_number = 3 THEN cc.num_customers END) * 100.0 / cs.total_customers,2) AS retention_m3

FROM cohort_counts cc
JOIN cohort_size cs
    ON cc.cohort_month = cs.cohort_month
GROUP BY cc.cohort_month, cs.total_customers
ORDER BY cc.cohort_month;