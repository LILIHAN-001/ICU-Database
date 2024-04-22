select patientunitstayid, drugstartoffset, drugstopoffset,  drugname, dosage from medication --   -= DISTINCT  drugname
where 
  Lower(drugname) like '%lorazepam%' OR 
  Lower(drugname) like '%midazolam%' or 
  Lower(drugname) like  '%propofol%' or 
  Lower(drugname) like  '%dexmedetomidine%' or 
  Lower(drugname) like  '%fentanyl%' or 
  Lower(drugname) like  '%morphine%' or 
  Lower(drugname) like  '%hydromorphone%' or 
  Lower(drugname) like  '%acetaminophen%' 