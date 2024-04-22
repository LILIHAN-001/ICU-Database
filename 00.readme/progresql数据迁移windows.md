#### ref

******

https://blog.51cto.com/u_15127544/4360400

https://blog.csdn.net/weixin_34112030/article/details/92389589



#### step

*********

- 打开服务（services），停止postgresql数据库服务
- 运行，输入regedit打开注册表，将HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\postgresql-x64-9.6中”-D“后的目录改为新的数据目录位置
- 将源数据data目录下的数据全部都拷贝到新的目录下
- 打开data目录下的postgresql.config文件，找到data_directory参数，修改为新的目录（没有验证过，反正设置就对了）
- 重启数据库服务







