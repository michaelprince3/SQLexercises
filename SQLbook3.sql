--Chapter 1 updates
--example update
UPDATE
    table_name
SET
    column1 = value1,
    column2 = value2....,
    columnN = valueN
WHERE
    [condition];

--Practice: Employees
UPDATE
    dealershipemployees
SET
    dealership_id = 20
WHERE
    employee_id = 680;

--Practice: Sales
UPDATE
    sales
Set
    payment_method = 'Mastercard'
WHERE
    invoice_number = '2781047589';

--Chapter 2 delete
--example delete
DELETE FROM
    table_name
WHERE
    [condition];

--Practice: Employees 1.
DELETE FROM
    sales
WHERE
    invoice_number = '7628231837';

--Practice: Employees 2. 
ALTER TABLE
    sales DROP CONSTRAINT sales_employee_id_fkey,
ADD
    CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE
SET
    NULL;

DELETE FROM
    employees
WHERE
    employee_id = 35;

--Chapter 3 
--Group Project
CREATE TABLE AccountsReceivable (
    accounts_receivable_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    credit_amount INT,
    debit_amount INT,
    sales_id INT REFERENCES Sales (sale_id)
);

CREATE
OR REPLACE FUNCTION new_ar_record () RETURNS TRIGGER LANGUAGE PLPGSQL AS $ $ BEGIN
INSERT INTO
    accountsreceivable (
        credit_amount,
        debit_amount,
        date_received,
        sales_id
    )
VALUES
    (
        NEW.deposit,
        ABS(new.price - new.deposit),
        NOW(),
        new.sale_id
    );

RETURN NULL;

END;

$ $ CREATE TRIGGER new_sale_made
    AFTER INSERT
    ON sales 
    FOR EACH ROW 
    EXECUTE PROCEDURE new_ar_record ();

INSERT INTO
    sales (
        sales_type_id,
        vehicle_id,
        employee_id,
        dealership_id,
        price,
        invoice_number,
        purchase_date,
        pickup_date,
        deposit
    )
VALUES
    (
        1,
        11,
        111,
        111,
        10111,
        101010101,
        CURRENT_DATE,
        CURRENT_DATE,
        500
    );

--2
CREATE
OR REPLACE FUNCTION sale_returned_record() 
RETURNS TRIGGER 
LANGUAGE PLPGSQL 
AS $$ 
		BEGIN
		INSERT INTO
			accountsreceivable (
				debit_amount,
				date_received,
				sales_id
			)
		VALUES
			(
				NEW.deposit,
				NOW(),
				new.sale_id
			);
		RETURN NULL;
	END;
$$ 
CREATE TRIGGER new_sale_returned
AFTER UPDATE
    ON sales FOR EACH ROW EXECUTE PROCEDURE sale_returned_record ();
SELECT * FROM SALES;
where returned is true;
UPDATE sales
SET returned = true
WHERE sale_id = 11;

--3
CREATE OR REPLACE PROCEDURE add_new_employee_to_dealerships
	(first_name VARCHAR, 
	 last_name VARCHAR, 
	 email_address VARCHAR, 
	 phone VARCHAR, 
	 employee_type_id INT, 
	 dealership_id_1 INT, 
	 dealership_id_2 INT) 
LANGUAGE plpgsql 
AS $$ 
DECLARE 
  NewEmployeeID INT;
BEGIN
	INSERT INTO employees(
	first_name, last_name, email_address, phone, employee_type_id)
	VALUES (first_name, 
	 last_name, 
	 email_address, 
	 phone, 
	 employee_type_id) RETURNING employee_id INTO NewEmployeeId;
	INSERT INTO dealershipemployees(
	employee_id, dealership_id)
	VALUES (newEmployeeID, dealership_id_1);
	INSERT INTO dealershipemployees(
	employee_id, dealership_id)
	VALUES (newEmployeeID, dealership_id_2); 
	COMMIT;
END $$;
SELECT * FROM dealershipemployees
WHERE employee_id = 1001; 
CALL add_new_employee_to_dealerships('Herman', 'Munster', 'hm@adamsfamily.com', '213-853-1000', 1, 7, 3);

--4
ALTER TABLE employees
	ADD COLUMN isActive bool NOT NULL
	DEFAULT TRUE;
CREATE OR REPLACE PROCEDURE employees_leaving_dealerships
	( 
	 employee_id INT
	 ) 
LANGUAGE plpgsql 
AS $$ 
BEGIN
	UPDATE employees e
	SET isActive = false
	WHERE e.employee_id = e.employee_id;
	DELETE FROM dealershipemployees de
	WHERE de.employee_id = de.employee_id;
	COMMIT;
 	EXCEPTION WHEN others THEN 
	RAISE NOTICE 'You messed up(%)', employee_id;
  	ROLLBACK;
END $$;
