# hirid data - observation data

## HIRID Variables - SOFA calculation

- SOFA 所需的变量全部可得到，具体可参考 [Sepsis 3 Definition](https://www.notion.so/Sepsis-3-Definition-0b9e9618e7e3431aa4190b88aadf005b?pvs=21)
- pao2fio2ratio 和 GCS 两个变量需通过计算间接得到

## HIRID Variabes - PM_sepsis_shock_prediction

- **sepsis_shock_prediction** : age, gender, temperature, spo2, sbp, dbp, mbp, heart_rate, resp_rate, lactate, aniongap,wbc, bicarbonate, gcs_motor, gcs_verbal, gcs_eyes, inr, pt, ptt, baseexcess, po2, creatinine, potassium, ph, bun, glucose, totalco2, platelet, hematocrit, gcs, rbc, calcium, urineoutput
- **PM_sepsis_shock_prediction有hirid无**：aniongap, totalco2, hematocrit(红细胞比容)，rbc，gcs（通过计算可间接得到）

## Raw HIRID data processing

### （1）将250个大csv文件划分为以指标命名的小csv文件

`python $bin/step01_divideFile_by_var2.py /home/hanl/sepsis/00.data/HIRID_data/hirid_pre/observation_tables/csv/ $wd/var/`

- Input:
    
    (1) 需要切分csv所在的目录
    
    (2) 输出目录：xxxx/var/
    
- Output
    
    ![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled.png)
    

- [ ]  step02： 根据MIMIC所需的表转为字典格式即{表名1: [指标1，指标2.......], 表名2:[指标1，指标2.....]......}；表名形成目录，每个目录下存在一个 <表名_merge.txt>, 里面包括该表对应指标在step01输出目录中的所有路径
    
    `python $bin/step02_VarTabCombine.py $wd/input/varidx_varname.csv $wd/var $wd/tab`
    
    - Input
        
        （1）csv文件（两列）：varname，varid （存在一个name对应多个idx的现象）
        
        ![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled%201.png)
        
        （2）step01输出路径
        
        （3）输出目录：：xxxx/tab/
        
        （4）MIMIC所需的表的表头转成的字典格式: /input/mimi4_var.dict
        
    - output: 如下
        
        ![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled%202.png)
        
        ![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled%203.png)
        
- [ ]  step03
    
    `python $bin/step03_TabConvert.py $wd/tab/`
    
- [ ]  

### 1) INPUT 目录中的文件们

### 2) workshell

```bash
wd=/home/hanl/sepsis/00.data/HIRID_data/hirid/
bin=/home/hanl/sepsis/00.data/HIRID_data/bin/

###pre
#mkdir var tab

# file : varname varid
python $bin/get_var_NameID.py $wd/input/HIRID_var2idx.csv
# file : MIMIC4 tab var_list
/home/hanl/software/Python-3.7.4/bin/python3.7 $bin/get_FinalCsvHeader.py
python $bin/obser_var_stat.py $wd/input/MIMIC_output_demo/
python $bin/get_idName.py $wd/input/varidx_varname.csv

### deal
python $bin/step01_divideFile_by_var2.py /home/hanl/sepsis/00.data/HIRID_data/hirid_pre/observation_tables/csv/ $wd/var/
python $bin/step02_VarTabCombine.py $wd/input/varidx_varname.csv $wd/var/ $wd/tab/
python $bin/step03_TabConvert.py $wd/tab/
python $bin/step04_final_out_stat.py $wd/tab
```

## Raw data

### T1 - observation_tables_index

- 两列变量都需要

![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled%204.png)

### T2 - general_table

![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled%205.png)

![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled%206.png)

![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled%207.png)

## 数据整理

- 将目标MIMIC4中需要提取的表及其中的指标输出为字典

![Untitled](hirid%20data%20-%20observation%20data%207213755b0e23469a860afd5cfb625d69/Untitled%208.png)

-