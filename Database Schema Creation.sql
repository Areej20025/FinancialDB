CREATE TABLE Table_Users (
    ID INT PRIMARY KEY,
    current_age INT,
    retirement_age INT,
    birth_year INT,
    birth_month INT,
    gender CHAR(6), 
    address VARCHAR(255),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    per_capita_income INT,
    yearly_income INT,
    total_debt INT,
    credit_score INT,
    num_credit_cards INT
);
CREATE TABLE Table_Cards (
    id INT PRIMARY KEY,
    client_id INT ,
    card_brand VARCHAR(10), 
    card_type VARCHAR(20),  
    card_number VARCHAR(16),
    expires DATE ,
    cvv VARCHAR(4),
    has_chip CHAR(3), 
    num_cards_issued INT,
    credit_limit INT,
    acct_open_date DATE,
    year_pin_last_changed INT,
    card_on_dark_web VARCHAR(4),
    CONSTRAINT FK_Cards_Users FOREIGN KEY (client_id) REFERENCES Table_Users(ID)  
);


CREATE TABLE Table_Transactions  (
    id INT PRIMARY KEY,
    [date] DATETIME,
    client_id INT,
    card_id INT,
    amount DECIMAL(10, 2),
    use_chip VARCHAR(30),
    merchant_id INT,
    merchant_city VARCHAR(100),
    merchant_state CHAR(50),
    zip VARCHAR(5),
    mcc INT,
    errors NVARCHAR(MAX),
    CONSTRAINT FK_Transactions_Cards FOREIGN KEY (card_id) REFERENCES Table_Cards(id),  
    CONSTRAINT FK_Transactions_Users FOREIGN KEY (client_id) REFERENCES Table_Users(ID)  
);

