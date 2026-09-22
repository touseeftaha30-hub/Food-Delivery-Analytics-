# Food Delivery Analytics. SQL Project

A SQL portfolio project simulating a food delivery platform's database (like Foodpanda/Uber Eats)  covering customers, restaurants, riders, orders, and ratings, with analytical queries built on top.

## Project Overview

This project models a food delivery ecosystem end to end:

**Customers → Orders → Restaurants → Menu Items → Riders → Ratings**

The goal was to design a realistic relational schema and write analytical SQL queries covering joins, CTEs, window functions, and conditional logic answering real operational and business questions a food delivery company would ask.

**Tools used:** MySQL

## Schema

| Table | Purpose |
|---|---|
| `customers` | App users — name, city, signup date |
| `restaurants` | Partner restaurants — cuisine type, city, rating |
| `riders` | Delivery riders |
| `menu_items` | Dishes offered per restaurant |
| `orders` | Order transactions — status, delivery time, total amount |
| `order_items` | Line items within each order (many-to-many bridge) |
| `ratings` | Customer feedback per order (restaurant + rider rating) |

## Analysis Queries & Concepts Used

1. **Revenue per resturant** total revenue from delivered orders, by restaurant (JOIN + aggregation)
2. **Average delivery time per rider** identifies fastest/slowest riders (JOIN + AVG, filtered to delivered orders)
3. **Items ordered per restaurant** quantity sold per menu item, by restaurant (JOIN + aggregation)
4. **Average restaurant rating** real customer-review average vs. the static rating stored on the restaurant (multi-table JOIN through the `ratings` bridge)
5. **Running total of revenue per restaurant** cumulative revenue over time, partitioned by restaurant (window function: `SUM() OVER (PARTITION BY ,ORDER BY)`)
6. **Ranking orders per customer by size** each customer's biggest to smallest order (window function: `RANK() OVER (PARTITION BY ...)`)
7. **Gap between a customer's consecutive orders** days between orders, per customer (window function: `LAG()` + `DATEDIFF()`)
8. **Customers spending above the average**  two CTE pattern: one CTE for per customer spend, one for the overall average, compared via `CROSS JOIN`
9. **Order volume by hour of day**  identifies peak ordering hours (CTE + `HOUR()` + aggregation)
10. **City-wise revenue**  total revenue grouped by customer city (JOIN + aggregation)

### Key Insights
 Cancelled orders are excluded from all revenue and performance metrics including a cancelled order's data would overstate revenue and distort rider delivery-time averages.
 A rider's average delivery time changed meaningfully once cancelled orders were removed from the calculation, showing how including incomplete orders can misrepresent real performance.
 Restaurant ratings calculated from actual customer reviews (`ratings` table) differ slightly from the static rating stored on the restaurant record  suggesting the static field should be refreshed periodically from live review data.

## How to Run

1. Open the `.sql` file in MySQL Workbench (or any MySQL client).
2. Run the script top to bottom — it creates the database, tables, inserts sample data, and includes all analysis queries at the end.
3. Run each query individually (separated by comments) to see results one at a time.
