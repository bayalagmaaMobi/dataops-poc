with orders as (
    select * from {{ ref('stg_orders') }}
),

monthly as (
    select
        date_trunc('month', order_date)   as month,
        count(order_id)                   as total_orders,
        count(case when status = 'completed'  then 1 end) as completed_orders,
        count(case when status = 'refunded'   then 1 end) as refunded_orders,
        count(case when status = 'cancelled'  then 1 end) as cancelled_orders,
        sum(revenue)                      as total_revenue
    from orders
    group by 1
)

select * from monthly
order by month
