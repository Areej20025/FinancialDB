## 🧠 Phase 1: Project Introduction & Dataset Overview

This project demonstrates the development of a complete **ETL pipeline** and **analytical database system** using SQL Server and SSIS to process and analyze financial transaction data. The main goal is to clean, integrate, and analyze customer, card, and transaction records to extract business insights and support informed decision-making.

###  Objectives:

* Design a normalized relational database schema.
* Implement ETL processes using **SQL Server Integration Services (SSIS)**.
* Validate and clean the data before inserting it into SQL Server.
* Run advanced **SQL queries** to detect patterns, analyze customer behavior.
* Set up user-level **security** and **backup procedures**.

###  Data Source:

* **Dataset**: [Transactions Fraud Datasets on Kaggle](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets)
* **Files Included**:

  * `transactions_data.csv`: records of customer transactions
  * `cards_data.csv`: credit/debit card details
  * `users_data.csv`: customer demographics and account data

## 🧩 Phase 2: Data Modeling

This phase focuses on designing the conceptual and logical structure of the database before implementing any actual tables. It includes identifying tables, defining relationships, and visualizing them using diagrams.

---

### 1. Defining Tables

Three main tables were identified as the foundation of the database:

- **Users**: Contains customer demographic and financial attributes (age, income, credit score, etc.).
- **Cards**: Contains credit/debit card information linked to users.
- **Transactions**: Stores detailed transaction records linked to cards and users.

---

### 2. Designing Relationships (ER Model)

Relationships were defined based on data flow and business logic:

- **Users → Cards**: One-to-Many — one user can own multiple cards.
- **Cards → Transactions**: One-to-Many — each card can be used for multiple transactions.
- **Users → Transactions**: One-to-Many — each user can perform multiple transactions directly (via `client_id`).

**📸 Entity-Relationship Model (ER Model)**

<img src="IMAGE/ER Diagram.png" width="600"/>
---

### 3. Defining Keys and Attributes

For each table, a set of columns (attributes) was defined along with appropriate primary and foreign keys to enforce relational integrity.

- **Primary Keys**:
  - Each table uses an `ID` column as its **Primary Key**.

- **Foreign Keys**:
  - `client_id` in **Cards** links each card to a user in the **Users** table.
  - `card_id` and `client_id` in **Transactions** link each transaction to its corresponding **Card** and **User**.

- **Defined Attributes**:
  - **Users**: `current_age`, `yearly_income`, `credit_score`, `num_credit_cards`, etc.
  - **Cards**: `card_type`, `card_brand`, `credit_limit`, `has_chip`, `expires`, etc.
  - **Transactions**: `amount`, `merchant_id`, `zip`, `date`, `mcc`, `use_chip`, etc.

📸 **Entity Relationship Diagram (ERD)**

<img src="IMAGE/Entity Relationship Diagram (ERD).png" width="600"/>

---

### ✅ Outcome

The database structure is now clearly defined, showing how tables relate to each other through keys and relationships. This prepares the foundation for the next phase: creating the actual tables in SQL Server.

## 🔍 [Phase 3: Data Profiling and Type Selection](Data%20Profiling%20and%20Type%20Selection.sql)

Before creating the actual database tables, an essential step was to **profile the raw data** in order to assign the most accurate data types for each column. This ensured data consistency and optimal storage when building the schema in SQL Server.

---

### Goals of this Phase:

- Understand the structure and range of values in each dataset.
- Extract **distinct values** for key columns using SQL.
- Determine the appropriate SQL data type for each column.
- Ensure compatibility between the data and the planned table design.

---

### How It Was Done:

Using SQL queries such as `SELECT DISTINCT`, each column from the **Users**, **Cards**, and **Transactions** tables was evaluated individually.

For example:

- Columns with whole numbers (e.g., `age`, `mcc`, `num_cards_issued`) → `INT`
- Columns with free text (e.g., `card_type`, `gender`, `merchant_city`) → `VARCHAR`
- Columns representing money or precision values (e.g., `amount`, `credit_limit`, `yearly_income`) → `DECIMAL`
- Columns with a limited set of repeated values (e.g., `use_chip`, `has_chip`) → `CHAR` or `BIT`

This profiling process prepared the foundation for building a normalized and efficient schema structure.

---

### ✅ Outcome:

A full data type map was created for every field in the dataset, which was then directly applied in the table creation scripts. This step ensured smooth data loading and minimized type conversion issues in later ETL stages.



## 🧱 [Phase 4: Database and Table Creation](Database%20Schema%20Creation.sql)


This phase marks the transition from design to implementation. Based on the results of the **Data Modeling** and **Type Selection** phases, the actual database and its tables were created using T-SQL scripts in SQL Server.

---

###  What Was Implemented:

- **Database**: A new database was created to store all financial data.

```sql
  CREATE DATABASE FinancialDB;
```
---

###  Tables Created:

* **Table\_Users**: Stores user demographics and financial details such as age, income, and credit score.
* **Table\_Cards**: Contains card-specific data, with a foreign key `client_id` linking each card to a user.
* **Table\_Transactions**: Records each transaction, linking both to a card (`card_id`) and a user (`client_id`).

---

###  Primary and Foreign Keys:

* Each table has an `id` column as a **Primary Key**.
* Relationships were enforced using **Foreign Keys**:

  * `client_id` in **Table\_Cards** → references `id` in \*\*Table\_Users\`
  * `card_id` and `client_id` in **Table\_Transactions** → reference `Table_Cards` and `Table_Users` respectively

---

###  Data Types Used:

Data types were chosen based on earlier profiling:

* `INT` for numeric identifiers and counts
* `VARCHAR` for variable-length strings
* `DECIMAL` for financial values (e.g., `amount`, `credit_limit`)
* `CHAR` for fixed values (e.g., `gender`, `use_chip`)

### ✅ Outcome

The schema was successfully deployed into SQL Server. All table structures, constraints, and relationships were implemented in alignment with the planned ERD and data types. This foundational step enabled the smooth import and transformation of data in the following phase.

## 🔄[Phase 5: Data Import and Transformation Using SSIS](Data%20Import%20and%20Transformation%20Using%20SSIS/)


After completing the schema design and table creation, this phase focused on importing raw data from external CSV files into SQL Server using **SQL Server Integration Services (SSIS)**. The process included configuring control and data flows, applying transformations, and indexing key columns.

---

###  1. SSIS Project Setup

- A new **SSIS project** was created in SQL Server Data Tools (SSDT).
- The **Control Flow** pane was configured using **Sequence Containers** to group logical operations such as clearing tables, transforming data, and loading it into SQL Server.

📸 **Control Flow – Organizing the Data Load and Index Creation**
<img src="IMAGE/SSIS Control Flow Sequential Load and Index Creation.png" width="600"/>

---

###  2. Data Sources

- Source files were flat files (CSV format) representing:
  - Users
  - Cards
  - Transactions
- Each source file was connected using **Flat File Source** components within the SSIS **Data Flow**.


###  3. Data Transformation Steps

Each data flow task included multiple transformations:

- **Sort**: Sorting rows based on ID fields.
- **Derived Column**: Cleaning and reformatting data (e.g., transforming string formats or fixing invalid entries).
- **Data Conversion**: Converting column types (e.g., `VARCHAR` to `INT`, `CHAR` to `BIT`).
- **Conditional Split** (Card Data only): Filtering valid and invalid CVV entries and exporting invalid rows separately.

📸 **User Data Flow in SSIS**

<img src="IMAGE/User Data Flow in SSIS From Flat File to SQL Table.png" width="400"/>

📸 **Card Data Flow in SSIS with CVV Validation**

<img src="IMAGE/Card Data Flow in SSIS From Flat File to SQL Table.png" width="400"/>

📸 **Transaction Data Flow in SSIS with Lookup Validation**

<img src="IMAGE/Transaction Data Flow in SSIS From Flat File to SQL Table.png" width="400"/>


###  4. Loading Data to Tables

- Transformed data was loaded into SQL Server using **OLE DB Destination**.
- Separate data flows were used to load:
  - `Table_Users`
  - `Table_Cards`
  - `Table_Transactions`



###  5. Index Creation

- After data loading, indexes were created to improve performance:
  - `IX_client_id`
  - `IX_merchant_id`
  - `IX_merchant_city_zip`

📸 **Parallel Index Creation in SSIS**
<img src="IMAGE/SSIS Sequence – Parallel Index Creation on Transaction Table.png" width="400"/>



### ✅ Outcome

- All data was successfully imported, transformed, and validated within SQL Server.
- Invalid rows (e.g., cards with invalid CVV) were separated for reporting.
- Indexes were created to optimize downstream queries and reporting.
- The system is now ready for analytical queries and reporting dashboards.

---


## 🧪 [Phase 6: Data Validation and Performance Verification](Data%20Validation%20and%20Performance%20Verification.sql)


After the ETL process was completed and data was loaded into SQL Server, a set of validation queries were executed to ensure data integrity, completeness, and proper linkage between the tables. Additionally, performance observations were recorded to assess the responsiveness of the database during testing.

---

###  Objectives of This Phase:

- Validate that all expected records were imported successfully.
- Ensure there are no NULL or invalid values in key columns.
- Confirm referential integrity between foreign and primary keys.
- Check performance behavior of basic queries.

---

###  1. Record Count Validation

To verify that data was loaded completely into each table:

```sql
SELECT COUNT(*) FROM Table_Users;
SELECT COUNT(*) FROM Table_Cards;
SELECT COUNT(*) FROM Table_Transactions;
````

This confirmed that the number of rows matched the expected totals from the source files.

---

### 2. Null and Invalid Value Checks

To ensure that critical numeric columns are populated correctly:

```sql
-- Check for missing transaction amounts
SELECT * FROM Table_Transactions WHERE amount IS NULL;

-- Check for invalid or negative age or income values
SELECT * FROM Table_Users WHERE current_age < 0 OR yearly_income < 0;
```

All returned result sets were empty, indicating clean and valid data.

---

### 3. Referential Integrity Checks

To confirm that every `client_id` in `Table_Transactions` exists in `Table_Users`:

```sql
SELECT * 
FROM Table_Transactions t
WHERE NOT EXISTS (
    SELECT 1 FROM Table_Users u WHERE u.ID = t.client_id
);
```

No orphan records were found, meaning the relationship is fully intact.

---

###  4. Performance Observations

* All queries executed instantly.
* No full table scans or delays were observed during validation.
* Indexes on `client_id`, `merchant_id`, and `merchant_city_zip` contributed to fast filtering.

---

### ✅ Outcome

All data quality and integrity checks were successfully passed. The database is now confirmed to be clean, relationally consistent, and performant, making it ready for analytical queries and reporting.


## 📊[Phase 7: Customer Spending Insights Using SQL Analytics](Customer%20Spending%20Insights%20Using%20SQL%20Analytics.sql)


In this phase, we utilized **T-SQL queries** to extract insights from the cleaned and structured data. The analysis aimed to understand customer behavior by joining multiple tables, applying aggregations, and ranking customers based on spending patterns.

---

### 1. Multi-Table Joins

To combine customer, card, and transaction data for enriched insights:

```sql
-- Join Users, Cards, and Transactions to form a unified view
SELECT u.id, u.gender, u.yearly_income, c.card_type, t.amount, t.date
FROM Table_Users u
JOIN Table_Cards c ON u.id = c.client_id
JOIN Table_Transactions t ON c.id = t.card_id;
````

This join enabled cross-analysis of demographics, card types, and spending.

---

### 2. Aggregated Spending by Customer

To identify top-spending customers and total revenue per user:

```sql
-- Total spend per customer
SELECT u.id, u.gender, SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.id = t.client_id
GROUP BY u.id, u.gender;
```

---

### 3. Average Spending and Gender-Based Comparison

To calculate average spend and evaluate differences between male and female customers:

```sql
-- Average spending by gender
SELECT u.gender, AVG(t.amount) AS avg_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.id = t.client_id
GROUP BY u.gender;
```

---

### 4. Monthly Spending Trends

To monitor how spending changes across different months:

```sql
-- Total spending by month
SELECT MONTH(t.date) AS txn_month, SUM(t.amount) AS monthly_total
FROM Table_Transactions t
GROUP BY MONTH(t.date)
ORDER BY txn_month;
```

---

### 5. Spending by Age Group (Using CASE)

To compare spending behavior between age brackets:

```sql
-- Categorize by age and calculate total spending
SELECT 
  CASE 
    WHEN u.current_age < 30 THEN 'Under 30'
    WHEN u.current_age BETWEEN 30 AND 50 THEN '30-50'
    ELSE 'Over 50'
  END AS age_group,
  SUM(t.amount) AS total_spent
FROM Table_Users u
JOIN Table_Transactions t ON u.id = t.client_id
GROUP BY 
  CASE 
    WHEN u.current_age < 30 THEN 'Under 30'
    WHEN u.current_age BETWEEN 30 AND 50 THEN '30-50'
    ELSE 'Over 50'
  END;
```

---

### 6. Ranking Customers by Spending (Window Functions)

To identify the highest-spending customers:

```sql
-- Rank customers by total spending
SELECT id, total_spent, RANK() OVER (ORDER BY total_spent DESC) AS rank
FROM (
  SELECT u.id, SUM(t.amount) AS total_spent
  FROM Table_Users u
  JOIN Table_Transactions t ON u.id = t.client_id
  GROUP BY u.id
) ranked;
```

---

### ✅ Outcome

The results of this phase provide deep insight into:

* Who the top spenders are
* How spending varies by gender, age, and month
* How to segment customers for marketing and targeting

This data-driven understanding empowers decision-makers to optimize offers, personalize customer experiences, and identify high-value segments effectively.

## 🔐[Phase 8: Basic Security Configuration and Backup Execution](Basic%20Security%20Configuration%20and%20Backup%20Execution/)


In this final phase, two key administrative tasks were performed to protect the data and manage recovery:

---

###  User Permission Setup

A single database user named **`Areej`** was created and assigned specific access rights to interact with the system:

* Granted permission to **read, insert, update, and delete** records from the main tables: `Table_Users`, `Table_Transactions`, and `Table_Cards`.
* Added to the SQL Server built-in roles:

  * `db_datareader`: for full read access across the database.
  * `db_datawriter`: for full write access to all tables.
* Additionally, scripts were included to **revoke all permissions** and **remove the user** from the database when needed.

This ensures controlled access to data and supports role-based security.

---

###  Backup Execution

Two types of backups were performed on the database:

* ✅ **Full Backup**: A complete backup of the entire `FinancialData` database was saved to a local disk.
* ✅ **Differential Backup**: Captured only the changes made since the last full backup, optimizing backup size and duration.

These actions ensure that data can be restored safely in case of system failure or data loss.

---

### ✅ Outcome

* Role-based access was implemented for a test user (`Areej`) with flexible permission control.
* Manual full and differential backups were executed successfully and stored in a safe local directory.

The database is now equipped with essential access and recovery configurations suitable for controlled internal use.

## 🏁 Conclusion

This project represents a complete end-to-end data engineering workflow using Microsoft SQL Server and SSIS. From database design and data profiling to ETL, validation, analysis, and securing the system — every stage has been documented and implemented practically.

### ✅ Final Outcomes:

* A clean, validated database ready for reporting and analysis
* Rich insights about customer spending trends across gender, age groups, and time
* Structured ETL pipelines that transform and load data efficiently
* Role-based access control and backup plans in place

This implementation provides a strong foundation for further business intelligence integrations, such as Power BI dashboards, fraud detection models, or customer segmentation strategies.
