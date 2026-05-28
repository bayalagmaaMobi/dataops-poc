with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customer_orders as (
    select
        customer_id,
        count(order_id)           as total_orders,
        sum(revenue)              as total_spent,
        min(order_date)           as first_order_date,
        max(order_date)           as last_order_date
    from orders
    group by 1
),

final as (
    select
        c.customer_id,
        c.customer_name,
        c.email,
        c.plan,
        c.is_paid,
        c.signup_date,
        coalesce(o.total_orders, 0)    as total_orders,
        coalesce(o.total_spent, 0)     as total_spent,
        o.first_order_date,
        o.last_order_date
    from customers c
    left join customer_orders o using (customer_id)
)

select * from final
