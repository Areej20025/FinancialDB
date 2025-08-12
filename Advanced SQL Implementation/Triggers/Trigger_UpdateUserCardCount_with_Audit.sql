-- Create audit table to log card count changes
CREATE TABLE CardCountAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    OldCardCount INT,
    NewCardCount INT,
    ChangeDate DATETIME DEFAULT GETDATE()
);

-- Create trigger to update card count and log the change
CREATE TRIGGER UpdateUserCardCount
ON Table_Cards
AFTER INSERT
AS
BEGIN
    DECLARE @UserID INT, @OldCardCount INT, @NewCardCount INT;

    -- Get client_id from the inserted card
    SELECT @UserID = client_id FROM inserted;
    
    -- Get old card count
    SELECT @OldCardCount = num_credit_cards FROM Table_Users WHERE ID = @UserID;
    
    -- Calculate new card count
    SELECT @NewCardCount = COUNT(*) FROM Table_Cards WHERE client_id = @UserID;
    
    -- Update the user's card count
    UPDATE Table_Users SET num_credit_cards = @NewCardCount WHERE ID = @UserID;

    -- Log the change in the audit table
    INSERT INTO CardCountAuditLog (UserID, OldCardCount, NewCardCount)
    VALUES (@UserID, @OldCardCount, @NewCardCount);
END;

-- Example usage: Check num_credit_cards before adding the new card
SELECT * 
FROM Table_Users
WHERE id = 100; -- num_credit_cards = 7

-- Insert a new card 
INSERT INTO Table_Cards (id,client_id, card_number, card_type, expires,cvv, has_chip, num_cards_issued, credit_limit, acct_open_date, year_pin_last_changed, card_on_dark_web)
VALUES
(7000,100, '7132467939856654', 'Debit', '2026-04-01', 588, 1, 1, 70714, '2005-02-01', 2011, 'No');

-- Check the audit log to see the changes recorded
select * from CardCountAuditLog;

-- Check num_credit_cards after adding the new card
SELECT * 
FROM Table_Users
WHERE id=100;--num_credit_cards = 8


