CREATE DATABASE Fintech;
use Fintech;

describe online_transactions;

select count(*) from online_transactions;


-- view top 100 dataset
select * from online_transactions
limit 100;

-- total revenue
SELECT round(sum(amount),2) AS total_revenue
FROM online_transactions
WHERE status='Success';

-- revenue by payment method
SELECT payment_method,
round(sum(amount),2) AS revenue
FROM online_transactions
WHERE status='Success'
GROUP BY payment_method
ORDER BY revenue DESC;

-- payment failure rate by bank
SELECT bank,
COUNT(*) AS total_transactions,
SUM(CASE WHEN status='Failed' THEN 1 ELSE 0 END) AS failed_transactions,
ROUND(
SUM(CASE WHEN status='Failed' THEN 1 ELSE 0 END)*100.0/COUNT(*),2
) AS failure_rate
FROM online_transactions
GROUP BY bank
ORDER BY failure_rate DESC;

-- Monthly transaction trend
SELECT MONTHNAME(date) AS month,
COUNT(*) AS total_transactions
FROM online_transactions
GROUP BY month
ORDER BY total_transactions desc;

-- Top Spending Customer
SELECT customer_id,
round(SUM(amount),2) AS total_spent
FROM online_transactions
WHERE status='Success'
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Average transaction value by payment method
SELECT payment_method,
ROUND(AVG(amount),1) AS avg_transaction
FROM online_transactions
WHERE status='Success'
GROUP BY payment_method
ORDER BY avg_transaction desc;

-- Spending By Category
SELECT category,
SUM(amount) AS total_spent
FROM online_transactions
GROUP BY category
ORDER BY total_spent DESC;

