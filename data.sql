-- =========================================================
-- tool_rental_schema.sql
-- Single-file DB creation script for your ER diagram (PostgreSQL)
-- Instructions:
-- 1) Create a new DB in Postbird (e.g., tool_rental)
-- 2) Open Query Editor for that DB, paste this whole file and Run.
-- =========================================================

-- CLEANUP: safe DROP so you can re-run script




-- =========================================================
-- TRIGGERS (2 domain/business rules implemented by triggers)
-- Rule 1 (simple): Before INSERT ON rentalDetail:
--    If returndate IS NULL, set it to the rental.enddate (uses data from rental table).
-- Rule 2 (business): Before INSERT ON rental:
--    Prevent a customer from creating a rental that overlaps with an existing rental
--    of the same customer. (This cannot be done with a CHECK; needs a trigger.)
-- =========================================================

-- Function for Rule 1: auto-fill returndate from rental.enddate when NULL


-- Function for Rule 2: prevent overlapping rentals for the same customer


-- =========================================================
-- TEST DATA (sample inserts)
-- =========================================================
INSERT INTO customer (name, phone, street, city, zip) VALUES
('Jonas Petraitis', '37061234567', 'Gatvės 1', 'Vilnius', '01101'),
('Aiste Kazlauskiene', NULL, 'Ramybės g. 5', 'Kaunas', '44123');

INSERT INTO tool (name, type, priceperday, manufacturer) VALUES
('Hammer', 'Hand Tool', 2.50, 'Stanley'),
('Electric Drill', 'Power Tool', 8.99, 'Bosch'),
('Chainsaw', 'Power Tool', 12.00, 'Makita');

-- Rentals: the second rental below will be blocked if it overlaps with first for same customer
INSERT INTO rental (customerid, startdate, enddate) VALUES
(1, '2025-11-01', '2025-11-05'),
(2, '2025-11-03', '2025-11-04');

-- Rental details: returndate NULL will be auto-filled by trigger to match rental.enddate
INSERT INTO rentalDetail (rentalid, toolid, quantity, returndate) VALUES
(1, 1, 2, NULL),
(1, 2, 1, NULL),
(2, 3, 1, NULL);

-- Populate the materialized view now that data exists
REFRESH MATERIALIZED VIEW mv_tool_popularity;

-- =========================================================
-- QUICK CHECK QUERIES (optional) -- run to verify data and triggers
-- SELECT * FROM customer;
-- SELECT * FROM tool;
SELECT * FROM rental;
-- SELECT * FROM rentalDetail;
-- SELECT * FROM v_rental_summary;
-- SELECT * FROM v_tool_rental_counts;
-- SELECT * FROM mv_tool_popularity;
-- =========================================================
