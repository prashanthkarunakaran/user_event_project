SELECT

    ROW_NUMBER() OVER (
        ORDER BY RAW_DATA:datetime_iso8601::TIMESTAMP
    ) AS EVENT_ID,

    RAW_DATA:datetime_iso8601::TIMESTAMP AS EVENT_TIME,
    RAW_DATA:ip_address::STRING AS IP_ADDRESS,
    RAW_DATA:user_event::STRING AS USER_EVENT,
    RAW_DATA:user_login::STRING AS USER_LOGIN,

    e.EVENT_DESCRIPTION,

    {{ get_current_timestamp() }} AS LOAD_TIMESTAMP

FROM {{ source('raw', 'USER_EVENTS_RAW') }} r

LEFT JOIN {{ ref('event_lookup') }} e
    ON RAW_DATA:user_event::STRING = e.EVENT_TYPE