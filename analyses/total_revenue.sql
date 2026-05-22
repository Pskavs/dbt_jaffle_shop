SELECT sum(payment_amount) FROM {{ ref('stg_payments') }}
WHERE payment_status = 'success'
