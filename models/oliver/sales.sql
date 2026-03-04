{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
    f.order_id,
    c.first_name,
    c.last_name,
    p.product_name,
    d.ddate,
    e.fname,
    e.lname,
    e.position,
    s.store_name,
    s.state,
    f.quantity,
    f.unit_price
FROM {{ ref('fact_sales') }} as f
LEFT JOIN {{ ref('oliver_dim_customer') }} as c ON c.customer_key = f.customer_key
LEFT JOIN {{ ref('oliver_dim_employee') }} as e ON e.employee_key = f.employee_key
LEFT JOIN {{ ref('oliver_dim_product') }} as p ON p.product_key = f.product_key
LEFT JOIN {{ ref('oliver_dim_store') }} as s ON s.store_key = f.store_key
LEFT JOIN {{ ref('oliver_dim_date') }} as d ON d.date_key = f.date_key