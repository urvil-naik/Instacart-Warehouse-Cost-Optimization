select
    cast(aisle_id as integer) as aisle_id,
    upper(trim(aisle)) as aisle_name
from {{ source('raw', 'aisles') }}