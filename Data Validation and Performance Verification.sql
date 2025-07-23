-- Check the number of records in the Table_Users
SELECT COUNT(*) FROM Table_Users;

-- Check the number of records in the Table_Transactions
SELECT COUNT(*) FROM Table_Transactions;

-- Check the number of records in the Table_Cards
SELECT COUNT(*) FROM Table_Cards;

-- Check for any NULL values in the important columns like amount in Table_Transactions
SELECT * FROM Table_Transactions WHERE amount IS NULL;

-- Check for any invalid values in age or income in Table_Users
SELECT * FROM Table_Users WHERE current_age < 0 OR yearly_income < 0;

-- Check the integrity between Table_Users and Table_Transactions
SELECT * FROM Table_Transactions t
WHERE NOT EXISTS (SELECT 1 FROM Table_Users u WHERE u.ID = t.client_id);

