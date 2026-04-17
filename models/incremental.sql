{{ config(
    materialized='incremental',
    unique_key='customer_id',
    incremental_strategy='merge'
) }}

select
    customer_id,
    first_name,
    last_name,
    email,
    city,
    country,
    created_at
from {{ source('raw', 'customers_raw') }}