-- Create the stored procedure 
CREATE PROCEDURE GetUserTransactions
    @UserID INT -- Define the @UserID parameter 
AS
BEGIN
   
    SELECT 
        C.client_id AS UserID,
        T.id AS TransactionID,  
        T.date AS TransactionDate,  
        T.amount AS TransactionAmount,  
        T.merchant_city AS MerchantCity,  
        T.mcc AS MerchantCategoryCode  
    FROM Table_Transactions T  
    INNER JOIN Table_Cards C ON T.card_id = C.id  
    WHERE C.client_id = @UserID;  -- Filter transactions by the user ID
END;

-- Execute the stored procedure and pass the user ID value 
EXEC GetUserTransactions @UserID = 100;







