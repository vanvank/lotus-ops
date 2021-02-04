这里记录一些分析调度用的脚本


# 这个命令行很有用，可以对 miner 中出现的 out of space 相关的 worker 及次数，进行统计。out of space 是 worker 不能接收任何工作任务的首要因素。
cat miner.log |grep -a "out of space "|awk '{print $8}'|sort -rn|uniq -c

# 统计worker报disabled的次数
cat miner.log |grep -a "trySchedMine skipping disabled worker "|awk '{print $9}'|sort -rn|uniq -c

# 查看某个扇区调度成功的情况
cat miner.log |grep s-t0XXX-2|grep success

# 查看一轮调度所用时间
cat miner.log |grep "trySchedMine SCHED"
