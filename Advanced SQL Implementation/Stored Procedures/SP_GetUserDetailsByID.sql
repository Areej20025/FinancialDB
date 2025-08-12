-- Create procedure
CREATE PROCEDURE GetUserDetailsByID
    @UserID INT -- User ID
AS
BEGIN
    SELECT 
        ID, 
        current_age, 
        yearly_income, 
        per_capita_income, 
        total_debt
    FROM Table_Users
    WHERE ID = @UserID; -- Filter by user ID
END;

-- Execute procedure
EXEC GetUserDetailsByID @UserID = 100;
