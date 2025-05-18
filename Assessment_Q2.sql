SELECT
frequency_category,
COUNT(*) AS customer_count,
ROUND(AVG(transactions_per_month), 2) AS avg_transactions_per_month
FROM (
SELECT
user_id,
COUNT(transaction_id) / COUNT(DISTINCT MONTH(transaction_date)) AS transactions_per_month,
CASE
WHEN COUNT(transaction_id) / COUNT(DISTINCT MONTH(transaction_date)) >= 10 THEN 'High Frequency'
WHEN COUNT(transaction_id) / COUNT(DISTINCT MONTH(transaction_date)) BETWEEN 3 AND 9 THEN 'Medium Frequency'
ELSE 'Low Frequency'
END AS frequency_category
FROM savings_savingsaccount
GROUP BY user_id
) sub
WHERE frequency_category IN ('High Frequency', 'Medium Frequency')
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency');
