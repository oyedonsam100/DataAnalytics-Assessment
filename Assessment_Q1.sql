SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(CASE WHEN p.plan_type_id = 1 THEN 1 END) AS savings_count,
    COUNT(CASE WHEN p.plan_type_id = 2 THEN 1 END) AS investment_count,
    SUM(p.amount) AS total_deposits
FROM users_customuser u
JOIN plans_plan p ON u.id = p.owner_id
WHERE p.is_deleted = 0 AND p.is_archived = 0
GROUP BY u.id, u.name
HAVING 
    savings_count > 0 AND
    investment_count > 0
ORDER BY total_deposits DESC;
