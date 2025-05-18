Assessment_Q1.sql
Identify customers who have at least one funded savings plan AND one funded investment plan, sorted by total deposits.
Tables used:
•	users_customuser
•	savings_savingsaccount
•	plans_plan
Approach:
1.	Join the tables: I joined plans_plan with users_customuser to get customer details, and with savings_savingsaccount to calculate deposits.
2.	Filter by product type:
o	A savings plan was identified using available fields (e.g. plan_type_id or flags like is_regular_savings).
o	An investment plan was determined using appropriate indicators (e.g. is_fixed_investment, is_managed_portfolio, etc.).
3.	Group by user: I grouped by customer (owner_id) to count the number of savings and investment plans.
4.	Apply HAVING clause: Only customers with at least one of each plan type were included.
5.	Aggregate deposits: Total deposit amounts were summed up for sorting.
Assumptions:
•	"Funded" means the savings account has deposits (non-zero balance or number of transactions).
•	The plan type indicators (is_regular_savings, is_fixed_investment, etc.) are mutually exclusive or clearly define plan types.
•	Total deposits are calculated only from savings_savingsaccount.
Challenges:
•	The schema doesn’t explicitly label plans as "savings" or "investment," so I had to infer using Boolean fields.
•	Without access to actual data, assumptions were made about how to classify plan types.
•	Ensured query performance using minimal joins and proper indexing assumptions.

Assessment_Q2.sql
Objective
The finance team wants to segment users based on how frequently they transact. The goal is to calculate the average number of transactions per customer per month and classify users into the following categories:
•	High Frequency: ≥ 10 transactions/month
•	Medium Frequency: 3–9 transactions/month
•	Low Frequency: ≤ 2 transactions/month
Only High and Medium Frequency categories are required in the final output.
Tables Used
•	users_customuser: Contains user demographic data (not used directly in this analysis)
•	savings_savingsaccount: Contains transaction-level data with timestamps
Approach
1.	Aggregate the savings_savingsaccount table by user to calculate:
o	Total transactions
o	Distinct active months (based on transaction_date)
o	Average transactions per month
2.	Use a CASE statement to assign each user a frequency category based on the defined thresholds.
3.	Filter for users in the High or Medium Frequency categories.
4.	Group the results by frequency_category and compute:
o	Number of customers in each category
o	Average of their monthly transaction averages
Key SQL Features Used
•	Common Table Expressions (CTEs)
•	DATE_FORMAT for month-level granularity
•	CASE for category classification
•	Aggregate functions: COUNT, AVG, ROUND
•	FIELD() for custom ORDER BY
Challenges
•	Ensuring month granularity required formatting the transaction_date properly.
•	Had to explicitly exclude Low Frequency users as per the task requirement.
•	Ensured rounding precision for avg_transactions_per_month using ROUND().

Assessment_Q3.sql
Objective
The operations team wants to identify accounts (savings or investments) that have had no inflow activity for over one year. These accounts need to be flagged for potential dormancy review.
Tables Used
•	plans_plan: Represents account metadata, including plan type and owner
•	savings_savingsaccount: Contains transaction data for savings accounts
Approach
•	Create a temporary result (CTE) to extract the most recent transaction date per user.
•	Join this result with the plans_plan table using owner_id to relate plans to transaction activity.
•	Use DATEDIFF() to compute the number of inactive days.
•	Filter for plans with inactivity over 365 days.
Assumptions
•	A plan is considered inactive if the owner has had no transactions in over one year.
•	Only users with at least one past transaction are considered (i.e., last_transaction_date IS NOT NULL).
•	If needed, a COALESCE (last_transaction_date, created_at) strategy can be used to capture plans that never had a transaction.
Challenges:
•	Handling Date Calculations: The biggest challenge was ensuring the proper calculation of inactivity days and filtering accounts with no transactions in the last year.

Assessment_Q4.sql
Objective
Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
Tables used:
•	users_customuser
•	savings_savingsaccount
Approach
•	Join the users_customuser table with the savings_savingsaccount table using user_id.
•	Calculate tenure_months as the difference in months between signup_date and the current date.
•	Calculate the total number of transactions for each customer using COUNT (transaction_id) and sum of transaction_value.
•	Estimate the CLV using the provided formula.
Challenges:
•	Foreign Key Constraints: The initial issue was inserting data into the savings_savingsaccount table where the user_id referenced a valid user from the users_customuser table.
•	Correct CLV Calculation: It was essential to ensure accurate transaction values and the profit margin to calculate the CLV.


