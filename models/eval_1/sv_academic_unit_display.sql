{{ config(materialized='view') }}

select
    au.academic_unit_id id,
    au.name name,
    au.full_name path
  from
    {{ source('eval_king_data', 'academic_unit') }} au