#!/bin/bash
# count num of sectors  and total size of dir:/lotus_data/tmp/

#set -x
max_job=1
bench_tmp=`ls /lotus_data/tmp/`
cache_dir="/lotus_data/tmp/$bench_tmp/cache/"
worker_dir="/lotus_data/tmp/$bench_tmp"


while true;do
    date
    echo ---begin---------------------------------------------------------------------------
    cache_count=$(ls $cache_dir|wc -l)
    echo "cache count: $cache_count"
    du -sh /lotus_data/tmp/$bench_tmp/cache/*
    echo ---
    du -sh /lotus_data/tmp/$bench_tmp/unsealed/*
    echo ---
    du -sh /lotus_data/tmp/$bench_tmp/sealed/*
    echo ---
    du -sh /lotus_data/tmp/$bench_tmp/*
    worker_dir_size=$(du -sh $worker_dir| awk '{print $1}')
    echo "total: $worker_dir_size"
    uptime
    free -h
    #if [ $cache_count -gt $max_job ]
    #then
    #    echo send message
        #./send_msg.sh "$HOSTNAME cache count: $cache_count, worker_repo size: $worker_dir_size"
    #    sleep 1800
    #fi
    echo ---end--------------------------------------------------------------------------------
    sleep 300
done
