-- Rank customers based on total revenue using window functions.
with customer_revenue as (
	select customer_id, sum(payment_value) as revenue
    from orders as o
    join payments as p
    on o.order_id = p.order_id
    group by o.customer_id
)
select customer_id, revenue, rank() over(order by revenue desc) as customer_rank
from customer_revenue;

-- Calculate running total of revenue over time.
with month_revenue as(
	select 
		date_format(str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'), '%Y-%m') as order_month,
		sum(payment_value) as revenue
        from orders as o
        join payments as p
        on p.order_id = o.order_id
        group by order_month
)
select order_month,	revenue, sum(revenue) over(order by order_month) as running_total_revenue
from month_revenue;


-- Find the month-over-month revenue growth.
with month_revenue as(
	select 
		date_format(str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'), '%Y-%m') as order_month,
		sum(payment_value) as revenue
        from orders as o
        join payments as p
        on p.order_id = o.order_id
        group by order_month
)
select 
	order_month,
	revenue, 
    lag(revenue) over(order by order_month) as previous_month_revenue,
    round((revenue - lag(revenue) over(order by order_month)) *100.0 / lag(revenue) over(order by order_month)) as growth_mom
from month_revenue;