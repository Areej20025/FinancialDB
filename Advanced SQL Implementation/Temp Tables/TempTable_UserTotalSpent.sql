-- Create a temporary table to store total amount spent by each user
CREATE TABLE #UserTotalSpent (
    UserID INT,
    TotalSpent DECIMAL
);

-- Insert the total spent amount for each user into the temporary table
INSERT INTO #UserTotalSpent (UserID, TotalSpent)
SELECT 
    T.client_id,
    SUM(T.amount) AS TotalSpent
FROM Table_Transactions T
GROUP BY T.client_id;

-- Retrieve the data from the temporary table and join with Table_Users to get the user details
SELECT U.ID, U.current_age, UTS.TotalSpent
FROM Table_Users U
JOIN #UserTotalSpent UTS ON U.ID = UTS.UserID;

-- Drop the temporary table after use
DROP TABLE #UserTotalSpent;
