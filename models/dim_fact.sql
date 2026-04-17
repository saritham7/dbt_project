{{ config(materialized='incremental') }}

select
    oi.order_item_id,
    oi.order_id,
    o.customer_id,   -- derived
    oi.product_id,
    o.order_date,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) as total_amount
from {{ ref('stg_order_items') }} oi
join {{ ref('stg_orders') }} o
    on oi.order_id = o.order_id

{% if is_incremental() %}
where o.order_date > (select max(order_date) from {{ this }})
{% endif %}
