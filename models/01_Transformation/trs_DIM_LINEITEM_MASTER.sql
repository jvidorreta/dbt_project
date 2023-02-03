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
    ,L_EXTENDEDPRICE * (1- L_DISCOUNT) AS FINAL_PRICE
    ,L_TAX*FINAL_PRICE AS TOTAL_TAX
   , FINAL_PRICE - TOTAL_TAX AS PROFIT
)

SELECT * FROM STG_LINEITEM_ADD
