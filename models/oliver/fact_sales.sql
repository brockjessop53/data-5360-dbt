{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
    o.order_id,
    p.product_key,
    c.customer_key,
    e.employee_key,
    s.store_key,
    d.date_key,
    ol.quantity,
    ol.unit_price
FROM {{ source('oliver_landing', 'orders') }} o
INNER JOIN {{ source('oliver_landing', 'orderline') }} ol ON o.order_id = ol.order_id
INNER JOIN {{ ref('oliver_dim_product') }} p ON p.product_id = ol.product_id
INNER JOIN {{ ref('oliver_dim_customer') }} c ON c.customer_id = o.customer_id
INNER JOIN {{ ref('oliver_dim_employee') }} e ON e.employee_id = o.employee_id
INNER JOIN {{ ref('oliver_dim_store') }} s ON s.store_id = o.store_id
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.Ddate = o.order_date