-- Get a list of the 3 long-standing customers for each country


-- Modify the previous query to get the 3 newest customers in each each country.


-- Get the 3 most frequently ordered products in each city
-- FOR SIMPLICITY, we're interpreting "most frequent" as 
-- "highest number of total units ordered within a country"
-- hint: do something with the quanity column


1)

WITH order_info AS (
SELECT *,
	c.customer_id as c_customer_id,
	o.customer_id as o_customer_id,
	o.order_date as o_order_date

FROM orders as o 
	JOIN customers as c ON o.customer_id = c.customer_id
	), 
customer_history as ( 
SELECT 
	c_customer_id,
	country,
	o_order_date
FROM 
order_info
GROUP BY 
c_customer_id, country, o_order_date)
, 
top_customers as (
SELECT *,
	RANK() OVER(PARTITION BY country ORDER BY o_order_date DESC)
FROM customer_history
)
SELECT *
FROM top_customers
WHERE rank <= 3; 


2)

WITH order_info AS (
SELECT *,
	c.customer_id as c_customer_id,
	o.customer_id as o_customer_id,
	o.order_date as o_order_date

FROM orders as o 
	JOIN customers as c ON o.customer_id = c.customer_id
	), 
customer_history as ( 
SELECT 
	c_customer_id,
	country,
	o_order_date
FROM 
order_info
GROUP BY 
c_customer_id, country, o_order_date)
, 
top_customers as (
SELECT *,
	RANK() OVER(PARTITION BY country ORDER BY o_order_date)
FROM customer_history
)
SELECT *
FROM top_customers
WHERE rank <= 3; 

