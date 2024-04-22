**hanli 20220307**

____



> 成功可视化MIMIC 数据库后，接下来就是数据的处理。这里MIMIC也提供了一定的代码（concepts）以便研究者能更方便的使用。
>
> concepts配置的步骤可见“E:\MIMIC_III\mimic-code-main\mimic-iii\concepts” 的readme.md
>
> 且在阅读之前检查concepts目录下配置所需的两个必须文件：1）postgres-function.sql; 2) postgres_make_concepts_windows.bat



**README.md: Generating the concepts in PostgreSQL (Windows)**

___

#### step 1: Install the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

[(39条消息) WSL：在Windows下优雅地玩Linux_360技术-CSDN博客](https://blog.csdn.net/qihoo_tech/article/details/96538953)



#### step 2: Verify you can use the wsl.exe utilities in command prompt.

* Go to run and type `cmd`

* Run `wsl.exe echo "hi"` - this should print out `hi` back to you

  

#### step 3: Modify the .bat file

```bat
## bat文件中需要修改两处
REM ** YOU MUST SET THE PASSWORD BELOW **
# raw # SET "CONNSTR=postgresql://postgres:INSERT_PASSWORD_HERE@localhost:5432/mimic"
SET "CONNSTR=postgresql://postgres:hl416844@localhost:5432/mimiciii"


REM ** YOU MUST SET YOUR PSQL PATH BELOW **
# raw # SET "PSQL_PATH=C:\Program Files\PostgreSQL\13\bin\psql.exe"
SET "PSQL_PATH=D:\postgresql9.6\bin\psql.exe"


#####################
# REM 代表注释掉该行
```



#### step 4: run

- In the command prompt,` cd ..\concepts`
- type `postgres_make_concepts_windows.bat`



> 上次步骤基本可以完成concepts的配置，但我的bat文件在执行时经常出错（一次只能跑几行）。建议按需求选择性的去执行bat中的命令行。比如 身高体重这种基本信息的表格可以跑一下。



*********

配置完后，可以通过 1）修改concepts目录下其他文件的sql，2）自行敲码；来获取自己想要的的数据

![image-20220307145148810](F:\MyDatabase\Typora-pic\image-20220307145148810.png)