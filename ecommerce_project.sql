CREATE DATABASE ecommerce_db;
USE ecommerce_db;
CREATE TABLE orders (
 order_id INT PRIMARY KEY,
 customer_name VARCHAR(50),
 product VARCHAR(50),
 category VARCHAR(50),
 quantity INT,
 price DECIMAL(10,2),
 order_date DATE,
 city VARCHAR(50)
);
INSERT INTO orders VALUES
(1, 'Aman', 'Laptop', 'Electronics', 1, 50000, '2024-01-15', 'Delhi'),
(2, 'Riya', 'Shoes', 'Fashion', 2, 2000, '2024-01-15', 'Mumbai'),
(3, 'Rahul', 'Mobile', 'Electronics', 1, 20000, '2024-02-01', 'Delhi'),
(4, 'Sneha', 'T-shirt', 'Fashion', 3, 1500, '2024-02-10', 'Pune'),
(5, 'Aman', 'Headphones', 'Electronics', 2, 3000, '2024-03-05', 'Delhi');

# FIND TOTAL SALES

SELECT SUM(quantity * price) AS total_sales FROM orders;

#CATEGORY WISE SALES

SELECT category, SUM(quantity*price) AS category_sales 
FROM orders
GROUP BY category;

#top custormer 

SELECT customer_name, SUM(quantity*price) AS total_spent
FROM orders
GROUP BY customer_name
ORDER BY total_spent DESC;

# MONTHLY SALES

SELECT MONTH(order_date) AS month,
SUM(quantity * price) AS monthly_sales
FROM orders
GROUP BY MONTH(order_date);

