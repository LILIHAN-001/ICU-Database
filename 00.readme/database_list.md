AUMCdb：

<https://github.com/AmsterdamUMC/AmsterdamUMCdb/wiki>

MIMIC:

<https://github.com/MIT-LCP/mimic-iv>

<https://github.com/MIT-LCP/mimic-code>

eicu：

<https://github.com/MIT-LCP/eicu-code>

```python
# 查看指标索引
import amsterdamumcdb as a_db
df_dict = a_db.get_dictionary()
df_dict.colname.str.contains("某字符串0 | 某字符串1",case = False)
```
