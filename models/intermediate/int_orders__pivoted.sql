with payments as(
    
    SELECT *
    FROM {{ ref('stg_stripe__payment') }}
    WHERE PAYMENT_STATUS = 'success'
), pivoted as
(
    select 
    order_id,
    sum (case when payment_method = 'bank_transfer' then payment_amount else 0 end) as bank_transfer_amount
    from payments
    group by 1
)
select * from pivoted