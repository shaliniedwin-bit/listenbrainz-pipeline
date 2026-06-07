with tracks as (
    select
        track_name,
        recording_msid,
        recording_mbid,
        row_number() over (
            partition by recording_msid
            order by track_name asc
        ) as rn
    from {{ ref('stg_listens') }}
    where track_name  is not null
      and recording_msid is not null
)