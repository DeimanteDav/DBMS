-- CREATE OR REPLACE FUNCTION fn_refresh_mv_rental_summary()
-- RETURNS trigger
-- AS $$
-- BEGIN
--     REFRESH MATERIALIZED VIEW mv_rental_summary;
--     RETURN NULL;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE TRIGGER trg_refresh_mv_rental_summary
-- AFTER INSERT OR UPDATE OR DELETE
-- ON rental
-- FOR EACH STATEMENT
-- EXECUTE FUNCTION fn_refresh_mv_rental_summary();


CREATE OR REPLACE FUNCTION fn_set_default_enddate()
RETURNS trigger AS $$
BEGIN
    IF NEW.enddate IS NULL THEN
        NEW.enddate := NEW.startdate + INTERVAL '7 days';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_default_enddate
BEFORE INSERT
ON rental
FOR EACH ROW
EXECUTE FUNCTION fn_set_default_enddate();
