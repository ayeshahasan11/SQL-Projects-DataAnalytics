# Farmers' Market SQL Data Analysis

## Overview
This project demonstrates how SQL can be used to explore and analyze data from a simulated farmers’ market database.  
The database contains information about vendors, customers, products, booth assignments, and purchases.

The goal of the project was to answer real business questions, such as:
- Which vendors rent booths most frequently?
- Who are the highest-spending customers?
- How can products be categorized for marketing purposes?

---

## Dataset
- **Database:** `farmersmarket.db` (SQLite)
- **Tables Used:**
  - `vendor`, `vendor_booth_assignments`
  - `customer`, `customer_purchases`
  - `product`
- **Size:** 10 tables, ~5,000 rows total

---

## Skills Demonstrated
- Data extraction with `SELECT` and `WHERE`
- Conditional transformations with `CASE`
- Table joins with `INNER JOIN`
- Aggregation using `COUNT()`, `SUM()`, and `HAVING`
- Creating and inserting into temporary tables
- (Planned) Date extraction with `STRFTIME`

---

## Example Queries & Insights

### 1. Vendor Booth Rental Frequency
```sql
SELECT vendor_id,
       COUNT(*) AS booth_rentals
FROM vendor_booth_assignments
GROUP BY vendor_id;

Insight: The most active vendor rented a booth 15 times, showing consistent participation.


### 2. Flagging “Pepper” Products
```sql
SELECT product_id, product_name, 
CASE WHEN product_qty_type = 'unit' THEN 'unit'
     WHEN product_qty_type IS NULL THEN 'unknown'
     ELSE 'bulk'
END AS product_qty_type_condensed,
CASE WHEN product_name LIKE '%pepper%' THEN '1'
     ELSE '0'
END AS pepper_flag
FROM product;

Insight: 12% of products contained the word "pepper", useful for themed promotions.


###3. High-Spending Customers
```sql
SELECT cp.customer_id,
       c.customer_last_name,
       c.customer_first_name,
       ROUND(SUM(cp.quantity * cp.cost_to_customer_per_qty), 2) AS customer_spending
FROM customer_purchases AS cp
INNER JOIN customer AS c
        ON cp.customer_id = c.customer_id
GROUP BY cp.customer_id, c.customer_last_name, c.customer_last_name
HAVING customer_spending > 2000
ORDER BY customer_last_name ASC, customer_first_name ASC;

Insight: 8 customers spent over $2,000 at the market — strong candidates for a loyalty rewards program.



###Tools Used
SQLite
DB Browser for SQLite
GitHub for version control
