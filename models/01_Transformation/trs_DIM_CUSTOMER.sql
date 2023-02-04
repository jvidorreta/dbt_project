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
    C_CUSTKEY 
    ,C_NAME 
    ,C_ADDRESS 
    ,C_NATIONKEY 
    ,C_MKTSEGMENT 
    ,C_NAME 


from STG_CUSTOMERS    
),


STG_REGION_WO_COLUMNS as (
    select
    C_CUSTKEY as CUSTOMER_KEY
    ,C_NAME as CUSTOMER_NAME
    ,C_ADDRESS as CUSTOMER_ADDRESS
    ,C_NATIONKEY as CUSTOMER_NATIONKEY
    ,C_MKTSEGMENT as CUSTOMER_MARKETSEGMENT
    ,C_NAME as CUSTOMER_NAME


from STG_REGION  
),



FINAL as (
    select * 
    ,{{ dbt_utils.surrogate_key(['']) }} as PK_DIM_CUSTOMER
    from STG_CUSTOMERS_WO_COLUMNS
)


-- ######### FINAL ########
select * from FINAL


