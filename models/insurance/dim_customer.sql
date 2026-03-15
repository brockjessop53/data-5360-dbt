{{ config(
    materialized = 'table',
    schema = 'dw_insurance'
    )
}}

with db_source as (
    select
    customerid,
    firstname,
    lastname,
    dob,
    address,
    city,
    state,
    zipcode
    FROM {{ source('insurance_landing', 'customers') }}
)

, cs_interactions_source as (
    SELECT distinct 
        customer_first_name,
        customer_last_name,
        customer_email
    from {{ ref('stg_customer_service_interactions')}}
)
, final as (
    select 
    customerid,
    coalesce(d.firstname, cs.customer_first_name) as firstname,
    coalesce(d.lastname, cs.customer_last_name) as lastname,
    dob,
    address,
    city,
    state,
    zipcode,
    customer_email
    from db_source as d
    full join cs_interactions_source as cs on d.firstname = cs.customer_first_name and d.lastname = cs.customer_last_name
)

select
    {{ dbt_utils.generate_surrogate_key(['firstname', 'lastname']) }} as customer_key,
    *
from final