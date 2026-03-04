{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
employee_id as employee_key,
employee_id,
first_name as fname,
last_name as lname,
email as empemail,
phone_number as empphonenumber,
hire_date as hiredate,
position
FROM {{source('oliver_landing', 'employee')}}
