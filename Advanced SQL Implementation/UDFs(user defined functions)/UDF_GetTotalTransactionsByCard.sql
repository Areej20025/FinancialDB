-- Create function to calculate total transactions using a specific card
CREATE FUNCTION dbo.GetTotalTransactionsByCard (@CardID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalTransactions INT;

    -- Calculate the total number of transactions using the card
    SELECT @TotalTransactions = COUNT(*)
    FROM Table_Transactions
    WHERE card_id = @CardID;

    RETURN @TotalTransactions; -- Return the total number of transactions
END;

-- Example usage: Get total transactions for each card
SELECT id, dbo.GetTotalTransactionsByCard(id) AS TotalTransactions
FROM Table_Cards
WHERE ID=0;--TotalTransactions=3402

-- Check the number of transactions to match the result from GetTotalTransactionsByCard
    SELECT COUNT(*) 
FROM Table_Transactions
WHERE card_id = 0;--=3402


