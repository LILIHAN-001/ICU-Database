DROP TABLE IF EXISTS aumcdbv102.sedation_and_analgesia; CREATE TABLE aumcdbv102.sedation_and_analgesia AS 

with sedatiom_item_id as
 (select DISTINCT  itemid, item from drugitems --  admissionid, itemid,item, administered ,administeredunit
where 
  Lower(item) like '%lorazepam%' OR 
  Lower(item) like '%midazolam%' or 
  Lower(item) like  '%propofol%' or 
  Lower(item) like  '%dexmedetomidine%' or 
  Lower(item) like  '%fentanyl%' or 
  Lower(item) like  '%morphine%' or 
	Lower(item) like  '%morfine%' or 
  Lower(item) like  '%hydromorphone%' or 
  Lower(item) like  '%acetaminophen%' or
	Lower(item) like  '%paracetamol%' -- acetaminophen
	)
	
	SELECT * FROM drugitems
	where itemid in (select itemid from sedatiom_item_id)