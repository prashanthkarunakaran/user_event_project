{% snapshot snap_user_events %}

{{
    config(
      target_database='AGS_GAME_AUDIENCE',
      target_schema='SNAPSHOTS',

      unique_key='USER_LOGIN',

      strategy='timestamp',

      updated_at='UPDATED_AT'
    )
}}

SELECT
    USER_LOGIN,
    USER_EVENT,
    UPDATED_AT

FROM {{ ref('dim_users') }}

{% endsnapshot %}