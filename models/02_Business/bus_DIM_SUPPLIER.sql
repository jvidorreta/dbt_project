{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########

STG_SUPPLIER as (
    select * from {{ ref('trs_DIM_SUPPLIER') }}
),


FINAL AS (
    select *
    ,{{ dbt_utils.surrogate_key(['SUPPLIER_KEY','SUPPLIER_NAME','SUPPLIER_ADDRESS']) }} as PK_DIM_SUPPLIER_BUS
    from STG_SUPPLIER
)


-- ######### FINAL ########
select * from FINAL