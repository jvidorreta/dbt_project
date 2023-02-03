{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with

--###############  SOURCES  ####################
STG_PARTSUPP as (
select * from {{ source('LND', 'DIM_PARTSUPP') }}

),

FINAL as (

select * 
        ,{{ dbt_utils.surrogate_key(['PS_PARTKEY','PS_SUPPKEY','PS_SUPPLYCOST']) }} as PK_DIM_PARTSUPP
from STG_PARTSUPP
)

select * from FINAL