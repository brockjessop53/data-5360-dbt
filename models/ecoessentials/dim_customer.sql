{{ config(
    materialized = 'table',
    schema = 'dw_eco_essential'
) }}

with base as (

    select
        customer_id,
        trim(customer_first_name) as customer_first_name,
        trim(customer_last_name) as customer_last_name,
        customer_phone,
        customer_address,
        customer_city,
        customer_state,
        customer_zip,
        customer_country,
        trim(customer_email) as customer_email
    from {{ source('eco_essential_landing', 'customer') }}

),

deduped as (

    select *
    from base
    qualify row_number() over (
        partition by
            lower(trim(customer_first_name)),
            lower(trim(customer_last_name)),
            lower(trim(customer_email))
        order by customer_id
    ) = 1

)

select
    {{ dbt_utils.generate_surrogate_key([
        "lower(trim(customer_first_name))",
        "lower(trim(customer_last_name))",
        "lower(trim(customer_email))"
    ]) }} as customer_key,
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
from deduped