select
    cast(department_id as integer) as department_id,
    department
from {{ source('raw', 'departments') }}