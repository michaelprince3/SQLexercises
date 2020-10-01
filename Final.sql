CREATE OR REPLACE FUNCTION check_price()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS $$
DECLARE
    vehicle_price numeric;

BEGIN
-- retrieve the vehicle info
    SELECT floor_price FROM vehicles WHERE vehicle_id = NEW.vehicle_id INTO vehicle_price;

-- check sales price against floor price
    NEW.price >= (vehicle_price * .95)

EXCEPTION 
    WHEN others THEN RAISE EXCEPTION 'That price is not authorized'

END;
$$

CREATE TRIGGER price_check
BEFORE INSERT OR UPDATE
ON sales
FOR EACH ROW EXECUTE PROCEDURE check_price();