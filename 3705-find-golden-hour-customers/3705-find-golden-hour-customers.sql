# Write your  MySQL query statement below
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders,
    ROUND((SUM(CASE 
        WHEN DATE_FORMAT(order_timestamp, '%H:%i') BETWEEN '11:00' AND '14:00' 
          OR DATE_FORMAT(order_timestamp, '%H:%i') BETWEEN '18:00' AND '21:00' 
        THEN 1 ELSE 0 END) / COUNT(order_id)) * 100, 0) AS peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING 
    -- 1. Made at least 3 orders
    COUNT(order_id) >= 3 
    -- 2. At least 60% of their orders are during peak hours
    AND (SUM(CASE 
        WHEN DATE_FORMAT(order_timestamp, '%H:%i') BETWEEN '11:00' AND '14:00' 
          OR DATE_FORMAT(order_timestamp, '%H:%i') BETWEEN '18:00' AND '21:00' 
        THEN 1 ELSE 0 END) / COUNT(order_id)) >= 0.6
    -- 3. Average rating for rated orders is at least 4.0
    AND AVG(order_rating) >= 4.0
    -- 4. Have rated at least 50% of their orders
    AND (COUNT(order_rating) / COUNT(order_id)) >= 0.5
ORDER BY average_rating DESC, customer_id DESC;