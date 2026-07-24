select
    cast(aisle_id as integer) as aisle_id,
    aisle
from {{ source('raw', 'aisles') }}