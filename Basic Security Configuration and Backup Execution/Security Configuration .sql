--Creates a Database user named 'Areej'

CREATE USER Areej FOR LOGIN Areej;

----grants her SELECT, INSERT, UPDATE, and DELETE permissions
-- on the tables: Table_Users, Table_Transactions, and Table_Cards.
/*SELECT*/
GRANT SELECT ON Table_Users TO Areej;
GRANT SELECT ON Table_Transactions TO Areej;
GRANT SELECT ON Table_Cards TO Areej;


/*INSERT, UPDATE*/
GRANT INSERT, UPDATE ON Table_Users TO Areej;
GRANT INSERT, UPDATE ON Table_Transactions TO Areej;
GRANT INSERT, UPDATE ON Table_Cards TO Areej;

/*DELETE*/
GRANT DELETE ON Table_Users TO Areej;
GRANT DELETE ON Table_Transactions TO Areej;
GRANT DELETE ON Table_Cards TO Areej;


--==============================

-- It also adds her to the built-in roles 'db_datareader' and 'db_datawriter'
-- to allow read and write access to all tables in the database.

EXEC sp_addrolemember 'db_datareader', 'Areej';
EXEC sp_addrolemember 'db_datawriter', 'Areej';


--------------------------------

/* This script removes user 'Areej' from the database
-- and revokes her SELECT, INSERT, UPDATE, and DELETE permissions
-- on the tables: Table_Users, Table_Transactions, and Table_Cards.
-- It also removes her from the built-in roles 'db_datareader' and 'db_datawriter'*/

/*REVOKE SELECT*/
REVOKE SELECT ON Table_Users FROM Areej;
REVOKE SELECT ON Table_Transactions FROM Areej;
REVOKE SELECT ON Table_Cards FROM Areej;

/*REVOKE INSERT, UPDATE*/
REVOKE INSERT, UPDATE ON Table_Users FROM Areej;
REVOKE INSERT, UPDATE ON Table_Transactions FROM Areej;
REVOKE INSERT, UPDATE ON Table_Cards FROM Areej;

/*REVOKE DELETE*/
REVOKE DELETE ON Table_Users FROM Areej;
REVOKE DELETE ON Table_Transactions FROM Areej;
REVOKE DELETE ON Table_Cards FROM Areej;

--==============================

/*Remove user from roles*/
EXEC sp_droprolemember 'db_datareader', 'Areej';
EXEC sp_droprolemember 'db_datawriter', 'Areej';

--==============================

---- Drop the user from the database

DROP USER Areej;
