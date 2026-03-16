{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
    de.employee_key,
    dd.date_key,
    stg.certification_name,
    stg.certification_cost
FROM {{ ref('stg_employee_certifications') }} stg
    INNER JOIN {{ ref('oliver_dim_date') }} dd ON stg.certification_awarded_date = dd.ddate
    INNER JOIN {{ ref('oliver_dim_employee') }} de ON stg.employee_id = de.employee_id