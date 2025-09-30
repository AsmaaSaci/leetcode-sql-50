WITH all_products AS (
    SELECT product_id FROM Prices
    UNION
    SELECT product_id FROM UnitsSold
)
SELECT 
    a.product_id,
    ROUND(
        COALESCE(SUM(u.units * p.price) / NULLIF(SUM(u.units),0), 0), 2
    ) AS average_price
FROM all_products a
LEFT JOIN UnitsSold u
    ON a.product_id = u.product_id
LEFT JOIN Prices p
    ON u.product_id = p.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY a.product_id
ORDER BY a.product_id;
