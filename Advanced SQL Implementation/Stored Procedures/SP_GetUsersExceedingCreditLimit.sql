-- Create procedure
CREATE PROCEDURE GetUsersExceedingCreditLimit
AS
BEGIN
    SELECT 
        U.ID, 
        U.current_age, 
        C.card_number, 
        C.credit_limit, 
        SUM(T.amount) AS TotalSpent -- Total spent by user
    FROM Table_Users U
    JOIN Table_Cards C ON U.ID = C.client_id
    JOIN Table_Transactions T ON C.id = T.card_id
    GROUP BY U.ID, U.current_age, C.card_number, C.credit_limit 
    HAVING SUM(T.amount) > C.credit_limit; -- Over credit limit
END;

-- Execute procedure
EXEC GetUsersExceedingCreditLimit;
