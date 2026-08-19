{{ config(
    materialized = 'table',
    schema = 'core'
) }}

select
    {{ dbt_utils.generate_surrogate_key(['op.order_id','op.product_id']) }} as order_product_key,
    op.order_id,
    op.product_id,
    op.add_to_cart_order,
    op.reordered,
    o.user_id,
    o.eval_set,
    o.order_number,
    o.order_dow,
    o.order_hour_of_day,
    o.days_since_prior_order
from {{ ref('stg_order_products') }} op
--
inner join {{ ref('stg_orders') }} o
on op.order_id = o.order_id