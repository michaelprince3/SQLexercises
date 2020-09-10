--selecting specific data using alias
SELECT 
    d.business_name,
    d.city,
    d.state,
    d.website
FROM dealerships d

SELECT
    c.first_name,
    c.last_name,
    c.email
From customers c

--filtering data
SELECT * FROM sales WHERE sales_type_id = 2

SELECT * FROM sales 
WHERE  DATE(purchase_date) >= DATE(NOW()) - INTERVAL '2 years';

SELECT * FROM sales 
WHERE 
    deposit < 5000 OR payment_method = 'americanexpress';

SELECT * FROM employees
WHERE
    first_name LIKE 'M%' OR first_name LIKE '%e';

SELECT * FROM employees
WHERE
    phone LIKE '600%';

--Joining tables
