{% macro clean_stale_models(database=target.database, query_date = '2026-03-30T01:10:00.295Z', dry_run = True) %}

  {% set get_drop_commands_query %}
    select
      'DROP ' ||
      case when table_type = 'VIEW' then 'VIEW' else 'TABLE' end ||
      ' {{ database | upper }}.' || table_schema || '.' || table_name || ';' as drop_query
    from {{ database }}.information_schema.tables
    where table_schema = upper('{{ schema }}')
      and date(last_altered) < date('{{query_date}}')
    order by table_name desc
  {% endset %}

  {{ log('\nGenerating cleanup queries...\n', info=True) }}
  {{ log(get_drop_commands_query, info=True) }}

  {% if execute %}
    {% set results = run_query(get_drop_commands_query) %}
    {% set drop_queries = results.columns[0].values() %}

    {{ log('\nFound ' ~ drop_queries | length ~ ' objects to drop\n', info=True) }}

    {% for query in drop_queries %}
    {% if dry_run %}
        {{ log(query, info=True) }}
    {% else %}
        {{ log ('Dropping object with command: ' ~ query, info=True)}}
        {% do run_query(query) %}
    {% endif %}
    {% endfor %}
  {% endif %}

{% endmacro %}