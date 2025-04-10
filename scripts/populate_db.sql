INSERT INTO Dim_Customer (first_name, last_name)
VALUES
('John', 'Doe'),
('Jane', 'Smith'),
('Alice', 'Johnson'),
('Bob', 'Williams');

INSERT INTO Dim_Product (product_name, product_type, country_code)
VALUES
('Laptop', 'Electronics', 'US'),
('Smartphone', 'Electronics', 'CN'),
('Coffee Maker', 'Home Appliance', 'US'),
('Tablet', 'Electronics', 'US');

INSERT INTO Dim_Store (store_name, city, country_code, country_name, currency_code)
VALUES
('Tech Store', 'New York', 'US', 'United States', 'USD'),
('Gadget Hub', 'Los Angeles', 'US', 'United States', 'USD'),
('Home Essentials', 'Chicago', 'US', 'United States', 'USD');

INSERT INTO Dim_Clerk (first_name, last_name, date_of_birth, country_code)
VALUES
('Alice', 'Brown', '1990-04-12', 'US'),
('Tom', 'Davis', '1985-11-23', 'US'),
('Emily', 'Martinez', '1992-07-19', 'US');

INSERT INTO Fact_Sales (customer_id, product_id, store_id, clerk_id, quantity_sold, currency_used, conversion_rate, total_price, transaction_time)
VALUES
(1, 1, 1, 1, 2, 'USD', 1.0, 1500.00, '2025-04-01 10:00:00'),
(2, 2, 2, 2, 1, 'USD', 1.0, 800.00, '2025-04-02 11:30:00'),
(3, 3, 3, 3, 3, 'USD', 1.0, 120.00, '2025-04-03 14:00:00'),
(4, 4, 1, 1, 2, 'USD', 1.0, 600.00, '2025-04-04 09:00:00'),
(1, 3, 2, 2, 1, 'USD', 1.0, 120.00, '2025-04-05 16:45:00');

