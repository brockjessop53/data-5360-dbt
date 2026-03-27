{{ config(
    materialized = 'table',
    schema = 'dw_eco_essential'
) }}

SELECT
    ca.campaign_key,
    cu.customer_key,
    e.email_key,
    ev.event_key,
    d.date_key,
    t.timestamp_key
FROM {{ source('email_landing', 'MARKETINGEMAILS') }} me
INNER JOIN {{ ref('dim_promotional_campaign') }} ca
    ON ca.campaign_id = me.campaignid
LEFT JOIN {{ ref('dim_customer') }} cu
    ON LOWER(TRIM(cu.customer_first_name)) = LOWER(TRIM(me.subscriberfirstname))
   AND LOWER(REPLACE(REPLACE(TRIM(cu.customer_last_name), '''', ''), '"', ''))
      = LOWER(REPLACE(REPLACE(TRIM(me.subscriberlastname), '''', ''), '"', ''))
   AND LOWER(TRIM(cu.customer_email)) = LOWER(TRIM(me.subscriberemail))
INNER JOIN {{ ref('dim_email') }} e
    ON e.emailid = me.emailid
INNER JOIN {{ ref('dim_event') }} ev
    ON ev.eventtype = me.eventtype
INNER JOIN {{ ref('dim_date') }} d
    ON d.date = CAST(me.eventtimestamp AS DATE)
INNER JOIN {{ ref('dim_timestamp') }} t
    ON t.date = CAST(me.eventtimestamp AS DATE)
   AND t.hour = EXTRACT(HOUR FROM me.eventtimestamp)
   AND t.minute = EXTRACT(MINUTE FROM me.eventtimestamp)
   AND t.second = EXTRACT(SECOND FROM me.eventtimestamp)