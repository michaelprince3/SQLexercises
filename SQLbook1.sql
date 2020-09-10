--fix the auto sequence after importing csv with pks
SELECT setval(pg_get_serial_sequence('customers', 'customer_id'), coalesce(max(customer_id)+1, 1), false) FROM customers;
SELECT setval(pg_get_serial_sequence('sales', 'sale_id'), coalesce(max(sale_id)+1, 1), false) FROM sales;
SELECT setval(pg_get_serial_sequence('salestypes', 'sales_type_id'), coalesce(max(sales_type_id)+1, 1), false) FROM salestypes;	
SELECT setval(pg_get_serial_sequence('vehicles', 'vehicle_id'), coalesce(max(vehicle_id)+1, 1), false) FROM vehicles;
SELECT setval(pg_get_serial_sequence('vehicletypes', 'vehicle_type_id'), coalesce(max(vehicle_type_id)+1, 1), false) FROM vehicletypes;
SELECT setval(pg_get_serial_sequence('dealerships', 'dealership_id'), coalesce(max(dealership_id)+1, 1), false) FROM dealerships;
SELECT setval(pg_get_serial_sequence('employeetypes', 'employee_type_id'), coalesce(max(employee_type_id)+1, 1), false) FROM employeetypes;
SELECT setval(pg_get_serial_sequence('employees', 'employee_id'), coalesce(max(employee_id)+1, 1), false) FROM employees;
SELECT setval(pg_get_serial_sequence('dealershipemployees', 'dealership_employee_id'), coalesce(max(dealership_employee_id)+1, 1), false) FROM dealershipemployees;

--create a new table for vehicles
CREATE TABLE Vehicles (
  vehicle_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  vin VARCHAR(50),
  engine_type VARCHAR(2),
  vehicle_type_id INT REFERENCES VehicleTypes (vehicle_type_id),
  exterior_color VARCHAR(50),
  interior_color VARCHAR(50),
  floor_price INT,
  msr_price INT,
  miles_count INT,
  year_of_car INT
);

--generic alter table to add constraint
  ALTER TABLE child_table 
  ADD CONSTRAINT constraint_name 
  FOREIGN KEY (fk_columns) 
  REFERENCES parent_table (parent_key_columns);

--Insert multiple rows
INSERT INTO customers(first_name, last_name, email, phone, street, city, state, zipcode, company_name)
VALUES
('Katie', 'Wohl', 'kw@something.com', '123-456-7890', '123 some dr.', 'Nashville', 'TN', '12345', 'NSS'),
('Cooper', 'Nichols', 'cn@something.com', '098-765-4321', '321 some dr.', 'Nashville', 'TN', '12345', 'NSS');

--insert to multiple tables and use join table for final insert
--first insert
INSERT INTO vehiclebodytypes(name)
VALUES
('Starfighter');

--second insert
INSERT INTO vehiclemakes(name)
VALUES
('Incom Corporation');

--third insert
INSERT INTO vehiclemodels(name)
VALUES
('X-WING T-65B');

--join table must aquire fks from previous table
INSERT INTO vehicletypes(body_type_id, make_id, model_id)
VALUES
(8, 8, 19);

-- final insert needs fk from join
INSERT INTO vehicles(vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car)
VALUES
('thxxwy06a', '4L', 35, 'White and orange', 'Black', 65000, 150000, 1000000, 1977);



