#!/bin/bash
set -x

speed_rate=0.8
max_job_each=4


average_job_each=$(( $speed_rate*$max_job_each-1 ))

while true
do
    worker_num=$(lotus-miner sealing workers |grep Worker|wc -l)
    worker_num=$(($worker_num - 1))
    need_sectors_num=$(($average_job_each * $worker_num))
    working_sectors_num=$(lotus-miner sectors list|grep -v Failed|grep -v Proving|wc -l)
    if [ -z $working_sectors_num ];then
        working_sectors_num=0
    fi
    echo "The num of sealing sectors is: $working_sectors_num"

    miner_core=$(lotus-miner sealing workers|grep "CPU"|head -n1|tr -d -c '[0-9]'|tr -d [])
    if [[ $miner_core != 0 ]];then
            sleep 60
            continue
    fi

    if [[ $working_sectors_num < $need_sectors_num ]];then
        echo "pledge 1 sector now"
        lotus-miner sectors pledge
        sleep 600
    fi
done
