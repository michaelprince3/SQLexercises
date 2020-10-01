--create indexes to speed up execution time of db
--practice 1
SELECT * from Employees WHERE employee_type_id = 1

CREATE INDEX idx_emp_type ON Employees
(
    employee_type_id
);
--practice 2
SELECT * from Sales WHERE dealership_id = 500;

CREATE INDEX idx_dealer_id ON sales 
(
    dealership_id
);
--practice 3
SELECT * from customers WHERE state = 'CA';

CREATE INDEX idx_state ON customers 
(
    state 
);
--practice 4
SELECT * from vehicles where year_of_car BETWEEN 2018 AND 2020;

CREATE INDEX idx_year_of_car ON vehicles 
(
    year_of_car
);
--practice 5
SELECT * from vehicles where floor_price < 30000;

CREATE INDEX idx_floor_price ON vehicles 
(
    floor_price
);