{{ config(
    materialized = 'table',
    schema = 'dw_insurance'
) }}

SELECT
    p.policy_key,
    cu.customer_key,
    a.agent_key,
    d.date_key,
    c.ClaimAmount
FROM {{ source('insurance_landing', 'claims') }} c
INNER JOIN {{ source('insurance_landing', 'policies') }} pd ON c.PolicyID = pd.PolicyID
INNER JOIN {{ ref('dim_policys') }} p ON pd.PolicyID = p.policyid 
INNER JOIN {{ ref('dim_customers') }} cu ON pd.CustomerID = cu.customerid 
INNER JOIN {{ ref('dim_agents') }} a ON pd.AgentID = a.agentid 
INNER JOIN {{ ref('dim_dates') }} d ON d.date_day = c.ClaimDate
