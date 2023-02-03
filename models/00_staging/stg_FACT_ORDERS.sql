{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with

--###############  SOURCES  ####################
STG_FACT_ORDERS as (
select * from {{ source('LND', 'FACT_ORDERS') }}

),

FINAL as (

select * 
        ,{{ dbt_utils.surrogate_key(['O_ORDERKEY','O_CUSTKEY','O_ORDERDATE','O_ORDERSTATUS']) }} as PK_DIM_CUSTOMER
from STG_FACT_ORDERS
)

select * from FINAL