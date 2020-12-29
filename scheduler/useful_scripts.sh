# 这个命令行很有用，可以对 miner 中出现的 out of space 相关的 worker 及次数，进行统计。out of space 是 worker 不能接收任何工作任务的首要因素。
cat miner.log |grep -a "out of space "|awk '{print $8}'|sort -rn|uniq -c

# 统计worker报disabled的次数
cat miner.log |grep -a "trySchedMine skipping disabled worker "|awk '{print $9}'|sort -rn|uniq -c

# 
