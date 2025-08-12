-- CTE to calculate the number of different cities a user has made transactions in
WITH UserCityTransactions AS (
    SELECT 
        T.client_id,  -- User ID (client_id)
        COUNT(DISTINCT T.merchant_city) AS NumberOfCities  -- Count of distinct cities where transactions were made
    FROM Table_Transactions T
    GROUP BY T.client_id
)
-- Retrieve users who made transactions in more than one city
SELECT 
    U.ID AS ID_user, 
    U.current_age, 
    U.num_credit_cards, 
    UCT.NumberOfCities
FROM Table_Users U
JOIN UserCityTransactions UCT ON U.ID = UCT.client_id
WHERE UCT.NumberOfCities > 1;  -- Filter users who made transactions in more than one city
