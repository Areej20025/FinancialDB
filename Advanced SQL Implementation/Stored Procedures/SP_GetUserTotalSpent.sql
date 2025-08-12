-- Create procedure
CREATE PROCEDURE GetUserTotalSpent
    @UserID INT -- User ID
AS
BEGIN
    SELECT 
        SUM(T.amount) AS TotalSpent -- Total spent by user
    FROM Table_Transactions T
    JOIN Table_Cards C ON T.card_id = C.id
    WHERE C.client_id = @UserID; -- Filter by user ID
END;

-- Execute procedure
EXEC GetUserTotalSpent @UserID = 100;
