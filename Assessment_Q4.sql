SELECT 
    u.user_id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.signup_date, CURDATE()) AS tenure_months,
    COUNT(sa.transaction_value) AS total_transactions,
    (COUNT(sa.transaction_value) / TIMESTAMPDIFF(MONTH, u.signup_date, CURDATE())) * 12 * 0.001 * SUM(sa.transaction_value) AS estimated_clv
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount sa ON u.user_id = sa.user_id
GROUP BY 
    u.user_id, u.name
ORDER BY 
    estimated_clv DESC;
