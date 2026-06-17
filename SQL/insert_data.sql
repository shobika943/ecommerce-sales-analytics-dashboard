USE ecommerce_analytics;

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);

CREATE TABLE payments(
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
);

INSERT INTO customers VALUES
(1,'Arun','Chennai'),
(2,'Divya','Mumbai'),
(3,'Karthik','Chennai'),
(4,'Priya','Delhi'),
(5,'Rahul','Bangalore');

INSERT INTO products VALUES
(101,'Laptop','Electronics',50000),
(102,'Phone','Electronics',20000),
(103,'Chair','Furniture',5000),
(104,'Table','Furniture',10000),
(105,'Headphones','Electronics',3000);

INSERT INTO orders VALUES
(1,1,101,1,'2024-01-01'),
(2,2,102,2,'2024-01-02'),
(3,3,103,3,'2024-01-03'),
(4,1,102,1,'2024-01-04'),
(5,5,105,2,'2024-01-05');

INSERT INTO payments VALUES
(1,1,'UPI','Completed'),
(2,2,'Card','Completed'),
(3,3,'Cash','Completed'),
(4,4,'UPI','Completed'),
(5,5,'Card','Completed');