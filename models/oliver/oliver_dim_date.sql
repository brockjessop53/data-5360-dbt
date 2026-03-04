{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

with cte_date as (
{{ dbt_date.get_date_dimension("1990-01-01", "2050-12-31") }}
)

SELECT
date_day as date_key,
date_day as ddate,
day_of_week as dayofweek,
month_of_year as month,
year_number as year,
quarter_of_year as quarter
from cte_date