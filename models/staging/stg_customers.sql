with source as (
    select * from {{ ref('customers') }}
),

renamed as (
    select
        customer_id,
        name                          as customer_name,
        lower(email)                  as email,
        country,
        cast(signup_date as date)     as signup_date,
        plan,
        case
            when plan = 'pro'  then true
            when plan = 'free' then false
        end                           as is_paid
    from source
)

select * from renamed
-- demo change: confirm pipeline runs on PR
