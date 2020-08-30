#!/bin/bash
# nohup ./auto_pledge.sh >> pledge.log &
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
