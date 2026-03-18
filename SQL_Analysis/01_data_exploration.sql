
USE Cohort_Retension;

-- Total number of customers
select count(customer_id) from Customers;

-- Total number of orders
SELECT Count(order_id) FROM Orders;

-- Total number of products
SELECT Count(product_id) from Products;

-- Date range of orders
select min(order_purchase_timestamp) , max(order_purchase_timestamp) FROM Orders;

-- Orders per customer
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;