{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with

--###############  SOURCES  ####################
STG_NATION as (
select * from {{ source('LND', 'DIM_NATION') }}

),

FINAL as (

select * 
        ,{{ dbt_utils.surrogate_key(['N_NATIONKEY','N_REGIONKEY']) }} as PK_DIM_NATION
from STG_NATION
)

select * from FINAL