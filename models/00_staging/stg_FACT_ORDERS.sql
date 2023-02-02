with

--###############  SOURCES  ####################
STG_CUSTOMERS as (
select * from {{ source('LND', 'FACT_ORDERS') }}

),

FINAL as (

select * from STG_CUSTOMERS

)

select * from FINAL