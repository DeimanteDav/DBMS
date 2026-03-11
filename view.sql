CREATE VIEW v_rental_summary AS
SELECT
    r.rentalid,
    c.customerid,
    c.name AS customer_name,
    r.startdate,
    r.enddate,
    COALESCE(SUM(rd.quantity),0) AS total_items,
    COUNT(rd.toolid) AS distinct_tools
FROM rental r
JOIN customer c ON c.customerid = r.customerid
LEFT JOIN rentalDetail rd ON rd.rentalid = r.rentalid
GROUP BY r.rentalid, c.customerid, c.name, r.startdate, r.enddate;

CREATE VIEW v_tool_rental_counts AS
SELECT
    t.toolid,
    t.name,
    t.manufacturer,
    COALESCE(SUM(rd.quantity),0) AS times_rented
FROM tool t
LEFT JOIN rentalDetail rd ON rd.toolid = t.toolid
GROUP BY t.toolid, t.name, t.manufacturer;
