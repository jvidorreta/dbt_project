{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########

STG_CUSTOMERS as (
    select * from {{ ref('trs_DIM_CUSTOMER') }}
),


FINAL AS (
    select *
    ,{{ dbt_utils.surrogate_key(['CUSTOMER_KEY','CUSTOMER_NAME','CUSTOMER_ADDRESS']) }} as PK_DIM_CUSTOMER_BUS
    from STG_CUSTOMERS
)


-- ######### FINAL ########
select * from FINAL