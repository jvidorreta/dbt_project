{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########
STG_ORDERS as (
    select * from {{ ref('stg_FACT_ORDER') }}
),
 
-- ######### TRANSFORMATION ########
STG_ORDERS_ADD as (
    select
    O_ORDERKEY
    ,O_CUSTKEY
    ,O_ORDERSTATUS
    ,O_TOTALPRICE
    ,O_ORDERDATE
    ,O_ORDERPRIORITY    
    ,O_CLERK
    ,O_SHIPPRIORITY

    from STG_ORDERS
),

FINAL as (
    select * 
    ,{{ dbt_utils.surrogate_key(['O_ORDERKEY','O_CUSTKEY','O_ORDERDATE','O_ORDERSTATUS','O_ORDERPRIORITY']) }} as PK_FACT_ORDERS_TRS
    from STG_ORDERS_ADD
)

--############# FINAL ##############
select * from FINAL 