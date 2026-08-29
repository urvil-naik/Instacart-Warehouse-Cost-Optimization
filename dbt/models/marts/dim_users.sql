{{ config(
    materialized = 'table',
    schema = 'core'
) }}


with user_orders as (
    select
        user_id,
        max(order_number) as total_orders,
        to_decimal(avg(days_since_prior_order), 6, 1) as avg_days_between_orders
    from {{ ref('stg_orders') }}
    group by user_id
),

user_items as (
    select
        o.user_id,
        count(*) as total_items_bought,
        sum(op.reordered) as total_reorders,
        to_decimal((avg(op.reordered) * 100), 5, 2) as reorder_rate_pct,
        count(distinct op.product_id) as unique_products_bought
    from {{ ref('stg_order_products') }} op
    --
    inner join {{ ref('stg_orders') }} o
    on op.order_id = o.order_id
    --
    group by o.user_id
)

select
    {{ dbt_utils.generate_surrogate_key(['uo.user_id']) }} as user_sk,
    uo.user_id,
    uo.total_orders,
    uo.avg_days_between_orders,
    to_decimal(cast(ui.total_items_bought as float) / nullif(uo.total_orders, 0), 6, 1) as avg_basket_size,
    ui.total_reorders,
    ui.reorder_rate_pct,
    ui.unique_products_bought,
    case
        when uo.total_orders between 1 and 4 then 'casual'
        when uo.total_orders between 5 and 9 then 'occasional'
        when uo.total_orders between 10 and 19 then 'regular'
        when uo.total_orders between 20 and 49 then 'loyal'
        when uo.total_orders >= 50 then 'power user'
    end as frequency_segment
from user_orders uo
--
inner join user_items ui
on uo.user_id = ui.user_id