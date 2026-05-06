SELECT
    customer_id,
    order_date,
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'order_date']) }} as primary_key,
    count(*) as c
FROM {{ ref ('stg_jaffle_shop__orders')}}
GROUP BY 1,2