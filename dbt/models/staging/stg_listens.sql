with source as (
    select * from {{ source('listenbrainz_raw', 'raw_listens') }}
),

cleaned as (
    select
        -- identifiers
        recording_msid,
        recording_mbid,
        artist_msid,
        artist_mbids,
        release_msid,
        release_mbid,

        -- text fields (cleaned)
        lower(trim(user_name))      as user_name,
        trim(track_name)            as track_name,
        trim(artist_name)           as artist_name,
        trim(release_name)          as release_name,
        tags,

        -- timestamp
        listened_at,

        -- derived date parts
        date(listened_at)                        as listen_date,
        extract(year  from listened_at)          as listen_year,
        extract(month from listened_at)          as listen_month,
        extract(day   from listened_at)          as listen_day,
        extract(hour  from listened_at)          as listen_hour,
        format_timestamp('%A', listened_at)      as day_of_week,

        -- row number for deduplication
        row_number() over (
            partition by recording_msid, user_name, listened_at
            order by listened_at
        ) as row_num

    from source
    where listened_at is not null
      and user_name   is not null
      and track_name  is not null
)

select * from cleaned
where row_num = 1