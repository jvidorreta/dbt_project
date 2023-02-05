{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########

STG_ORDERS as (
    select * from {{ ref('trs_FACT_ORDERS') }}
),


FINAL AS (
    select *
    ,{{ dbt_utils.surrogate_key(['O_ORDERKEY','O_CUSTKEY','O_ORDERDATE','O_ORDERSTATUS','O_ORDERPRIORITY']) }} as PK_FACT_ORDERS_BUS
    from STG_ORDERS
)


-- ######### FINAL ########
select * from FINAL