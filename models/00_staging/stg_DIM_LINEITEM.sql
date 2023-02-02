with

--###############  SOURCES  ####################
STG_CUSTOMERS as (
select * from {{ source('LND', 'DIM_LINEITEM') }}

),

FINAL as (

select * from STG_CUSTOMERS

)

select * from FINAL