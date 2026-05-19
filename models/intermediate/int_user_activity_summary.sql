WITH user_events AS (

    SELECT *
    FROM {{ ref('stg_user_events') }}

)

SELECT
    USER_LOGIN,
    COUNT(*) AS TOTAL_EVENTS,
    MIN(EVENT_TIME) AS FIRST_ACTIVITY,
    MAX(EVENT_TIME) AS LAST_ACTIVITY

FROM user_events
GROUP BY USER_LOGIN