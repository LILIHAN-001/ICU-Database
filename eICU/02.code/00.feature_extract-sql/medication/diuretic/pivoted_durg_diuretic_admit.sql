DROP TABLE IF EXISTS pivoted_durg_diuretic_admit CASCADE;
CREATE TABLE pivoted_durg_diuretic_admit AS
select * FROM admissiondrug
where LOWER(drugname ) LIKE  '%furosemide%'
OR LOWER(drugname ) LIKE  '%torsemide%'
OR LOWER(drugname ) LIKE  '%bumetanide%'
OR LOWER(drugname ) LIKE  '%diuretic%';