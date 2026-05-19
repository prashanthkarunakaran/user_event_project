WITH ranked_events AS (

    SELECT
        USER_LOGIN,
        USER_EVENT,
        EVENT_TIME,

        ROW_NUMBER() OVER (
            PARTITION BY USER_LOGIN
            ORDER BY EVENT_TIME DESC
        ) AS RN

    FROM {{ ref('stg_user_events') }}

)

SELECT

    {{ dbt_utils.generate_surrogate_key(['USER_LOGIN']) }} AS USER_SK,

    USER_LOGIN,
    USER_EVENT,
    EVENT_TIME AS UPDATED_AT

FROM ranked_events
WHERE RN = 1