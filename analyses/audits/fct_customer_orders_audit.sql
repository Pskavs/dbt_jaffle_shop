--------------------------------------------------------
-------------- Row Count Comparison
--------------------------------------------------------

{% set old_relation = api.Relation.create(
    database=target.database,
    schema="dbt_christian",
    identifier="fct_orders"
) %}

{% set dbt_relation = ref('fct_customer_orders') %}

{{ audit_helper.compare_row_counts(
    a_relation=old_relation,
    b_relation=dbt_relation
) }}

--------------------------------------------------------
-------------- Column Comparison
--------------------------------------------------------

{% set old_query %}
    select *
    from {{ target.database }}.dbt_christian.customer_orders_legacy
{% endset %}

{% set new_query %}
    select *
    from {{ ref('fct_customer_orders') }}
{% endset %}

{{ audit_helper.compare_column_values(
    a_query=old_query,
    b_query=new_query,
    primary_key="order_id",
    column_to_compare="order_status"
) }}