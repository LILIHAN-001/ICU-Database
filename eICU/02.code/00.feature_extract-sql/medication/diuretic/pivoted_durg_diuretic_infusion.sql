DROP TABLE IF EXISTS pivoted_durg_diuretic_infusion CASCADE;
CREATE TABLE pivoted_durg_diuretic_infusion AS
select DISTINCT drugname FROM infusiondrug
where LOWER(drugname ) LIKE  '%furosemide%'
OR LOWER(drugname ) LIKE  '%torsemide%'
OR LOWER(drugname ) LIKE  '%bumetanide%'
OR LOWER(drugname ) LIKE  '%diuretic%';