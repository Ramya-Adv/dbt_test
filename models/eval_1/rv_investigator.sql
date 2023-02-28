{{ config(materialized='view') }}

select
    c.contact_id,
    c.first_name,
    c.middle_name,
    c.last_name,
    c.email,
    c.organization_id,
    o.name as organization_name,
    i.investigator_id,
    i.primary_department_id,
    aud.path as primary_department_full_name,
    i.gender_id,
    g.name as gender,
    i.ethnicity_id,
    e.name as ethnicity,
    i.date_of_birth,
    i.disabled as disabled_enum,
    i.disadvantaged as disadvantaged_enum,
    ip.start_date as pubmed_search_start_date,
    ip.end_date as pubmed_search_end_date
from
    {{ source('eval_king_data', 'investigator') }} i
    join {{ source('eval_king_data', 'contact') }} c on i.contact_id = c.contact_id
    join {{ source('eval_king_data', 'organization') }} o on c.organization_id = o.organization_id
    join {{ source('eval_king_data', 'investigator_pubmed') }} ip on i.investigator_id = ip.investigator_id
    left join {{ ref('sv_academic_unit_display') }} aud on i.primary_department_id = aud.id
    left join {{ source('eval_king_data', 'gender') }} g on i.gender_id = g.gender_id
    left join {{ source('eval_king_data', 'ethnicity') }} e on i.ethnicity_id = e.ethnicity_id