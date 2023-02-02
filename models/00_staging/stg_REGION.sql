with

--###############  SOURCES  ####################
STG_CUSTOMERS as (
select * from {{ source('TPCH_SF1', 'REGION') }}

),

FINAL as (

select * from STG_CUSTOMERS

)

select * from FINAL