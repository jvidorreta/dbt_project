with 

-- ######### SOURCES ########

STG_CUSTOMERS as (
    select * from {{ ref('stg_CUSTOMER') }}
),

STG_REGION as (
    select * from {{ ref('stg_REGION') }}
),

STG_NATION as (
    select * from {{ ref('stg_NATION') }}
),


-- ######### TRANSFORMATION ########







FINAL as (
    select * from STG_CUSTOMERS
)


-- ######### FINAL ########
select * from FINAL

