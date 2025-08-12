/* Data Analysis */


/* Query to returns everything in the customer table. */

SELECT *
FROM customer


/* Query that displays all of the columns and 10 rows from the cus- tomer table, 
sorted by customer_last_name, then customer_first_ name. */

SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10



/* Query that returns all customer purchases of product IDs 4 and 9. */
-- option 1
SELECT *
FROM customer_purchases
WHERE product_id IN (4,9);

-- option 2
SELECT *
FROM customer_purchases
WHERE product_id = 4 OR product_id = 9;


/* Query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), 
filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
-- option 1
SELECT *, 
	(quantity*cost_to_customer_per_qty) AS price
FROM customer_purchases
WHERE vendor_id >= 8 
	AND  vendor_id <= 10;

-- option 2
SELECT *, 
	(quantity*cost_to_customer_per_qty) AS price
FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10;




/* Products can be sold by the individual unit or by bulk measures like lbs. or oz. 
Using the product table, following is a query that outputs the product_id and product_name
columns and add a column called prod_qty_type_condensed that displays the word “unit” 
if the product_qty_type is “unit,” and otherwise displays the word “bulk.” */

SELECT product_id, product_name, 
CASE WHEN product_qty_type = 'unit' THEN 'unit'
	WHEN product_qty_type IS NULL THEN 'unknown'
	ELSE 'bulk'
END AS product_qty_type_condensed

FROM product;


/* To flag all of the different types of pepper products that are sold at the market. 
added a column to the previous query called pepper_flag that outputs a 1 if the product_name 
contains the word “pepper” (regardless of capitalization), and otherwise outputs 0. */

SELECT product_id, product_name, 
CASE WHEN product_qty_type = 'unit' THEN 'unit'
	WHEN product_qty_type IS NULL THEN 'unknown'
	ELSE 'bulk'
END AS product_qty_type_condensed,

CASE WHEN product_name LIKE '%pepper%' THEN '1'
	ELSE '0'
END AS pepper_flag
	
FROM product;



/* Query that INNER JOINs the vendor table to the vendor_booth_assignments table on the 
vendor_id field they both have in common, and sorts the result by vendor_name, then market_date. */
SELECT 
    v.vendor_id,
	v.vendor_name,
	v.vendor_type,
	v.vendor_owner_first_name,
	v.vendor_owner_last_name,
	vba.booth_number,
	vba.market_date
FROM 
    vendor AS v
INNER JOIN vendor_booth_assignments AS vba
    ON v.vendor_id = vba.vendor_id
ORDER BY 
    v.vendor_name,
    vba.market_date;



/* Query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */

SELECT vendor_id,
	 COUNT (*) AS booth_rentals
FROM vendor_booth_assignments
GROUP BY vendor_id;



/* The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */
SELECT 
	cp.customer_id,
	c.customer_last_name,
	c.customer_first_name,
	ROUND (SUM (cp.quantity * cp.cost_to_customer_per_qty),2) AS customer_spending
FROM customer_purchases AS cp
INNER JOIN customer AS c
	ON cp.customer_id = c.customer_id
GROUP BY cp.customer_id, c.customer_last_name, c.customer_last_name
HAVING customer_spending > 2000
ORDER BY customer_last_name ASC, customer_first_name ASC;


/* Inserted the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/
CREATE TABLE temp.new_vendor AS
SELECT *
FROM vendor;

INSERT INTO temp.new_vendor (
	vendor_id,
	vendor_name,
	vendor_type,
	vendor_owner_first_name,
	vendor_owner_last_name
	)
VALUES (
	10,
	'Thomass Superfood Store', 
	'Fresh Focused',
	'Thomas', 
	'Rosenthal'
	);

