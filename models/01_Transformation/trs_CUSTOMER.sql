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
    C_CUSTKEY as CUSTOMER_KEY
    ,C_NAME as CUSTOMER_NAME
    ,C_ADDRESS as CUSTOMER_ADDRESS
    ,C_NATIONKEY as CUSTOMER_NATIONKEY
    ,C_MKTSEGMENT as CUSTOMER_MARKETSEGMENT
    ,C_NAME as CUSTOMER_NAME
    --,{{ dbt_utils.surrogate_key(['VERSION_CODE','YEAR_MONTH' ,'YEAR_MONTH_ORI','ORDER_NUMBER' ,'STATU','EBELP' ,'VGABE','FRGET','NAME_CC','TYPE' ,'ORI','POSID','COSTCENTER_CODE','WAERS_DC']) }} as PK_FACT_PO_STATUS

from STG_CUSTOMERS    
),






FINAL as (
    select * from STG_CUSTOMERS_WO_COLUMNS
)


-- ######### FINAL ########
select * from FINAL


