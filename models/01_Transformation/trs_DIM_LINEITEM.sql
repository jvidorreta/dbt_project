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

STG_LINEITEM_ADD as (
    select 
    L_ORDERKEY
    ,L_PARTKEY
    ,L_SUPPKEY
    ,L_LINENUMBER
    ,L_QUANTITY
    ,L_EXTENDEDPRICE
    ,L_DISCOUNT
    ,L_TAX
    ,ROUND(L_EXTENDEDPRICE * (1- L_DISCOUNT),2) AS FINAL_PRICE
    ,ROUND(L_TAX*FINAL_PRICE,2) AS TOTAL_TAX
    ,FINAL_PRICE - TOTAL_TAX AS PROFIT
    ,{{ dbt_utils.surrogate_key(['L_ORDERKEY','L_PARTKEY']) }} as PK_DIM_LINEITEM_TRS
   from STG_LINEITEM
),

FINAL as (
    SELECT * FROM STG_LINEITEM_ADD    
)

select * from FINAL