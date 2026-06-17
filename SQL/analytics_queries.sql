USE ecommerce_analytics;

-- Query 1: Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Query 2: Total Products
SELECT COUNT(*) AS total_products
FROM products;

-- Query 3: Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Query 4: Total Revenue
SELECT
    SUM(products.price * orders.quantity) AS total_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id;

-- Query 5: Product Wise Sales
SELECT
    products.product_name,
    SUM(orders.quantity) AS quantity_sold
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY products.product_name;

-- Query 6: Top Selling Products
SELECT
    products.product_name,
    SUM(orders.quantity) AS total_sales
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_sales DESC;

-- Query 7: Customer Purchase Details
SELECT
    customers.customer_name,
    products.product_name,
    orders.quantity
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id;

-- Query 8: Customers By City
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city;

-- Query 9: Payment Analysis
SELECT
    payment_method,
    COUNT(*) AS transactions
FROM payments
GROUP BY payment_method;

-- Query 10: Monthly Revenue
SELECT
    MONTH(order_date) AS month,
    SUM(products.price * orders.quantity) AS revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY MONTH(order_date);