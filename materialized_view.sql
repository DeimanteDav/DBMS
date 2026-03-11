CREATE MATERIALIZED VIEW mv_tool_popularity AS
SELECT
    t.toolid,
    t.name,
    t.manufacturer,
    COUNT(DISTINCT rd.rentalid) AS times_rented,
    COUNT(DISTINCT r.customerid) AS distinct_customers,
    COALESCE(SUM(rd.quantity),0) AS total_quantity,
    COALESCE(SUM(rd.quantity * t.priceperday),0) AS total_revenue
FROM tool t
LEFT JOIN rentalDetail rd ON rd.toolid = t.toolid
LEFT JOIN rental r ON r.rentalid = rd.rentalid
GROUP BY t.toolid, t.name, t.manufacturer
WITH NO DATA;
