
--                                           1. antibiotic + culture + sofa                                     --
--
----------------------------------------------------------------------------------------------------------------------------
drop table if exists sepsis_eicu_antibiotic_culture_sofa;
create table sepsis_eicu_antibiotic_culture_sofa as
-- inspected infection + sofa >= 2 [T_insected infection - 2days, 1 day + T_insected infection]

with antibiotic_info_0 as (
  select patientunitstayid, drugstartoffset as antibiotic_offset
  from antibiotic_eicu
  union all
  select patientunitstayid, treatmentoffset as antibiotic_offset
  from treatment
  where (lower(treatmentstring) like '%antibiotic%'
  or lower(treatmentstring) like '%antibact%'
  or lower(treatmentstring) like '%antibio%'
  or lower(treatmentstring) like '%amika%'
  or lower(treatmentstring) like '%genta%'
  or lower(treatmentstring) like '%tobra%'
  or lower(treatmentstring) like '%cillin%'
  or lower(treatmentstring) like '%vanco%'
  or lower(treatmentstring) like '%cyclin%'
  or lower(treatmentstring) like '%xacin%'
  or lower(treatmentstring) like '%mycin%'
  or lower(treatmentstring) like '%metrondaz%'
  or lower(treatmentstring) like '%clavula%'
  or lower(treatmentstring) like '%tazob%'
  or lower(treatmentstring) like '%vancin%'
  or lower(treatmentstring) like '%penem%'
  or lower(treatmentstring) like '%micin%'
  or lower(treatmentstring) like '%cefur%'
  or lower(treatmentstring) like '%ceftri%'
  or lower(treatmentstring) like '%cephal%'
  )
)

, antibiotic_info as (
  select distinct *
  from antibiotic_info_0
  where patientunitstayid in (select patientunitstayid from sepsis_basic_eicu)
)

, culture_info as (
  select distinct patientunitstayid, treatmentoffset as culture_offset
  from treatment
  where patientunitstayid in (select patientunitstayid from sepsis_basic_eicu)
  and treatmentstring in (
    'infectious diseases|cultures / immuno-assays|cultures|BAL/PBS|bacterial'
    , 'infectious diseases|cultures / immuno-assays|cultures|catheter tip'
    , 'surgery|infection|cultures|sputum|fungal'
    , 'surgery|infection|cultures|sputum'
    , 'infectious diseases|cultures / immuno-assays|cultures|blood|drawn from central line'
    , 'surgery|infection|cultures|biopsy material'
    , 'surgery|infection|cultures|urine'
    , 'infectious diseases|cultures / immuno-assays|cultures|blood|peripheral'
    , 'infectious diseases|procedures|vascular catheter - removal|tip cultured'
    , 'infectious diseases|cultures / immuno-assays|cultures|BAL/PBS'
    , 'infectious diseases|cultures / immuno-assays|cultures|urine|suprapubic aspiration'
    , 'infectious diseases|cultures / immuno-assays|cultures|sputum|fungal'
    , 'infectious diseases|cultures / immuno-assays|cultures|pericardial fluid'
    , 'infectious diseases|cultures / immuno-assays|cultures|blood'
    , 'infectious diseases|cultures / immuno-assays|cultures|BAL/PBS|comprehensive (bacterial, viral, fungal, afb, etc.'
    , 'infectious diseases|cultures / immuno-assays|cultures|catheter tip|quantitative'
    , 'surgery|infection|cultures|blood|peripheral'
    , 'surgery|infection|cultures|urine|voided'
    , 'infectious diseases|cultures / immuno-assays|cultures|biopsy material'
    , 'surgery|infection|cultures|blood'
    , 'infectious diseases|procedures|vascular catheter - change|tip cultured'
    , 'infectious diseases|cultures / immuno-assays|cultures|CSF'
    , 'infectious diseases|cultures / immuno-assays|cultures|peritoneal fluid'
    , 'infectious diseases|cultures / immuno-assays|cultures|pleural fluid'
    , 'infectious diseases|cultures / immuno-assays|cultures|BAL/PBS|AFB'
    , 'infectious diseases|cultures / immuno-assays|cultures|sputum'
    , 'infectious diseases|cultures / immuno-assays|cultures|urine'
    , 'surgery|infection|cultures|surgical specimen'
    , 'infectious diseases|cultures / immuno-assays|cultures|urine|catheterized'
    , 'surgery|infection|cultures'
    , 'infectious diseases|cultures / immuno-assays|cultures|sputum|AFB'
    , 'infectious diseases|cultures / immuno-assays|cultures'
    , 'infectious diseases|cultures / immuno-assays|cultures|surgical specimen'
    , 'infectious diseases|cultures / immuno-assays|cultures|sputum|bacterial'
    , 'surgery|infection|cultures|sputum|AFB'
    , 'infectious diseases|cultures / immuno-assays|cultures|stool'
    , 'infectious diseases|cultures / immuno-assays|cultures|urine|voided'
  )
)

, infection_info_0 as (
  select patientunitstayid, antibiotic_offset as infection_offset
  from (
    select ai.patientunitstayid, ai.antibiotic_offset, ci.culture_offset
    from antibiotic_info ai
    inner join culture_info ci
    on ai.patientunitstayid = ci.patientunitstayid
    and ai.antibiotic_offset <= ci.culture_offset
    and ai.antibiotic_offset + 24*60 >= ci.culture_offset
  ) as ii0
  group by patientunitstayid, antibiotic_offset
)

, infection_info_1 as (
  select patientunitstayid, culture_offset as infection_offset
  from (
    select ci.patientunitstayid, ci.culture_offset, ai.antibiotic_offset
    from culture_info ci
    inner join antibiotic_info ai
    on ai.patientunitstayid = ci.patientunitstayid
    and ci.culture_offset <= ai.antibiotic_offset
    and ci.culture_offset + 3*24*60 >= ai.antibiotic_offset
  ) as ii1
  group by patientunitstayid, culture_offset
)

, infection_info_2 as (
  select distinct patientunitstayid, infection_offset
  from (
    select *
    from infection_info_0
    union all
    select *
    from infection_info_1    
  ) as ii2
)

, infection_info as (
  select ii.patientunitstayid, ii.infection_offset
  , (ii.infection_offset - 48*60) as startoffsetwd
  , (ii.infection_offset + 24*60) as endoffsetwd
  , icud.unitdischargeoffset  
  from infection_info_2 ii 
  inner join icustay_detail icud
  on ii.patientunitstayid = icud.patientunitstayid
)

, sepsis_onset_part10 as (
  select di.*, sf.hr
  , ROW_NUMBER() OVER (PARTITION BY di.patientunitstayid ORDER BY sf.hr) as rn
  from infection_info di
  inner join pivoted_sofa_eicu sf
  on di.patientunitstayid = sf.patientunitstayid
  and sf.hr <= di.endoffsetwd/60
  and sf.hr >= di.startoffsetwd/60
  and sf.SOFA_24hours >= 2
)

select *
from sepsis_onset_part10 sop
WHERE rn=1
order by sop.patientunitstayid


