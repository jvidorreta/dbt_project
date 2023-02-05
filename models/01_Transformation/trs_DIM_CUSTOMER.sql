{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########

STG_CUSTOMERS as (
    select * from {{ ref('stg_DIM_CUSTOMER') }}
),

STG_REGION as (
    select * from {{ ref('stg_DIM_REGION') }}
),

STG_NATION as (
    select * from {{ ref('stg_DIM_NATION') }}
),


-- ######### TRANSFORMATION ########
STG_CUSTOMERS_WO_COLUMNS as (
    select
    A.C_CUSTKEY AS CUSTOMER_KEY
    ,A.C_NAME AS CUSTOMER_NAME
    ,A.C_ADDRESS AS CUSTOMER_ADDRESS
    ,A.C_PHONE AS CUSTOMER_PHONE
    ,B.N_NAME AS NATION
    ,C.R_NAME AS REGION
    ,A.C_MKTSEGMENT AS MARKET_SEGMENT

from STG_CUSTOMERS A, STG_NATION B, STG_REGION C  
where A.C_NATIONKEY = B.N_NATIONKEY AND B.N_REGIONKEY = C.R_REGIONKEY 
),




FINAL as (
    select * 
    ,{{ dbt_utils.surrogate_key(['CUSTOMER_KEY','CUSTOMER_NAME','CUSTOMER_ADDRESS']) }} as PK_DIM_CUSTOMER_TRS
    from STG_CUSTOMERS_WO_COLUMNS
)


-- ######### FINAL ########
select * from FINAL


