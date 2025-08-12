BEGIN TRANSACTION;

DECLARE @ClientID INT = 100;-- Customer ID
DECLARE @CardID  INT = 1045; -- Card ID
DECLARE @Amount DECIMAL(10,2) = 500; -- Purchase amount (Card credit limit = 26712, if > limit → ROLLBACK, if ≤ limit → COMMIT)
DECLARE @Available DECIMAL(18,2);

-- Get the current available balance from the card
SELECT @Available = credit_limit
FROM Table_Cards
WHERE id = @CardID AND client_id = @ClientID;

IF @Amount <= @Available
BEGIN
    -- Record the transaction
    INSERT INTO Table_Transactions
        (id, date, client_id, card_id, amount, use_chip, merchant_id, merchant_city, merchant_state, zip, mcc, errors)
    VALUES
        ((SELECT ISNULL(MAX(id),0)+1 FROM Table_Transactions),
         GETDATE(), @ClientID, @CardID, @Amount, 'Online Transaction', '39021', 'ONLINE', 'ONLINE', NULL, 5812, NULL);

    -- Deduct the amount from the balance (credit_limit treated as remaining balance)
    UPDATE Table_Cards
    SET credit_limit = credit_limit - @Amount
    WHERE id = @CardID;

    COMMIT TRANSACTION;
    PRINT 'DONE - COMMIT';
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'CANCEL - ROLLBACK (Insufficient balance)';
END

--=======================
SELECT *
FROM Table_Users;

SELECT *
FROM Table_Cards
where client_id=100;--26713

SELECT MAX(ID)
FROM Table_Transactions;--23761877

SELECT *
FROM Table_Transactions;

