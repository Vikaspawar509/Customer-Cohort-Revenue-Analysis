-- Calculate monthly customer retention rate.
with customer_orders as (
	select customer_id, date_format(str_to_date(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'), '%Y-%m') as order_month
    from orders
),
monthly_active as (
select distinct
	customer_id, order_month
    from customer_orders
),
retention_table as (
	select a.order_month as current_month,
    count(distinct a.customer_id) as active_customers,
    count(distinct b.customer_id) as retained_customers
    from monthly_active as a
    left join monthly_active as b
    on a.customer_id = b.customer_id
    and date_format(date_add(str_to_date(a.order_month, '%Y-%m'), interval 1 month), '%Y-%m'
    ) = b.order_month
    group by a.order_month
)
select current_month, active_customers, retained_customers,
(retained_customers * 100.0 / active_customers) as retention_rate
from retention_table
order by current_month;


-- Find customers who did not return after their first purchase.
select customer_id
from orders 
group by customer_id
having count(customer_id) =1;