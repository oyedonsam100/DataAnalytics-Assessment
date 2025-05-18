SELECT
  pp.id AS plan_id,
  pp.owner_id,
  pp.type,
  MAX(sa.transaction_date) AS last_transaction_date,
  DATEDIFF(CURDATE(), MAX(sa.transaction_date)) AS inactivity_days
FROM
  plans_plan pp
LEFT JOIN
  savings_savingsaccount sa ON sa.user_id = pp.owner_id
GROUP BY
  pp.id, pp.owner_id, pp.type
HAVING
  (MAX(sa.transaction_date) IS NULL) OR
  (MAX(sa.transaction_date) <= CURDATE() - INTERVAL 365 DAY);
