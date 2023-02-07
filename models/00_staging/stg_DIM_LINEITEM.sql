{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with

--###############  SOURCES  ####################
STG_LINEITEM as (
select * from {{ source('LND', 'DIM_LINEITEM') }}

),

FINAL as (

select * 
        ,{{ dbt_utils.surrogate_key(['L_ORDERKEY','L_PARTKEY','L_SUPPKEY','L_LINENUMBER']) }} as PK_DIM_LINEITEM
from STG_LINEITEM
)

select * from FINAL