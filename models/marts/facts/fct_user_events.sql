{{
    config(
        materialized='incremental',
        unique_key='EVENT_ID'
    )
}}

SELECT

    EVENT_ID,
    USER_LOGIN,
    USER_EVENT,
    EVENT_TIME,
    EVENT_DESCRIPTION,
    LOAD_TIMESTAMP

FROM {{ ref('stg_user_events') }}

{% if is_incremental() %}

WHERE EVENT_TIME >

(
    SELECT MAX(EVENT_TIME)
    FROM {{ this }}
)

{% endif %}