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
JOIN Dim_Customer dc ON fs.customer_id = dc.customer_id
JOIN Dim_Product dp ON fs.product_id = dp.product_id
JOIN Dim_Store ds ON fs.store_id = ds.store_id
JOIN Dim_Clerk dcl ON fs.clerk_id = dcl.clerk_id
WHERE
    fs.currency_used = 'USD';
