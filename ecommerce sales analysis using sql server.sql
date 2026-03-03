CREATE DATABASE sales_db;
USE ecommerce_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers VALUES
(1,'Rahul','Delhi','2023-01-10'),
(2,'Anita','Mumbai','2023-02-15'),
(3,'Vikas','Delhi','2023-03-05'),
(4,'Neha','Pune','2023-04-12');

INSERT INTO products VALUES
(101,'Laptop','Electronics',50000),
(102,'Mobile','Electronics',20000),
(103,'Headphones','Accessories',2000),
(104,'Keyboard','Accessories',1500);

INSERT INTO orders VALUES
(1001,1,'2023-05-01'),
(1002,2,'2023-05-03'),
(1003,1,'2023-06-10'),
(1004,3,'2023-06-15');

INSERT INTO order_details VALUES
(1,1001,101,1),
(2,1001,103,2),
(3,1002,102,1),
(4,1003,104,1),
(5,1004,102,1);

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