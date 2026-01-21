# Write your MySQL query  statement below
SELECT 
    customer_id
FROM 
    customer_transactions
GROUP BY 
    customer_id
HAVING 
    -- Requirement 1: At least 3 purchase transactions
    SUM(CASE WHEN transaction_type = 'purchase' THEN 1 ELSE 0 END) >= 3
    
    -- Requirement 2: Active for at least 30 days
    AND DATEDIFF(MAX(transaction_date), MIN(transaction_date)) >= 30
    
    -- Requirement 3: Refund rate less than 20%
    AND (SUM(CASE WHEN transaction_type = 'refund' THEN 1 ELSE 0 END) / COUNT(*)) < 0.2
ORDER BY 
    customer_id ASC;