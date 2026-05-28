with source as (
    select * from {{ ref('events') }}
),

renamed as (
    select
        event_id,
        customer_id,
        lower(event_type)          as event_type,
        cast(event_date as date)   as event_date
    from source
)

select * from renamed
