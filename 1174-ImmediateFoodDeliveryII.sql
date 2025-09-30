WITH FirstOrders AS (
    SELECT 
        customer_id,
        delivery_id,
        order_date,
        customer_pref_delivery_date
    FROM Delivery d1
    WHERE order_date = (
        SELECT MIN(order_date)
        FROM Delivery d2
        WHERE d2.customer_id = d1.customer_id
    )
)
SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) 
        / COUNT(*), 2
    ) AS immediate_percentage
FROM FirstOrders;
