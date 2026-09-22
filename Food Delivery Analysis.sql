CREATE DATABASE FOOD_DELIVERY;
USE FOOD_DELIVERY;

-- ================================
-- MASTER TABLES
-- ================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50),
    city VARCHAR(50),
    rating DECIMAL(2,1)
);

CREATE TABLE riders (
    rider_id INT PRIMARY KEY AUTO_INCREMENT,
    rider_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    joining_date DATE
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- ================================
-- TRANSACTIONAL TABLES
-- ================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    rider_id INT,
    order_date DATE NOT NULL,
    order_time TIME,
    delivery_time_minutes INT,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(20),   -- Delivered, Cancelled, In Progress
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (rider_id) REFERENCES riders(rider_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

CREATE TABLE ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    restaurant_rating DECIMAL(2,1),
    rider_rating DECIMAL(2,1),
    review_text VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ================================
-- EXPANDED DATA — FOOD DELIVERY PROJECT
-- ================================

-- CUSTOMERS
INSERT INTO customers (customer_name, city, signup_date) VALUES
('Ahmed Raza', 'Lahore', '2024-11-01'),
('Sara Khan', 'Karachi', '2024-11-05'),
('Bilal Ahmed', 'Lahore', '2024-12-01'),
('Ayesha Malik', 'Islamabad', '2024-12-10'),
('Usman Tariq', 'Karachi', '2025-01-02'),
('Hina Shah', 'Lahore', '2025-01-05'),
('Tariq Mehmood', 'Islamabad', '2025-01-10'),
('Nadia Aslam', 'Karachi', '2025-01-15'),
('Fahad Siddiqui', 'Lahore', '2025-01-20'),
('Mahnoor Ali', 'Islamabad', '2025-02-01');

-- RESTAURANTS
INSERT INTO restaurants (restaurant_name, cuisine_type, city, rating) VALUES
('Spice Villa', 'Pakistani', 'Lahore', 4.5),
('Pizza Point', 'Italian', 'Lahore', 4.2),
('Karachi Broast', 'Fast Food', 'Karachi', 4.0),
('Cafe Aroma', 'Continental', 'Islamabad', 4.6),
('Noodle House', 'Chinese', 'Karachi', 3.9),
('Lahore Tikka Corner', 'Pakistani', 'Lahore', 4.3),
('Steak House', 'Continental', 'Islamabad', 4.1);

-- RIDERS
INSERT INTO riders (rider_name, city, joining_date) VALUES
('Faisal Iqbal', 'Lahore', '2024-10-01'),
('Zeeshan Ali', 'Karachi', '2024-10-15'),
('Hamza Sheikh', 'Lahore', '2024-11-01'),
('Kashif Nawaz', 'Islamabad', '2024-11-20'),
('Waqas Anjum', 'Karachi', '2024-12-01'),
('Imran Butt', 'Lahore', '2024-12-15');

-- MENU ITEMS
INSERT INTO menu_items (restaurant_id, item_name, category, price) VALUES
(1, 'Chicken Karahi', 'Main Course', 1200.00),
(1, 'Seekh Kebab', 'BBQ', 450.00),
(1, 'Mutton Pulao', 'Main Course', 900.00),
(2, 'Margherita Pizza', 'Pizza', 900.00),
(2, 'Pasta Alfredo', 'Pasta', 750.00),
(2, 'Garlic Bread', 'Sides', 300.00),
(3, 'Broast Half', 'Fast Food', 550.00),
(3, 'Zinger Burger', 'Burger', 400.00),
(3, 'French Fries', 'Sides', 250.00),
(4, 'Grilled Sandwich', 'Snacks', 500.00),
(4, 'Cappuccino', 'Beverage', 350.00),
(4, 'Club Sandwich', 'Snacks', 600.00),
(5, 'Chicken Chowmein', 'Noodles', 600.00),
(5, 'Spring Rolls', 'Appetizer', 400.00),
(5, 'Sweet & Sour Chicken', 'Main Course', 750.00),
(6, 'Beef Tikka', 'BBQ', 650.00),
(6, 'Chicken Malai Boti', 'BBQ', 700.00),
(7, 'Sirloin Steak', 'Main Course', 1800.00),
(7, 'Grilled Chicken', 'Main Course', 1100.00);

-- ORDERS (Jan & Feb 2025)
INSERT INTO orders (customer_id, restaurant_id, rider_id, order_date, order_time, delivery_time_minutes, total_amount, order_status) VALUES
(1, 1, 1, '2025-01-05', '13:30:00', 35, 1650.00, 'Delivered'),
(2, 3, 2, '2025-01-06', '19:00:00', 28, 950.00, 'Delivered'),
(3, 2, 3, '2025-01-07', '20:15:00', 40, 1650.00, 'Delivered'),
(4, 4, 4, '2025-01-08', '09:00:00', 22, 850.00, 'Delivered'),
(1, 1, 1, '2025-01-15', '14:00:00', 30, 450.00, 'Delivered'),
(5, 5, 2, '2025-01-16', '21:00:00', 45, 1000.00, 'Cancelled'),
(2, 3, 2, '2025-02-01', '12:30:00', 25, 400.00, 'Delivered'),
(3, 2, 3, '2025-02-03', '18:45:00', 33, 900.00, 'Delivered'),
(4, 4, 4, '2025-02-05', '10:00:00', 20, 850.00, 'Delivered'),
(1, 1, 1, '2025-02-10', '13:00:00', 38, 1200.00, 'Delivered'),
(6, 6, 3, '2025-01-09', '19:30:00', 30, 1350.00, 'Delivered'),
(7, 7, 4, '2025-01-11', '20:00:00', 50, 2900.00, 'Delivered'),
(8, 5, 5, '2025-01-12', '13:15:00', 27, 1150.00, 'Delivered'),
(9, 2, 6, '2025-01-14', '19:45:00', 42, 1200.00, 'Cancelled'),
(10, 4, 4, '2025-01-18', '08:30:00', 18, 950.00, 'Delivered'),
(6, 1, 1, '2025-01-22', '14:30:00', 33, 900.00, 'Delivered'),
(7, 6, 3, '2025-01-25', '21:15:00', 55, 1350.00, 'Delivered'),
(8, 3, 5, '2025-01-28', '12:00:00', 24, 650.00, 'Delivered'),
(2, 5, 2, '2025-02-02', '18:30:00', 31, 1150.00, 'Delivered'),
(3, 6, 3, '2025-02-06', '20:30:00', 29, 700.00, 'Delivered'),
(9, 7, 6, '2025-02-08', '19:00:00', 48, 1800.00, 'Delivered'),
(10, 4, 4, '2025-02-11', '09:30:00', 19, 600.00, 'Delivered'),
(5, 3, 2, '2025-02-14', '13:45:00', 26, 400.00, 'Delivered'),
(1, 2, 3, '2025-02-16', '19:15:00', 36, 1650.00, 'Cancelled'),
(4, 1, 1, '2025-02-18', '14:15:00', 34, 1650.00, 'Delivered'),
(6, 5, 5, '2025-02-20', '20:00:00', 40, 750.00, 'Delivered'),
(7, 4, 4, '2025-02-22', '08:45:00', 21, 850.00, 'Delivered'),
(8, 6, 3, '2025-02-24', '19:30:00', 32, 1350.00, 'Delivered'),
(9, 1, 1, '2025-02-25', '13:00:00', 37, 1200.00, 'Delivered'),
(10, 2, 6, '2025-02-27', '20:45:00', 44, 900.00, 'Delivered');

-- ORDER ITEMS
INSERT INTO order_items (order_id, item_id, quantity) VALUES
(1, 1, 1), (1, 2, 1),
(2, 7, 1), (2, 8, 1),
(3, 4, 1), (3, 5, 1),
(4, 10, 1), (4, 11, 1),
(5, 2, 1),
(6, 13, 1), (6, 14, 1),
(7, 7, 1),
(8, 4, 1),
(9, 10, 1), (9, 11, 1),
(10, 1, 1),
(11, 16, 1), (11, 17, 1),
(12, 18, 1), (12, 19, 1),
(13, 13, 1), (13, 15, 1),
(14, 4, 1), (14, 6, 1),
(15, 10, 1), (15, 12, 1),
(16, 3, 1),
(17, 16, 1), (17, 17, 1),
(18, 7, 1), (18, 9, 1),
(19, 13, 1), (19, 14, 1),
(20, 16, 1),
(21, 18, 1),
(22, 10, 1),
(23, 7, 1),
(24, 5, 1), (24, 6, 1),
(25, 1, 1),
(26, 13, 1),
(27, 10, 1), (27, 11, 1),
(28, 16, 1), (28, 17, 1),
(29, 1, 1),
(30, 4, 1);

-- RATINGS (cancelled orders skipped — realistic, no rating for undelivered orders)
INSERT INTO ratings (order_id, customer_id, restaurant_rating, rider_rating, review_text) VALUES
(1, 1, 4.5, 5.0, 'Great food and fast delivery!'),
(2, 2, 4.0, 4.5, 'Good taste, slightly late'),
(3, 3, 4.2, 4.0, 'Loved the pasta'),
(4, 4, 4.8, 5.0, 'Excellent service'),
(5, 1, 4.5, 4.5, 'Consistent quality'),
(7, 2, 3.8, 4.0, 'Average experience'),
(8, 3, 4.3, 4.2, 'Will order again'),
(9, 4, 4.6, 4.8, 'Perfect breakfast'),
(10, 1, 4.5, 5.0, 'Best karahi in town'),
(11, 6, 4.4, 4.5, 'Tasty tikka'),
(12, 7, 4.0, 3.8, 'Steak was a bit cold'),
(13, 8, 4.1, 4.6, 'Nice noodles'),
(15, 10, 4.7, 5.0, 'Loved the sandwich'),
(16, 6, 4.5, 4.9, 'Very fast delivery'),
(17, 7, 4.2, 4.0, 'Good BBQ'),
(18, 8, 3.9, 4.1, 'Okay experience'),
(19, 2, 4.1, 4.3, 'Nice noodles again'),
(20, 3, 4.3, 4.5, 'Great tikka'),
(21, 9, 4.0, 3.9, 'Steak was good'),
(22, 10, 4.6, 4.8, 'Quick delivery'),
(23, 5, 3.7, 4.0, 'Average'),
(25, 4, 4.5, 4.9, 'Loved the karahi'),
(26, 6, 4.2, 4.0, 'Noodles were good'),
(27, 7, 4.6, 4.7, 'Perfect breakfast'),
(28, 8, 4.3, 4.4, 'Great tikka again'),
(29, 9, 4.5, 4.8, 'Excellent karahi'),
(30, 10, 4.0, 3.9, 'Good pizza');

--  1 Revenue per restaurants  

select sum(total_amount),orders.restaurant_id,restaurant_name from orders
right join restaurants 
on orders.restaurant_id=restaurants.restaurant_id
where order_status='Delivered'
group by orders.restaurant_id;

--  2 average delivery time per rider

select  avg(delivery_time_minutes),orders.rider_id,rider_name from orders
left join  riders
on riders.rider_id=orders.rider_id
where order_status='Delivered'
group by rider_id;

-- 3 items ordered per resturant  
 select sum(quantity),restaurant_id,item_name from   menu_items
join order_items 
on menu_items.item_id=order_items.item_id
group by restaurant_id, item_name ;

-- 4 average rating of resturant 
select avg(restaurant_rating),restaurant_name from restaurants 
join orders 
on restaurants.restaurant_id=orders.restaurant_id
join ratings
on orders.order_id=ratings.order_id
group by restaurant_name;
 
 
 -- 5 Running total of resturants day wise
 
 select order_date ,total_amount,restaurant_id,
 sum(total_amount) over( partition by restaurant_id order by order_date) as running_total
 from orders 
 where order_status= 'Delivered';
 
 
 -- 6 . Ranking orders per customer based on order size
 
 select total_amount,restaurant_id ,order_status, customer_id,
 rank() over(partition by customer_id order by total_amount desc) AS size_of_order
 from orders
 where order_status= 'Delivered';

-- 7 gap between 1 and next orders of customers
select total_amount,order_date,total_amount,customer_id,
datediff(order_date,lag(order_date) over(partition by customer_id order by order_date)) as order_gap
from orders
 where order_status='Delivered';
 
 -- 8 customers having spending more then the averge spending of customers
WITH customer_spent AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY customer_id
),
overall_average AS (
    SELECT AVG(total_spent) AS avg_spent
    FROM customer_spent
)
SELECT cs.customer_id, cs.total_spent
FROM customer_spent AS cs
CROSS JOIN overall_average AS oa
WHERE cs.total_spent > oa.avg_spent;
 
-- 9 order per hour 
with order_per_hour as( 
select count(*) as order_hourly, hour(order_time) as hours from orders
group by hour(order_time))  
select order_hourly, hours 
from order_per_hour
order by order_hourly desc ;

-- 10  city wise revenue
select city , sum(total_amount)from orders 
join customers 
on orders.customer_id = customers.customer_id
where order_status= 'Delivered'
group by city;




