{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    city,
    country,
    created_at
FROM {{ source('raw','customers_raw') }}

{% if is_incremental() %}
-- Only load new or changed data
WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}