{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}

with

--###############  SOURCES  ####################
STG_CUSTOMERS as (
select * from {{ source('LND', 'DIM_CUSTOMER') }}

),


FINAL as (

select * 
        ,{{ dbt_utils.surrogate_key(['C_CUSTKEY', 'C_NAME']) }} as PK_DIM_CUSTOMER
from STG_CUSTOMERS
)

select * from FINAL