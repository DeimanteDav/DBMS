DROP MATERIALIZED VIEW IF EXISTS mv_tool_popularity;
DROP VIEW IF EXISTS v_rental_summary;
DROP VIEW IF EXISTS v_tool_rental_counts;
DROP TRIGGER IF EXISTS trg_validate_customer_phone ON customer;
DROP FUNCTION IF EXISTS fn_validate_customer_phone();
DROP TRIGGER IF EXISTS trg_set_default_enddate ON rental;
DROP FUNCTION IF EXISTS fn_set_default_enddate();
DROP TABLE IF EXISTS rentalDetail;
DROP TABLE IF EXISTS rental;
DROP TABLE IF EXISTS tool;
DROP TABLE IF EXISTS customer;

