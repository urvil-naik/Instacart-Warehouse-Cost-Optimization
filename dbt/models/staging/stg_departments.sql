select
    cast(department_id as integer) as department_id,
    upper(trim(department)) as department_name
from {{ source('raw', 'departments') }}