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
        ,{{ dbt_utils.surrogate_key(['O_ORDERKEY','O_CUSTKEY','O_ORDERDATE','O_ORDERSTATUS','O_ORDERPRIORITY']) }} as PK_FACT_ORDER
from STG_FACT_ORDERS
)

select * from FINAL