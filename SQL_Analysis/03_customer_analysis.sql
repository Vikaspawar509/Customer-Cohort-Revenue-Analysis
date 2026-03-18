USE Cohort_Retension;

-- Find the number of repeat customers.
select customer_id
from orders 
group by customer_id
having count(order_id) > 1;

-- Calculate the average number of orders per customer.
select avg(order_count) 
from (
	select customer_id, count(order_id) as order_count
	from orders 
	group by customer_id
) t;

-- Find the percentage of customers who made only one purchase.
select (count(customer_id)*100.0 / (select count(distinct customer_id) from orders) 
)as share_single_purchase_customer
from (
select customer_id from orders group by customer_id having count(order_id) = 1) as one_time_coudtoper;


-- Customer Lifetime Value
with customer_revenue as (
    select 
        o.customer_id,
        SUM(p.payment_value) as total_spent
    from orders o
    join payments p on o.order_id = p.order_id
    group by o.customer_id
)
SELECT AVG(total_spent) AS avg_clv
FROM customer_revenue;