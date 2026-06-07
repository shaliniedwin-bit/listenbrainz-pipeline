with users as (
    select distinct
        user_name
    from {{ ref('stg_listens') }}
    where user_name is not null
)

select
    {{ dbt_utils.generate_surrogate_key(['user_name']) }} as user_sk,
    user_name,
    current_timestamp() as created_at
from users