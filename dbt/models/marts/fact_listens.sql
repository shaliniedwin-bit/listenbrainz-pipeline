with listens as (
    select * from {{ ref('stg_listens') }}
),

dim_user   as (select * from {{ ref('dim_user') }}),
dim_artist as (select * from {{ ref('dim_artist') }}),
dim_track  as (select * from {{ ref('dim_track') }}),
dim_date   as (select * from {{ ref('dim_date') }})

select
    {{ dbt_utils.generate_surrogate_key(['l.recording_msid', 'l.user_name', 'cast(l.listened_at as string)']) }} as listen_id,
    u.user_sk,
    a.artist_sk,
    t.track_sk,
    d.date_sk,
    l.listened_at,
    l.tags
from listens l
left join dim_user   u on l.user_name      = u.user_name
left join dim_artist a on l.artist_msid    = a.artist_msid
left join dim_track  t on l.recording_msid = t.recording_msid
left join dim_date   d on {{ dbt_utils.generate_surrogate_key(['l.listen_date', 'l.listen_hour']) }} = d.date_sk