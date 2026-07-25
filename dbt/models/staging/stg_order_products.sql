select
    cast(order_id as integer) as order_id,
    cast(product_id as integer) as product_id,
    cast(add_to_cart_order as integer) as add_to_cart_order,
    cast(reordered as boolean) as reordered,
    'PRIOR' as eval_set
from {{ source('raw', 'order_products__prior') }}

union all

select
    cast(order_id as integer) as order_id,
    cast(product_id as integer) as product_id,
    cast(add_to_cart_order as integer) as add_to_cart_order,
    cast(reordered as boolean) as reordered,
    'TRAIN' as eval_set
from {{ source('raw', 'order_products__train') }}