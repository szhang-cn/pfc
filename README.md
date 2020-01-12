# 多晶石墨烯的PFC建模方法

将/bin/grpfc文件夹拷贝到用户主目录下，然后将run.sh（单节点占用建模）或grpfc.slm（多节点并行建模）拷贝到当前需建模的目录下，并修改模型尺寸和晶粒个数。

单节点建模
```
$ salloc -N 1     # 手动提交作业占用一个节点
$ squeue          # 查看节点名称
$ ssh ???         # 登录节点
$ sh run.sh       # 单节点运行建模
$ exit            # 退出节点
$ squeue          # 查看节点ID
$ scancel JOBID   # 取消作业，建模完毕
```

多节点并行建模
```
$ sbatch grpfc.slm     # 提交作业，运行建模
```
