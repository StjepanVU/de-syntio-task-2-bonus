# de-syntio-task-2-bonus
Bonus task (SQL Modelling-Data Mart) for Syntio; Data Engineer role application.
Simple app POC that demonstrates the use of created SQL scripts:
- Creates SQL tables
- Populates the data 
- Runs the sales report in-line with the requirements of the task 2 but with new data models.
- Runs the monthly revenu report (bonus task)

**Complimentary files** are also included here after the Project Installation Steps.

---
## 🚀 1. Project Installation Steps (bash)

1. Clone the repository:

    ```bash
    git clone https://github.com/StjepanVU/de-syntio-task-2-bonus.git
    ```


2. Enter the project folder:

    ```bash
    cd de-syntio-task-2-bonus
    ```


3. Start Docker


4. Run the Docker Compose command (attached as the console gives report output):

    ```bash
    docker-compose up
    ```    

5. Press "**Enter**" to exit console

   
6. Report will be executed and generated as .csv file in the ./reports folder
---
## 📂 2. Complimentary files
1. SQL script for Create table, Data population and Queries are contained in the **./scripts** folder
2. ER diagram is provided in the project root directory

**create_tables.sql: (with dimension and fact tables):**
```sql
DROP TABLE IF EXISTS Fact_Sales;
DROP TABLE IF EXISTS Dim_Customer;
DROP TABLE IF EXISTS Dim_Product;
DROP TABLE IF EXISTS Dim_Store;
DROP TABLE IF EXISTS Dim_Clerk;

CREATE TABLE Dim_Customer (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(25),
    last_name VARCHAR (25)
);

CREATE TABLE Dim_Product (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(50),
    product_type VARCHAR(25),
    country_code CHAR(2)
);

CREATE TABLE Dim_Store (
    store_id INTEGER PRIMARY KEY,
    store_name VARCHAR(50),
    city VARCHAR(50),
    country_code CHAR(2),
    country_name VARCHAR(50),
    currency_code CHAR(3)
);

CREATE TABLE Dim_Clerk (
    clerk_id INTEGER PRIMARY KEY,
    first_name VARCHAR(25),
    last_name VARCHAR(25),
    date_of_birth DATE DEFAULT CURRENT_DATE,
    country_code CHAR(2)
);

CREATE TABLE Fact_Sales (
    sales_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    product_id INTEGER,
    store_id INTEGER,
    clerk_id INTEGER,
    quantity_sold SMALLINT UNSIGNED NOT NULL CHECK (quantity_sold > 0),
    currency_used CHAR(3) NOT NULL DEFAULT 'USD',
    conversion_rate DECIMAL(10, 5) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    transaction_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Dim_Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Dim_Product(product_id),
    FOREIGN KEY (store_id) REFERENCES Dim_Store(store_id),
    FOREIGN KEY (clerk_id) REFERENCES Dim_Clerk(clerk_id)
);
```
---
**get_sales_report.sql (join operators reduced by half)**
```sql
SELECT
    dc.first_name AS "Customer First Name",
    dc.last_name AS "Customer Last Name",
    dp.product_name AS "Product Name",
    fs.total_price AS "Product Price In USD",
    dp.product_type AS "Product Type",
    fs.quantity_sold AS "Product Units Sold",
    ds.store_name AS "Store Name",
    ds.city AS "Store City",
    ds.country_name AS "Store Country",
    ds.country_code AS "Store Country Code",
    dcl.first_name AS "Clerk First Name",
    dcl.last_name AS "Clerk Last Name",
    dcl.date_of_birth AS "Clerk Date of Birth",
    dcl.country_code AS "Clerk Country of Birth",
    fs.currency_used AS "Currency Used"
FROM
    Fact_Sales fs
INNER JOIN Dim_Customer dc ON fs.customer_id = dc.customer_id
INNER JOIN Dim_Product dp ON fs.product_id = dp.product_id
INNER JOIN Dim_Store ds ON fs.store_id = ds.store_id
INNER JOIN Dim_Clerk dcl ON fs.clerk_id = dcl.clerk_id
WHERE
    fs.currency_used = 'USD';
```
---
**get_monthly_revenue.sql:**
```sql
SELECT
    ds.store_name AS "Store Name",
    ds.city AS "Store City",
    ds.country_name AS "Store Country",
    ds.country_code AS "Store Country Code",
    strftime('%Y-%m', fs.transaction_time) AS "Sale Month",
    SUM(fs.total_price) AS "Total Revenue in USD"
FROM
    Fact_Sales fs
INNER JOIN Dim_Store ds ON fs.store_id = ds.store_id
WHERE fs.currency_used = 'USD'
GROUP BY
    ds.store_id,
    strftime('%Y-%m', fs.transaction_time)
ORDER BY
    "Sale Month",
    "Store Name";
```
---
**ER diagram:**

![ER diagram](https://github.com/user-attachments/assets/f13c57e0-e674-4f5d-b581-efc2db8e21c6)
