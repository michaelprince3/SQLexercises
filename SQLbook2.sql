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

--Group Project: Carnival Reports

-- Who are the top 5 employees for generating sales income?
Select sum(s.price) as total_sales_income, e.first_name, e.last_name
FROM Sales s
Join Employees e ON s.employee_id = e.employee_id
Group By e.first_name, e.last_name
Order BY sum(s.price) DESC
LIMIT 5;

-- Who are the top 5 dealership for generating sales income?

Select sum(s.price) , d.business_name
FROM Sales s
Join Dealerships d ON s.dealership_id = d.dealership_id
Group By d.business_name
Order BY sum(s.price) DESC
LIMIT 5;



-- Which vehicle model generated the most sales income?


SELECT sum(s.price), vm.name
FROM Sales s
JOIN Vehicles v ON s.vehicle_id = v.vehicle_id
JOIN Vehicletypes vt on v.vehicle_type_id = vt.vehicle_type_id
JOIN Vehiclemodels vm on vt.model_id = vm.vehicle_model_id
Group By vm.name
Order By sum(s.price) DESC
LIMIT 1;



-- Top Performance

-- Which employees generate the most income per dealership?

Select sum(s.price) as total_sales_income, d.business_name, e.first_name, e.last_name
FROM Dealerships d
JOIN Sales s ON s.dealership_id = d.dealership_id
JOIN Employees e ON e.employee_id = s.employee_id
GROUP BY d.business_name, e.first_name, e.last_name
ORDER BY sum(s.price) DESC


-- Vehicle Reports
-- Inventory
-- In our Vehicle inventory, show the count of each Model that is in stock.
SELECT
COUNT(v.vehicle_type_id) AS current_inventory,
vm.name,
ma.name
FROM
vehicles v
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclemodels vm ON vt.model_id = vm.vehicle_model_id
JOIN vehiclemakes ma ON vt.make_id = ma.vehicle_make_id
GROUP BY vm.vehicle_model_id, ma.name
ORDER BY COUNT(v.vehicle_type_id) DESC;


-- In our Vehicle inventory, show the count of each Make that is in stock.
SELECT
COUNT(ma.vehicle_make_id) AS current_inventory,
ma.name
FROM
vehicles v
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclemakes ma ON vt.make_id = ma.vehicle_make_id
GROUP BY ma.vehicle_make_id, ma.name
ORDER BY COUNT(ma.vehicle_make_id) DESC


-- In our Vehicle inventory, show the count of each BodyType that is in stock.
SELECT
COUNT(bt.vehicle_body_type_id) AS current_inventory,
bt.name
FROM
vehicles v
JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehiclebodytypes bt ON vt.body_type_id = bt.vehicle_body_type_id
GROUP BY bt.vehicle_body_type_id, bt.name
ORDER BY COUNT(bt.vehicle_body_type_id) DESC;


-- Purchasing Power
-- Which US state's customers have the highest average purchase price for a vehicle?
SELECT ROUND(avg(s.price), 2) as average_purchase_price, c.state
FROM Sales s
JOIN Customers c ON c.customer_id = s.customer_id
GROUP BY c.state
ORDER BY avg(s.price) DESC
LIMIT 1;


-- Of the 5 US states with the most customers that you determined above, which of those have the customers with the highest average purchase price for a vehicle?
SELECT ROUND(avg(s.price), 2) as average_purchase_price, c.state
FROM Sales s
JOIN Customers c ON c.customer_id = s.customer_id
GROUP BY c.state
ORDER BY avg(s.price) DESC
LIMIT 5;