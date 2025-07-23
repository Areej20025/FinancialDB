
------users
SELECT * 
FROM Table_Users;

SELECT DISTINCT ID
FROM Table_Users;--INT
SELECT DISTINCT [current_age]
FROM Table_Users;--INT
SELECT DISTINCT [retirement_age]
FROM Table_Users;--INT
SELECT DISTINCT [birth_year]
FROM Table_Users;--INT
SELECT DISTINCT [birth_month]
FROM Table_Users;--INT
SELECT DISTINCT [gender]
FROM Table_Users;--TWO TYPE (MALE,FAMALE) so char(6)
SELECT DISTINCT [address]
FROM Table_Users;--VARCHAR
SELECT DISTINCT [latitude]
FROM Table_Users;--DESMAL
SELECT DISTINCT [longitude]
FROM Table_Users;--DESEMAL WITH NEGATEF -
SELECT DISTINCT [per_capita_income]
FROM Table_Users;--INT WITH $
SELECT DISTINCT [yearly_income]
FROM Table_Users;--INT WITH $
SELECT DISTINCT [total_debt]
FROM Table_Users;--INT WITH $ 
SELECT DISTINCT [credit_score]
FROM Table_Users;--INT 
SELECT DISTINCT [num_credit_cards]
FROM Table_Users;--INT



------CARDS 
SELECT * FROM Table_Cards;

SELECT DISTINCT id FROM Table_Cards;--INT
SELECT DISTINCT client_id FROM Table_Cards;--INT
SELECT DISTINCT card_brand FROM Table_Cards;--VARHAR JUST 3 BRANDS  Mastercard(Discover,Visa,Amex)
SELECT DISTINCT card_type FROM Table_Cards;--VARHAR JUST 3 CARD_TYPE(Debit (Prepaid),Credit,Debit)
SELECT DISTINCT card_number FROM Table_Cards;--VARHAR
SELECT DISTINCT expires FROM Table_Cards;--DATE LIKE (01/2009)
SELECT DISTINCT cvv FROM Table_Cards;--VARCHAR(4)
SELECT DISTINCT has_chip FROM Table_Cards;--CHAR(3) JUST(NO,YES)
SELECT DISTINCT num_cards_issued FROM Table_Cards;--INT JUST(2,1,3)
SELECT DISTINCT credit_limit FROM Table_Cards;--INT 
SELECT DISTINCT acct_open_date FROM Table_Cards;--DATE LIKE (01/2009)
SELECT DISTINCT year_pin_last_changed FROM Table_Cards;--INT 
SELECT DISTINCT card_on_dark_web FROM Table_Cards;--VARCHAR





---transactions
SELECT * FROM Table_Transactions;

SELECT DISTINCT id FROM Table_Transactions;--INT
SELECT DISTINCT date FROM Table_Transactions;--DATETIME LIKE(2011-07-17 21:43:00)
SELECT DISTINCT client_id FROM Table_Transactions;--INT
SELECT DISTINCT card_id FROM Table_Transactions;--INT
SELECT DISTINCT amount FROM Table_Transactions;--DESMAL
SELECT DISTINCT use_chip FROM Table_Transactions;--VARCHAR JUST 2(Online Transaction , Swipe Transaction)
SELECT DISTINCT merchant_id FROM Table_Transactions;--INT
SELECT DISTINCT merchant_city FROM Table_Transactions;--VARCHAR
SELECT DISTINCT merchant_state FROM Table_Transactions;--VARCHAR
SELECT DISTINCT zip FROM Table_Transactions;--VARCHAR
SELECT DISTINCT mcc FROM Table_Transactions;--INT
SELECT DISTINCT errors FROM Table_Transactions;--NVARCHAR
-------------------
