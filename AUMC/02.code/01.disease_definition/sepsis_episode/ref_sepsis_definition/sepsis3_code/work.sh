##
python reason_for_admission.py
python sepsis3_amsterdamumcdb.py
python sepsis_comparison.py
cut -f 1,2,3,7 -d ',' ../../data/additional_files/sepsis3.csv | grep "True"  | awk -F , '$2<maxvals[$1] {lines[$1]=$0; maxvals[$1]=$2} END {for (tag in lines) print lines[tag] }' | awk -F , '{if ($2<=0) $2="0"}1' | sed 's/ /,/g' | awk -F , 'BEGIN{print "admissionid,sofa_time"}{print $1","$2}' > sepsis_cutf.csv

date


