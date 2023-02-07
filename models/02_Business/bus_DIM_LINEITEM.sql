{{
    config(
        database= 'DBT_ACADEMY_PROJECT'
    )
}}
with 

-- ######### SOURCES ########

STG_LINEITEM as (
    select * from {{ ref('trs_DIM_LINEITEM') }}
),


FINAL AS (
    select *
    ,{{ dbt_utils.surrogate_key(['ORDER_KEY','PART_KEY','SUPP_KEY','L_LINENUMBER']) }} as PK_DIM_LINEITEM_BUS
    from STG_LINEITEM
)


-- ######### FINAL ########
select * from FINAL