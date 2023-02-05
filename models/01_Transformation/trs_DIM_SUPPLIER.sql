{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########

STG_SUPPLIER as (
    select * from {{ ref('stg_DIM_SUPPLIER') }}
),

STG_NATION as (
    select * from {{ ref('stg_DIM_NATION') }}
),

STG_REGION as (
    select * from {{ ref('stg_DIM_REGION') }}
),

-- ######### TRANSFORMATION ########
STG_SUPPLIER_2 as (
    select 
    A.S_SUPPKEY AS SUPPLIER_KEY
    ,A.S_NAME AS SUPPLIER_NAME
    ,A.S_ADDRESS AS SUPPLIER_ADDRESS
    ,B.N_NAME AS NATION
    ,C.R_NAME AS REGION
    ,A.S_PHONE AS SUPPLIER_PHONE
    ,A.S_ACCTBAL AS SUPPLIER_ACCOUNT_BALANCE
    
    from STG_SUPPLIER A,STG_NATION B,STG_REGION C
    where A.S_NATIONKEY = B.N_NATIONKEY AND B.N_REGIONKEY = C.R_REGIONKEY
),

FINAL as (
    select * 
    ,{{ dbt_utils.surrogate_key(['SUPPLIER_KEY','SUPPLIER_NAME','SUPPLIER_ADDRESS']) }} as PK_DIM_SUPPLIER_TRS
    from STG_SUPPLIER_2
)

-- ######### FINAL ########
select * from FINAL