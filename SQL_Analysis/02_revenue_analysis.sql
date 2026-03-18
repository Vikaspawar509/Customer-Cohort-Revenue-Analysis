USE Cohort_Retension;

-- Calculate total revenue generated.
select sum(payment_value) as total_revenue 
from payments;

-- Find monthly revenue trend.
select 
	date_format(str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'), '%Y-%m') as order_month,
	sum(p.payment_value) as Total_Revenue
from orders as o
join payments as p
on o.order_id = p.order_id
group by order_month
order by order_month;

-- Find the top 10 highest revenue generating products.
SELECT ol.product_id, sum(p.payment_value) as Total_Revenue
from olist_order_items_dataset as ol
join payments as p
on p.order_id = ol.order_id
group by ol.product_id
order by Total_Revenue desc
limit 10;

-- Find the top 10 customers by total spending.
SELECT customer_id, sum(p.payment_value) as Total_Revenue
from orders as o
join payments as p
on o.order_id = p.order_id
group by customer_id
order by Total_Revenue desc
limit 10;