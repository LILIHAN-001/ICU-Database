-- Fentanyl 镇痛
-- hydromorphone
-- acetaminophen-IV
-- Morphine_Sulfate

-- dexmedetomidine 镇静
-- Midazolam 镇静
-- Propofol 镇静
-- Lorazepam
DROP TABLE IF EXISTS mimic_icu.sedation_and_analgesia; CREATE TABLE mimic_icu.sedation_and_analgesia AS 

with seda_itemid as (
select * from d_items
 where (lower(label) like '%fentanyl%')  OR (lower(label)  like '%hydromorphone%') OR (lower(label)  like '%acetaminophen%') OR (lower(label)  like '%morphine%')  OR (lower(label)  like '%dexmedetomidine%') OR (lower(label)  like '%midazolam%')  OR (lower(label) like '%propofol%')  OR (lower(label) like '%lorazepam%'))
 
select * from inputevents
where itemid in (SELECT itemid from seda_itemid)