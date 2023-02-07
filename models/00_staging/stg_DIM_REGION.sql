{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with

--###############  SOURCES  ####################
STG_REGION as (
select * from {{ source('LND', 'DIM_REGION') }}

),

FINAL as (

select * 
        ,{{ dbt_utils.surrogate_key(['R_REGIONKEY','R_NAME']) }} as PK_DIM_REGION
from STG_REGION
)

select * from FINAL