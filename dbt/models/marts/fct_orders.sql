{{ config(
    materialized = 'table',
    schema = 'core'
) }}

select
    {{ dbt_utils.generate_surrogate_key(['o.order_id']) }} as order_sk,
    o.order_id,
    o.user_id,
    o.order_number,
    o.order_dow,
    o.order_hour_of_day,
    o.days_since_prior_order,
    count(*) as total_items
from {{ ref('stg_orders') }} o
--
inner join {{ ref('stg_order_products') }} op
on op.order_id = o.order_id
group by
    o.order_id,
    o.user_id,
    o.order_number,
    o.order_dow,
    o.order_hour_of_day,
    o.days_since_prior_order