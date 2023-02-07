{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with

--###############  SOURCES  ####################
STG_PART as (
select * from {{ source('LND', 'DIM_PART') }}

),

FINAL as (

select * 
        ,{{ dbt_utils.surrogate_key(['P_PARTKEY','P_NAME','P_MFGR']) }} as PK_DIM_PART
from STG_PART
)

select * from FINAL