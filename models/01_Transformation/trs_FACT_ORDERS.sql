{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########
STG_ORDERS as (
    select * from {{ ref('stg_FACT_ORDER') }}
),

-- ######### TRANSFORMATION ########
