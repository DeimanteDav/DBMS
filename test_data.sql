INSERT INTO customer (name, phone, street, city, zip) VALUES
('Jonas Petraitis', '37061234567', 'Gatvės 1', 'Vilnius', '01101'),
('Aiste Kazlauskiene', NULL, 'Ramybės g. 5', 'Kaunas', '44123');

INSERT INTO tool (name, type, priceperday, manufacturer) VALUES
('Hammer', 'Hand Tool', 2.50, 'Stanley'),
('Electric Drill', 'Power Tool', 8.99, 'Bosch'),
('Chainsaw', 'Power Tool', 12.00, 'Makita');

INSERT INTO rental (customerid, startdate, enddate) VALUES
(1, '2025-11-01', '2025-11-05'),
(2, '2025-11-03', '2025-11-04');

INSERT INTO rentalDetail (rentalid, toolid, quantity, returndate) VALUES
(1, 1, 2, NULL),
(1, 2, 1, NULL),
(2, 3, 1, NULL);

REFRESH MATERIALIZED VIEW mv_tool_popularity;
