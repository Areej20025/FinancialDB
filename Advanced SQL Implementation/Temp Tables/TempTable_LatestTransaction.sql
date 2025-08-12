-- Create a temporary table to store the latest transaction date for each user
CREATE TABLE #LatestTransactions (
    UserID INT,
    LastTransactionDate DATE
);

-- Insert the latest transaction date for each user into the temporary table
INSERT INTO #LatestTransactions (UserID, LastTransactionDate)
SELECT 
    T.client_id,
    MAX(T.date) AS LastTransactionDate  -- Get the latest transaction date
FROM Table_Transactions T
GROUP BY T.client_id;

-- Retrieve users along with their latest transaction date
SELECT 
    U.ID, 
    U.current_age, 
    LT.LastTransactionDate
FROM Table_Users U
JOIN #LatestTransactions LT ON U.ID = LT.UserID;

-- Drop the temporary table after use
DROP TABLE #LatestTransactions;
