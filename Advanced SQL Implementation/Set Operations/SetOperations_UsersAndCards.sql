/**** UNION ****/

--UNION: users with Credit OR Debit (deduped) 
SELECT U.ID, U.current_age, U.yearly_income
FROM Table_Users U
JOIN Table_Cards C ON U.ID = C.client_id
WHERE C.card_type = 'Credit'

UNION

SELECT U.ID, U.current_age, U.yearly_income
FROM Table_Users U
JOIN Table_Cards C ON U.ID = C.client_id
WHERE C.card_type = 'Debit';--1898 rows

/**** UNION ALL ****/

--UNION ALL: Credit plus Debit (keeps duplicates) 
SELECT C.id AS card_id, U.ID AS userid, U.gender, U.current_age, U.yearly_income
FROM Table_Users U
JOIN Table_Cards C ON C.client_id = U.ID
WHERE C.card_type = 'Credit'

UNION ALL

SELECT C.id AS card_id, U.ID AS userid, U.gender, U.current_age, U.yearly_income
FROM Table_Users U
JOIN Table_Cards C ON C.client_id = U.ID
WHERE C.card_type = 'Debit';--5012


/**** INTERSECT ****/

-- INTERSECT: users who have BOTH Credit AND Debit
SELECT U.ID, U.gender, U.current_age, U.yearly_income
FROM Table_Users U
JOIN Table_Cards C ON C.client_id = U.ID
WHERE C.card_type = 'Credit'

INTERSECT

SELECT U.ID, U.gender, U.current_age, U.yearly_income
FROM Table_Users U
JOIN Table_Cards C ON C.client_id = U.ID
WHERE C.card_type = 'Debit';--961rows

/**** EXCEPT ****/

-- EXCEPT: users with Credit but NOT Debit 
SELECT U.ID, U.gender, U.current_age, U.yearly_income
FROM Table_Users U
JOIN Table_Cards C ON C.client_id = U.ID
WHERE C.card_type = 'Credit'

EXCEPT

SELECT U.ID, U.gender, U.current_age, U.yearly_income
FROM Table_Users U
JOIN Table_Cards C ON C.client_id = U.ID
WHERE C.card_type = 'Debit';--267 rows
