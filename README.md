## 🧩 Phase 2: Data Modeling

This phase focuses on designing the conceptual and logical structure of the database before implementing any actual tables. It includes identifying tables, defining relationships, and visualizing them using diagrams.

---

### 1. Defining Tables

Three main tables were identified as the foundation of the database:

- **Users**: Contains customer demographic and financial attributes (age, income, credit score, etc.).
- **Cards**: Contains credit/debit card information linked to users.
- **Transactions**: Stores detailed transaction records linked to cards and users.

---

### 2. Designing Relationships (ER Diagram)

Relationships were defined based on data flow and business logic:

- **Users → Cards**: One-to-Many — one user can own multiple cards.
- **Cards → Transactions**: One-to-Many — each card can be used for multiple transactions.

📸 **UML Class Diagram – Full Table Structures and Types**

![Class Diagram of Financial Database Schema – Users, Cards, Transactions](screenshots/Entity Relationship Diagram (ERD).png)

---

### 3. Selecting Primary and Foreign Keys

- Each table has an `ID` as a **Primary Key**.
- Foreign keys were added:
  - `client_id` in Cards links to Users.
  - `card_id` and `client_id` in Transactions link to Cards and Users respectively.

---

### 4. Defining Attributes (Columns)

Each table was designed with specific attributes:

- **Users**: `current_age`, `yearly_income`, `credit_score`, etc.
- **Cards**: `card_type`, `credit_limit`, `expires`, etc.
- **Transactions**: `amount`, `merchant_id`, `zip`, `date`, etc.

📸 **ER Diagram – Logical Relationships and Cardinality**

![Entity-Relationship Model – Visualizing 1:N Links in the Financial Schema](IMAGE/Entity Relationship Diagram (ERD).png)

---

### ✅ Outcome

The database structure is now clearly defined, showing how tables relate to each other through keys and relationships. This prepares the foundation for the next phase: creating the actual tables in SQL Server.
