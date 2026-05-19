SELECT *

FROM {{ ref('stg_user_events') }}

WHERE USER_EVENT = '{{ var("event_filter") }}'