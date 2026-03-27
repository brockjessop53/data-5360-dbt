{{ config(
    materialized = 'table',
    schema = 'dw_eco_essential'
) }}

SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key([
        "eventtimestamp"
    ]) }} AS timestamp_key,
    eventtimestamp AS full_timestamp,
    CAST(eventtimestamp AS DATE) AS date,
    EXTRACT(HOUR FROM eventtimestamp) AS hour,
    EXTRACT(MINUTE FROM eventtimestamp) AS minute,
    EXTRACT(SECOND FROM eventtimestamp) AS second
FROM {{ source('email_landing', 'MARKETINGEMAILS') }}