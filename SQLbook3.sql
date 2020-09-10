--Chapter 1 updates
--example update
UPDATE table_name
SET column1 = value1, column2 = value2...., columnN = valueN
WHERE [condition];

--Practice: Employees
UPDATE dealershipemployees
SET dealership_id = 20
WHERE employee_id = 680;

--Practice: Sales
UPDATE sales
Set payment_method = 'Mastercard'
WHERE invoice_number = '2781047589';

--Chapter 2 delete
--example delete
DELETE FROM table_name
WHERE [condition];

--Practice: Employees 1.
DELETE FROM sales
WHERE invoice_number = '7628231837';

--Practice: Employees 2. 
ALTER TABLE sales 
DROP CONSTRAINT sales_employee_id_fkey,
ADD CONSTRAINT fk_employee_id
FOREIGN KEY (employee_id) 
REFERENCES employees (employee_id)
ON DELETE SET NULL;

DELETE FROM employees
WHERE employee_id = 35;

--Chapter 3 