{{ config(
    materialized = 'table',
    schema = 'dw_eco_essential'
    )
}}

SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['eventtype']) }} as event_key,
    eventtype
FROM {{ source('email_landing', 'MARKETINGEMAILS') }}