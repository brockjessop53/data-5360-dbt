{{ config(
    materialized = 'table',
    schema = 'dw_eco_essential'
    )
}}

SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['emailid', 'emailname']) }} as email_key,
    emailid,
    emailname
FROM {{ source('email_landing', 'MARKETINGEMAILS') }}