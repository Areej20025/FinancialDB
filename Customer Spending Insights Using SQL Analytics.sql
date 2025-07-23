-- Join user data with card details
SELECT 
    u.ID, 
    u.current_age, 
    u.gender, 
    c.card_brand, 
    c.card_type, 
    c.credit_limit
FROM Table_Users u
JOIN Table_Cards c ON u.ID = c.client_id
ORDER BY u.ID;

-- Total sales per customer
SELECT 
    u.ID, 
    SUM(t.amount) AS total_sales
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
GROUP BY u.ID;

-- Spending analysis by age and gender
SELECT 
    u.current_age, 
    u.gender, 
    SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
GROUP BY u.current_age, u.gender;

-- Total spending by gender
SELECT 
    u.gender, 
    SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
GROUP BY u.gender;

-- Average spending per customer
SELECT 
    u.ID, 
    AVG(t.amount) AS avg_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
GROUP BY u.ID;

-- Spending analysis over time (by months or years)
SELECT 
    YEAR(t.date) AS year, 
    MONTH(t.date) AS month, 
    SUM(t.amount) AS total_spent
FROM Table_Transactions t
GROUP BY YEAR(t.date), MONTH(t.date)
ORDER BY year, month;

-- Spending analysis by age groups (Under 30, 30 to 50, Over 50)
SELECT 
    CASE 
        WHEN u.current_age < 30 THEN 'Under 30'
        WHEN u.current_age BETWEEN 30 AND 50 THEN '30 to 50'
        ELSE 'Over 50'
    END AS age_group,
    SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
GROUP BY 
    CASE 
        WHEN u.current_age < 30 THEN 'Under 30'
        WHEN u.current_age BETWEEN 30 AND 50 THEN '30 to 50'
        ELSE 'Over 50'
    END;

-- Ranking customers by spending
SELECT 
    u.ID, 
    SUM(t.amount) AS total_spent, 
    RANK() OVER (ORDER BY SUM(t.amount) DESC) AS rank
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
GROUP BY u.ID;

-- *Expanded Queries and Additional Analysis:
-- Join card details with transaction details to get total transactions per card type
SELECT 
    c.card_type, 
    SUM(t.amount) AS total_transaction_amount
FROM Table_Cards c
JOIN Table_Transactions t ON c.id = t.card_id
GROUP BY c.card_type;

-- Identify the card brands with the highest number of transactions
SELECT 
    c.card_brand, 
    COUNT(t.id) AS number_of_transactions
FROM Table_Cards c
JOIN Table_Transactions t ON c.id = t.card_id
GROUP BY c.card_brand
ORDER BY number_of_transactions DESC;

-- Calculate total spending in a specific month (example: May)
SELECT 
    u.ID, 
    SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
WHERE MONTH(t.date) = 5  -- Example: May
GROUP BY u.ID;

-- Find customers who spent the most in a specific month (example: May)
SELECT TOP 10 -- LIMIT 10
    u.ID, 
    SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
WHERE MONTH(t.date) = 5  -- Example: May
GROUP BY u.ID
ORDER BY total_spent DESC;

-- Calculate total spending per age group
SELECT 
    CASE 
        WHEN u.current_age < 30 THEN 'Under 30'
        WHEN u.current_age BETWEEN 30 AND 50 THEN '30 to 50'
        ELSE 'Over 50'
    END AS age_group,
    SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
GROUP BY 
    CASE 
        WHEN u.current_age < 30 THEN 'Under 30'
        WHEN u.current_age BETWEEN 30 AND 50 THEN '30 to 50'
        ELSE 'Over 50'
    END;

-- Calculate average spending per card type
SELECT 
    c.card_type, 
    AVG(t.amount) AS avg_spent
FROM Table_Cards c
JOIN Table_Transactions t ON c.id = t.card_id
GROUP BY c.card_type;

-- Trend analysis by year
SELECT 
    YEAR(t.date) AS year, 
    SUM(t.amount) AS total_spent
FROM Table_Transactions t
GROUP BY YEAR(t.date)
ORDER BY year;

-- Monthly spending analysis for the year 2018
SELECT 
    YEAR(t.date) AS year, 
    MONTH(t.date) AS month, 
    SUM(t.amount) AS total_spent
FROM Table_Transactions t
WHERE t.date BETWEEN '2018-01-01' AND '2018-12-31'
GROUP BY YEAR(t.date), MONTH(t.date)
ORDER BY year, month;

-- Spending analysis by income level (if data is available)
SELECT 
    CASE 
        WHEN u.yearly_income < 50000 THEN 'Low Income'
        WHEN u.yearly_income BETWEEN 50000 AND 100000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_group,
    SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
GROUP BY 
    CASE 
        WHEN u.yearly_income < 50000 THEN 'Low Income'
        WHEN u.yearly_income BETWEEN 50000 AND 100000 THEN 'Medium Income'
        ELSE 'High Income'
    END;

-- Counting transactions per customer for the year 2019
SELECT 
    u.ID, 
    COUNT(t.id) AS number_of_transactions,
    ROW_NUMBER() OVER (PARTITION BY u.ID ORDER BY COUNT(t.id) DESC) AS row_num
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
WHERE t.date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY u.ID;

-- Ranking customers by total spending in 2017
SELECT 
    u.ID, 
    SUM(t.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(t.amount) DESC) AS rank
FROM Table_Users u
JOIN Table_Transactions t ON u.ID = t.client_id
WHERE t.date BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY u.ID;
