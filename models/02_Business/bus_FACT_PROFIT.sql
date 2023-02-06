{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########

STG_PROFIT as (
    select * from {{ ref('trs_FACT_PROFIT') }}
),


FINAL AS (
    select *
    ,{{ dbt_utils.surrogate_key(['ORDER_KEY','L_LINENUMBER','PROFIT']) }} as PK_FACT_PROFIT_BUS
    from STG_PROFIT
)


-- ######### FINAL ########
select * from FINAL