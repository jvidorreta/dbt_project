{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with

--###############  SOURCES  ####################
STG_SUPPLIER as (
select * from {{ source('LND', 'DIM_SUPPLIER') }}

),

FINAL as (

select * 
        ,{{ dbt_utils.surrogate_key(['S_SUPPKEY','S_NAME','S_ADDRESS']) }} as PK_DIM_SUPPLIER
from STG_SUPPLIER
)

select * from FINAL