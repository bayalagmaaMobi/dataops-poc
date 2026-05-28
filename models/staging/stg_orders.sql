with source as (
    select * from {{ ref('orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        amount,
        lower(status)             as status,
        cast(order_date as date)  as order_date,
        case
            when status = 'completed' then amount
            else 0
        end                       as revenue
    from source
)

select * from renamed
-- test: approval requirement check
