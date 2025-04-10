DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS Clerk_Store;
DROP TABLE IF EXISTS Clerk;
DROP TABLE IF EXISTS Store_Product;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Country;

CREATE TABLE Country (
    country_code CHAR(2) PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL,
    currency_code CHAR(3) NOT NULL
);

CREATE TABLE Customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Product (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name VARCHAR(50) NOT NULL,
    product_type VARCHAR(25) NOT NULL,
    country_code CHAR(2) NOT NULL,
    FOREIGN KEY (country_code) REFERENCES Country(country_code)
);

CREATE TABLE Store (
    store_id INTEGER PRIMARY KEY AUTOINCREMENT,
    store_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    country_code CHAR(2) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (country_code) REFERENCES Country(country_code)
);

CREATE TABLE Store_Product (
    store_product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    store_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    base_price DECIMAL(10, 0) NOT NULL,
    stock_quantity SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    FOREIGN KEY (store_id) REFERENCES Store(store_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    UNIQUE (store_id, product_id)
);

CREATE TABLE Clerk (
    clerk_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    date_of_birth DATETIME DEFAULT CURRENT_TIMESTAMP,
    country_code CHAR(2) NOT NULL,
    FOREIGN KEY (country_code) REFERENCES Country(country_code)
);

CREATE TABLE Clerk_Store (
    clerk_store_id INTEGER PRIMARY KEY AUTOINCREMENT,
    clerk_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL,
    FOREIGN KEY (clerk_id) REFERENCES Clerk(clerk_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id),
    UNIQUE (clerk_id, store_id)
);

CREATE TABLE Sale (
    sales_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    store_product_id INTEGER NOT NULL,
    clerk_store_id INTEGER NOT NULL,
    quantity_sold SMALLINT UNSIGNED NOT NULL CHECK (quantity_sold > 0),
    currency_used CHAR(3) NOT NULL DEFAULT 'USD',
    conversion_rate DECIMAL(10, 5) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    transaction_time DATETIME DEFAULT CURRENT_TIMESTAMP, -- ONUPDATE CURRENT_TIMESTAMP (not supported for sqlite unfortunately)
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (store_product_id) REFERENCES Store_Product(store_product_id),
    FOREIGN KEY (clerk_store_id) REFERENCES Clerk_Store(clerk_store_id)
);

-- Currency flexibility decision idea: 
-- Before creating a sale -> call middleware to trigger business logic and perform currency conversions
-- Get currency_used
-- Pull updated conversion rates from 3rd party - overwrite "conversion_rate" field
-- Calculate the total price = store_currency * conversion_rate 
