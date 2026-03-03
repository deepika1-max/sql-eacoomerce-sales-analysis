USE ecommerce_db;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;

#Total Revenue 
SELECT SUM(p.price * od.quantity) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id

#Total orders 
SELECT COUNT(*) AS total_orders FROM orders;

# Revenue by city
SELECT c.city, SUM(p.price * od.quantity) AS revenue
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.city;

#Monthly sales trend
SELECT MONTH(o.order_date) AS month, SUM(p.price * od.quantity) AS monthly_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id= p.product_id
GROUP BY MONTH(o.order_date)
ORDER BY month;

#Top customers by spending
SELECT c.customer_name, SUM(p.price * od.quantity) AS spending 
FROM customers c
JOIN orders o ON c.customer_id= o.customer_id
JOIN order_details od ON o.order_id=od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY spending DESC;

#BEST SELLING PRODUCTS

SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM products p 
JOIN order_details od ON P.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;