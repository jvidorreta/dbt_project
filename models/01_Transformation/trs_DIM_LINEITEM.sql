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
    ,ROUND(A.L_EXTENDEDPRICE * (1- A.L_DISCOUNT),2) AS FINAL_PRICE
    ,ROUND(A.L_TAX*FINAL_PRICE,2) AS TOTAL_TAX
    ,FINAL_PRICE - TOTAL_TAX AS PROFIT
    

   from STG_LINEITEM A, STG_PART B

   where PART_KEY = B.P_PARTKEY 
),

FINAL as (
    SELECT * 
    ,{{ dbt_utils.surrogate_key(['ORDER_KEY','PART_KEY']) }} as PK_DIM_LINEITEM_TRS
    FROM STG_LINEITEM_ADD    
)

select * from FINAL