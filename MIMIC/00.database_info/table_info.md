### MIMIC

> MIMIC 发展
>
> - 2016.09：MIMIC II -> MIMIC III
>
> - 2018.06： MIMIC III V1.4 （2001.06-2012.10 38645 adult + 7875 newborn；住院资料 + 随访记录）
>
> - MIMIC IV

####

##### MIMIC 表信息

![image-20220129120928717](D:\MyDatabase\Typora-pic\image-20220129120928717.png)

##### 两套数据采集系统及预后

CareVue 记录的是 2001 至 2008 年入院的患者资料，病人的随访时间至少为**4 年**

Metavision 是 2008 至 2012 年期间入院的患者资料，病人的随访时间最少为**90 天**

##### 身份标识符

- subjects_id：患者身份 ID

- hadm_id: 住院 ID

- icustay_id: 进 ICU 的 ID

-

##### 时间

###### TAB - admission

- admittime，表示患者入院时间

- dischartime，表示患者出院时间

- deathtime，表示患者院内死亡的时间

###### TAB - icustays

- intime：前者表示进入 ICU 的时间

- outtime：后者表示离开 ICU 的时间

mimic 表格可视化

<https://www.heywhale.com/mw/project/5d9fe977037db3002d4159b4>
