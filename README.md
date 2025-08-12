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
