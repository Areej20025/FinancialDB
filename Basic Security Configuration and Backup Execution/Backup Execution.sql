
-- Full backup of the FinancialData database

BACKUP DATABASE FinancialData
TO DISK = 'C:\my projects\DATABASE\DONE1-Financial Transactions\CSQLBackups\FinancialData.bak';


-- Differential backup of the FinancialData database
-- Backs up only the changes made since the last full backup

BACKUP DATABASE FinancialData
TO DISK = 'C:\my projects\DATABASE\DONE1-Financial Transactions\CSQLBackups\FinancialData.bak'
WITH DIFFERENTIAL;
