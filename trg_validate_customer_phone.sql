CREATE OR REPLACE FUNCTION fn_validate_customer_phone()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.phone IS NOT NULL THEN
        IF LENGTH(NEW.phone) > 15 THEN
            RAISE EXCEPTION 'Phone number % is too long (max 15 characters)', NEW.phone;
        END IF;

        IF SUBSTRING(NEW.phone FROM 1 FOR 1) !~ '^[0-9\+]$' THEN
            RAISE EXCEPTION 'Phone number % must start with + or a digit', NEW.phone;
        END IF;

        IF LENGTH(NEW.phone) > 1 AND SUBSTRING(NEW.phone FROM 2) !~ '^[0-9]*$' THEN
            RAISE EXCEPTION 'Phone number % can only contain digits after the first character', NEW.phone;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_validate_customer_phone
BEFORE INSERT OR UPDATE ON customer
FOR EACH ROW
EXECUTE FUNCTION fn_validate_customer_phone();
