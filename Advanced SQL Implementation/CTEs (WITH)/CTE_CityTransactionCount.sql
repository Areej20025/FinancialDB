-- CTE to calculate the total number of transactions by merchant city
WITH CityTransactionSummary AS (
    SELECT 
        merchant_city,  -- City where the merchant is located
        COUNT(*) AS TotalTransactions  -- Total number of transactions in that city
    FROM Table_Transactions
    GROUP BY merchant_city
)
-- Retrieve the city transaction summary and order by total transactions in descending order
SELECT * 
FROM CityTransactionSummary
ORDER BY TotalTransactions DESC;  -- Sort results by total transactions in descending order

