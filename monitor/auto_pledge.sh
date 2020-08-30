#!/bin/bash
# nohup ./auto_pledge.sh >> pledge.log &
# 脚本所在目录创建sector_num.txt， 这里写上集群满负荷时所能处理的sectors数。
# 通过修改sector_num.txt中定义的数量，动态调整集群负载，从而找到一个平衡点。
set -x

while true
do
    worker_num=$(lotus-miner sealing workers |grep Worker|wc -l)
    worker_num=$(($worker_num - 1))
    need_sectors_num=$(cat sector_num.txt)
    working_sectors_num=$(lotus-miner sectors list|grep -v Failed|grep -v Proving|wc -l)
    
    if [ -z $working_sectors_num ];then
        working_sectors_num=0
    fi
    echo "The num of sealing sectors is: $working_sectors_num"
    
    if [[ $working_sectors_num -lt $need_sectors_num ]];then
        echo "pledge 1 sector now"
        lotus-miner sectors pledge
        sleep 600
    fi
    sleep 60
done
