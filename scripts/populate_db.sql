INSERT INTO Country (country_code, country_name, currency_code) VALUES 
('US', 'United States', 'USD'),
('CA', 'Canada', 'CAD'),
('MX', 'Mexico', 'MXN'),
('FR', 'France', 'EUR'),
('GR', 'Germany', 'EUR'),
('JP', 'Japan', 'JPY');

INSERT INTO Customer (first_name, last_name, email) VALUES 
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Alice', 'Johnson', 'alice.johnson@example.com'),
('Bob', 'Brown', 'bob.brown@example.com'),
('Charlie', 'Davis', 'charlie.davis@example.com');

INSERT INTO Product (product_name, product_type, country_code) VALUES 
('Laptop', 'Electronics', 'US'),
('Smartphone', 'Electronics', 'GR'),
('Tablet', 'Electronics', 'CA'),
('Headphones', 'Accessories', 'FR'),
('Camera', 'Electronics', 'JP');

INSERT INTO Store (store_name, city, country_code, email) VALUES 
('Tech World', 'New York', 'US', 'ny@techworld.com'),
('Gadget Hub', 'Berlin', 'GR', 'berlin@gadgethub.com'),
('Maple Tech', 'Toronto', 'CA', 'toronto@mapletech.com'),
('Paris Electronics', 'Paris', 'FR', 'paris@electronics.com'),
('Tokyo Gadgets', 'Tokyo', 'JP', 'tokyo@gadgets.com');

INSERT INTO Store_Product (store_id, product_id, base_price, stock_quantity) VALUES 
(1, 1, 999, 50),
(2, 2, 799, 30),
(3, 3, 499, 20),
(4, 4, 199, 100),
(5, 5, 299, 10);

INSERT INTO Clerk (first_name, last_name, date_of_birth, country_code) VALUES 
('Emily', 'Clark', '1990-05-15 16:43:39', 'US'),
('Liam', 'Müller', '1985-08-20 16:43:39', 'GR'),
('Sophia', 'Brown', '1992-11-10 16:43:39', 'CA'),
('Lucas', 'Dubois', '1988-03-25 16:43:39', 'FR'),
('Hiro', 'Tanaka', '1995-07-30 16:43:39', 'JP');

INSERT INTO Clerk_Store (clerk_id, store_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Sale (customer_id, store_product_id, clerk_store_id, quantity_sold, currency_used, conversion_rate, total_price) VALUES 
(1, 1, 1, 2, 'JPY', 1.00000, 1999.98),
(2, 2, 2, 3, 'USD', 1.00000, 2399.97),
(3, 3, 3, 4,'EUR' ,1.00000 ,1999.96 ),
(4 ,4 ,4 ,5,'USD' ,1.00000 ,799.95 ),
(5 ,5 ,5 ,1 ,'EUR' ,1.00000 ,299 );
