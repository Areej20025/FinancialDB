-- Create view for users exceeding their credit limit
CREATE VIEW View_UsersExceedingCreditLimit AS
SELECT 
    U.ID AS userid,
    U.current_age, 
    C.id AS cardid,
    C.card_number, 
    C.credit_limit, 
    SUM(T.amount) AS TotalSpent
FROM Table_Users U
JOIN Table_Cards C ON U.ID = C.client_id
JOIN Table_Transactions T ON C.id = T.card_id
GROUP BY U.ID, U.current_age,C.id, C.card_number, C.credit_limit
HAVING SUM(T.amount) > C.credit_limit;

-- Use the view to see results
SELECT * 
FROM View_UsersExceedingCreditLimit
ORDER BY userid;
