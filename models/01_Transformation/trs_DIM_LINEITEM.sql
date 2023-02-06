{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########

STG_LINEITEM as (
    select * from {{ ref('stg_DIM_LINEITEM') }}
),

STG_PART as (
    select * from {{ ref('stg_DIM_PART') }}
),


STG_LINEITEM_ADD as (
    select 
    A.L_ORDERKEY AS ORDER_KEY
    ,A.L_PARTKEY AS PART_KEY
    ,B.P_NAME AS PART_KEY_NAME
    ,A.L_SUPPKEY AS SUPP_KEY
    ,A.L_LINENUMBER
    ,A.L_QUANTITY
    ,A.L_EXTENDEDPRICE
    ,A.L_DISCOUNT
    ,A.L_TAX
    ,A.L_SHIPINSTRUCT AS SHIP_INSTRUCT
    

   from STG_LINEITEM A, STG_PART B

   where PART_KEY = B.P_PARTKEY 
),

--############# FINAL ##############
FINAL as (
    SELECT * 
    ,{{ dbt_utils.surrogate_key(['ORDER_KEY','PART_KEY','SUPP_KEY','L_LINENUMBER']) }} as PK_DIM_LINEITEM_TRS
    FROM STG_LINEITEM_ADD    
)

select * from FINAL