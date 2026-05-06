{% macro grant_select(schema = target.schema, role=target.role) %}

    {% set sql %}
        
        GRANT ALL PRIVILEGES
        ON FUTURE TABLES IN SCHEMA {{schema}}
        TO ROLE {{role}};
        GRANT ALL PRIVILEGES
        ON FUTURE VIEWS IN SCHEMA {{schema}}
        TO ROLE {{role}};

    {% endset %}
    {{ log ('Granting select on all tables and views in schema' ~ target.schema ~ 'to role '~ role, info=true)}}
    {% do run_query(sql)%}
    {{ log('Priveleges granted', info = true)}}
{% endmacro %}