DROP TABLE IF EXISTS Fact_Sales;
DROP TABLE IF EXISTS Dim_Customer;
DROP TABLE IF EXISTS Dim_Product;
DROP TABLE IF EXISTS Dim_Store;
DROP TABLE IF EXISTS Dim_Clerk;
DROP TABLE IF EXISTS Dim_Date;

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
    currency_code CHAR(2)
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
