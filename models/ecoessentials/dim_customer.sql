{{ config(
    materialized = 'table',
    schema = 'dw_eco_essential'
) }}

with customer as (
    SELECT DISTINCT
        customer_id,
        customer_first_name,
        customer_last_name,
        customer_phone,
        customer_address,
        customer_city,
        customer_state,
        customer_zip,
        customer_country,
        customer_email
    FROM {{ source('eco_essential_landing', 'customer') }}
),
subscriber as (
    SELECT DISTINCT
        subscriberid,
        subscriberemail,
        subscriberfirstname,
        subscriberlastname
    FROM {{ source('email_landing', 'MARKETINGEMAILS') }}
    WHERE customerid = 'NULL'
),
combined as (
    SELECT DISTINCT
        customer_id,
        COALESCE(c.customer_first_name, s.subscriberfirstname) as customer_first_name,
        COALESCE(c.customer_last_name, s.subscriberlastname) as customer_last_name,
        customer_phone,
        customer_address,
        customer_city,
        customer_state,
        customer_zip,
        customer_country,
        COALESCE(c.customer_email, s.subscriberemail) as customer_email
    FROM customer c FULL OUTER JOIN subscriber s ON c.customer_first_name = s.subscriberfirstname AND c.customer_last_name = s.subscriberlastname
)
SELECT {{ dbt_utils.generate_surrogate_key(['customer_first_name', 'customer_last_name']) }} as customer_key,
    *
FROM combined