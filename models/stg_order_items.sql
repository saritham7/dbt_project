{{config(materialized='table')}}
select
    order_item_id,
    order_id,
    product_id,
    quantity,
    price,
    quantity * price as line_revenue
from {{ source('raw','order_items_raw') }}