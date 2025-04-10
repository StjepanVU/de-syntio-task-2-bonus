SELECT 
    c.first_name AS "Customer First Name",
    c.last_name AS "Customer Last Name",
    p.product_name AS "Product Name",
    sp.base_price AS "Product Price In USD",
    p.product_type AS "Product Type",
    s.quantity_sold AS "Product Units Sold",
    st.store_name AS "Store Name",
    st.city AS "Store City",
    co.country_name AS "Store Country",
    co.country_code AS "Store Country Code",
    cl.first_name AS "Clerk First Name",
    cl.last_name AS "Clerk Last Name",
    cl.date_of_birth AS "Clerk Date of Birth",
    co_cl.country_code AS "Clerk Country of Birth",
    s.currency_used AS "Currency Used",
    s.transaction_time AS "Transaction Time"
FROM 
    Sale s
INNER JOIN 
    Customer c ON s.customer_id = c.customer_id
INNER JOIN 
    Store_Product sp ON s.store_product_id = sp.store_product_id
INNER JOIN 
    Product p ON sp.product_id = p.product_id
INNER JOIN 
    Store st ON sp.store_id = st.store_id
INNER JOIN 
    Country co ON st.country_code = co.country_code
INNER JOIN 
    Clerk_Store cs ON s.clerk_store_id = cs.clerk_store_id
INNER JOIN 
    Clerk cl ON cs.clerk_id = cl.clerk_id
INNER JOIN 
    Country co_cl ON cl.country_code = co_cl.country_code
WHERE 
    s.currency_used = 'USD';
