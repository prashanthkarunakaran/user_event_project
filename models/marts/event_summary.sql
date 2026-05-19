{% set event_types = ['login', 'logout'] %}

SELECT

    USER_LOGIN,

    {% for event in event_types %}

    COUNT(
        CASE
            WHEN USER_EVENT = '{{ event }}'
            THEN 1
        END
    ) AS {{ event }}_count

    {% if not loop.last %},{% endif %}

    {% endfor %}

FROM {{ ref('stg_user_events') }}

GROUP BY USER_LOGIN