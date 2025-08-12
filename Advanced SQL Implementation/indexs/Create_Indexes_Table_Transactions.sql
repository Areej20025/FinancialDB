-- Create an index on client_id in Table_Transactions
CREATE INDEX IX_client_id
ON Table_Transactions (client_id);

-- Create an index on merchant_id in Table_Transactions
CREATE INDEX IX_merchant_id
ON FactTable_Transactions (merchant_id);

-- Create a composite index on merchant_city and zip in Table_Transactions
CREATE INDEX IX_merchant_city_zip
ON Table_Transactions (merchant_city, zip);
