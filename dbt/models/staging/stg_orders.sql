select
    cast(order_id as integer) as order_id,
    cast(user_id as integer) as user_id,
    cast(order_number as integer) as order_number,
    cast(order_dow as integer) as order_dow,
    cast(order_hour_of_day as integer) as order_hour_of_day,
    cast(days_since_prior_order as float) as days_since_prior_order
from {{ source('raw', 'orders') }}
where upper(trim(eval_set)) != 'TEST'