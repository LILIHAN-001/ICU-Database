##### 本地构建 MIMIC III V1.4

本地配置MIMIC III参考视频：https://www.bilibili.com/video/BV1Zt411n7K4?t=602

MIMIC 官网：https://physionet.org/content/mimiciii/1.4/

MIMIC 数据库表格介绍：https://mimic.mit.edu/docs/iii/tables/

MIMIC数据库本地配置 数据+代码：可参考视频



压缩包内容：（1）postgres 和 Navicat 安装包； （2）MIMIC III 本地配置代码； 

> 数据包大概需要50-60G的空间，无法在weixin中分享。如果想自己研究一下MIMIC III数据库（50-60G），可自行在官网下载或拿U盘找我（111办公室）拷。



********

###### step 1 ： postgres download（选择Version 9.6.18即可）

###### step 2 ： MIMIC 数据包和官网安装代码下载（参考视频）

###### step 3 ： 将MIMIC 数据导入postgres

```sql
### MIMIC III

DROP DATABASE IF EXISTS mimic;
CREATE DATABASE mimic OWNER postgres;
\c mimic;
CREATE SCHEMA mimiciii;
set search_path to mimiciii;

\i E:/MIMIC_III/mimic_code/mimic-code-master_Mimic_III/mimic-code-master/buildmimic/postgres/postgres_create_tables.sql
\set ON_ERROR_STOP 1
\set mimic_data_dir 'E:/MIMIC_III/mimic-iii-clinical-database-1.4'
 
\i E:/MIMIC_III/mimic_code/mimic-code-master_Mimic_III/mimic-code-master/buildmimic/postgres/postgres_load_data.sql

\i E:/MIMIC_III/mimic_code/mimic-code-master_Mimic_III/mimic-code-master/buildmimic/postgres/postgres_add_indexes.sql
\i E:/MIMIC_III/mimic_code/mimic-code-master_Mimic_III/mimic-code-master/buildmimic/postgres/postgres_add_indexes.sql
```

```sql
### MIMIC IV
DROP DATABASE IF EXISTS mimiciv_v1;

CREATE DATABASE mimiciv_v1 OWNER postgres;

\c mimiciv_v1;
\i E:/MIMIC_IV/mimic-code-main/mimic-code-main/mimic-iv/buildmimic/postgres/create.sql

\set ON_ERROR_STOP 1

\set mimic_data_dir 'E:/MIMIC_IV/mimic-iv-1.0'

\encoding 'UTF8'

\i E:/MIMIC_IV/mimic-code-main/mimic-code-main/mimic-iv/buildmimic/postgres/load_7z.sql

```

```sql
### eICU

DROP DATABASE IF EXISTS eicu;
CREATE DATABASE eicu OWNER postgres;
\c eicu;
CREATE SCHEMA eicuv2;
set search_path to eicuv2;

\i E:/eICU/eicu-code-master/eicu-code-master/build-db/postgres/postgres_create_tables.sql
\set ON_ERROR_STOP 1
\set datadir 'E:/eICU/eicu_unzip'
\i E:/eICU/eicu-code-master/eicu-code-master/build-db/postgres/postgres_load_data.sql
\i E:/eICU/eicu-code-master/eicu-code-master/build-db/postgres/postgres_add_indexes.sql
\i E:/eICU/eicu-code-master/eicu-code-master/build-db/postgres/postgres_checks.sql

```

```bash
### AUMCdb

DROP DATABASE IF EXISTS aumcdb;
CREATE DATABASE aumcdb OWNER postgres;
\c aumcdb;
CREATE SCHEMA aumcdbV102;
set search_path to aumcdbV102;

\i E:/AUMCdb/AmsterdamUMCdb-master/setup-amsterdamumcdb/postgres/postgres-create-tables.sql
\set ON_ERROR_STOP 1
\set data_dir 'E:/AUMCdb/AmsterdamUMCdb-v1.0.2'

\i E:/AUMCdb/AmsterdamUMCdb-master/setup-amsterdamumcdb/postgres/postgres-load-data-csv.sql
\i E:/AUMCdb/AmsterdamUMCdb-master/setup-amsterdamumcdb/postgres/postgres-create-index.sql

```



###### step 4 ： Navicat 可视化工具下载

https://www.cnblogs.com/laoshuai/p/13517172.html

###### step 5 ：数据导入Navicat

https://jingyan.baidu.com/article/642c9d34ea3ada644a46f7ad.html

