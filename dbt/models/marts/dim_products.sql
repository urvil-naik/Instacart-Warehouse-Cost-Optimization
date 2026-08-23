{{ config(
    materialized = 'table',
    schema = 'core'
) }}

select
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk,
    p.product_id,
    p.product_name,
    p.aisle_id,
    a.aisle_name,
    p.department_id,
    d.department_name
from {{ ref('stg_products') }} p
--
inner join {{ ref('stg_aisles') }} a
on p.aisle_id = a.aisle_id
--
inner join {{ ref('stg_departments') }} d
on p.department_id = d.department_id