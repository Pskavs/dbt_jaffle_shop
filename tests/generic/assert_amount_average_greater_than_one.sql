{% test assert_amount_average_greater_than_one(model, column_name) %}
select
    customer_id,
    avg({{ column_name }}) as average_amount
from {{ model }}
group by customer_id
having count(*) > 1 and avg({{ column_name }}) < 1
{% endtest %}