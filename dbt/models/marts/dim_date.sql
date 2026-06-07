with dates as (
    select distinct
        listen_date,
        listen_year,
        listen_month,
        listen_day,
        listen_hour,
        day_of_week
    from {{ ref('stg_listens') }}
    where listen_date is not null
)

select
    {{ dbt_utils.generate_surrogate_key(['listen_date', 'listen_hour']) }} as date_sk,
    listen_date,
    listen_year,
    listen_month,
    listen_day,
    listen_hour,
    day_of_week
from dates