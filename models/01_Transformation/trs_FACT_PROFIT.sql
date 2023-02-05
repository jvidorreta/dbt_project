{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########
TRS_ORDERS as (
    select * from {{ ref('trs_FACT_ORDER') }}
),
 
TRS_LINEITEM as (
    select * from {{ ref('trs_DIM_LINEITEM') }}
) 
-- ######### TRANSFORMATION ########