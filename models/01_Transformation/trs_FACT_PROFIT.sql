{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########
TRS_ORDERS as (
    select * from {{ ref('trs_FACT_ORDERS') }}
),

TRS_LINEITEM as (
    select * from {{ ref('trs_DIM_LINEITEM') }}
),
-- ######### TRANSFORMATION ########
PROFIT as (
    select
    A.ORDER_KEY
    ,A.L_LINENUMBER
    ,A.L_QUANTITY
    ,A.L_EXTENDEDPRICE
    ,A.L_DISCOUNT
    ,A.L_TAX
    ,B.O_TOTALPRICE AS ORDER_TOTAL_PRICE
    ,ROUND(A.L_EXTENDEDPRICE * (1-A.L_DISCOUNT),2) AS DISCOUNT_PRICE
    ,ROUND(DISCOUNT_PRICE*(1+A.L_TAX),2) AS TOTAL_TAX
    ,ORDER_TOTAL_PRICE - TOTAL_TAX AS PROFIT

    from TRS_LINEITEM A,TRS_ORDERS B
    where A.ORDER_KEY = B.O_ORDERKEY
),

--############# FINAL ##############
FINAL as (
    SELECT * 
    ,{{ dbt_utils.surrogate_key(['ORDER_KEY','L_LINENUMBER','PROFIT']) }} as PK_FACT_PROFIT
    FROM PROFIT    
)

select * from FINAL