SELECT
    ds.store_name AS "Store Name",
    ds.city AS "Store City",
    ds.country_name AS "Store Country",
    ds.country_code AS "Store Country Code",
    strftime('%Y-%m', fs.transaction_time) AS "Sale Month",
    SUM(fs.total_price) AS "Total Revenue in USD"
FROM
    Fact_Sales fs
JOIN Dim_Store ds ON fs.store_id = ds.store_id
WHERE fs.currency_used = 'USD'
GROUP BY
    ds.store_id,
    strftime('%Y-%m', fs.transaction_time)
ORDER BY
    "Sale Month",
    "Store Name";
