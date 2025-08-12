-- Create view: transactions in 2010
CREATE VIEW View_Transactions_2010 AS
SELECT 
    T.id, 
    T.date, 
    T.amount, 
    T.merchant_city, 
    T.mcc, 
    U.ID AS UserID
FROM Table_Transactions T
JOIN Table_Cards C ON T.card_id = C.id
JOIN Table_Users U ON C.client_id = U.ID
WHERE T.date BETWEEN '2010-01-01' AND '2010-12-31';


-- Example usage
SELECT * 
FROM View_Transactions_2010
WHERE UserID = 100;


