DROP TABLE IF EXISTS mimic_icu.diuretic; CREATE TABLE mimic_icu.diuretic AS 

with diuretic_itemid as (
select * from d_items
 where (lower(label) like '%urosemide%')  OR (lower(label)  like '%lasix%') OR (lower(label)  like '%diuretic%') OR (lower(label)  like '%torsemide%')  OR (lower(label)  like '%bumetanide%') OR (lower(label)  like '%ethacrynic%')  OR (lower(label) like '%mannitol%') )
 
select * from inputevents
where itemid in (SELECT itemid from diuretic_itemid)