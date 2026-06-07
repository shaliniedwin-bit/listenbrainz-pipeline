with artists as (
    select
        artist_name,
        artist_msid,
        artist_mbids,
        row_number() over (
            partition by artist_msid
            order by artist_name asc
        ) as rn
    from {{ ref('stg_listens') }}
    where artist_name is not null
      and artist_msid is not null
)