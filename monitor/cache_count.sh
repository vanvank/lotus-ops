#!/bin/bash

max_job=8

while true;do
    date
    echo ---begin---------------------------------------------------------------------------
    cache_count=$(ls $WORKER_PATH/cache|grep ^s|wc -l)
    echo "cache count: $cache_count"
    du -sh $WORKER_PATH/cache/*
    echo ---
    du -sh $WORKER_PATH/unsealed/*
    echo ---
    du -sh $WORKER_PATH/sealed/*
    echo ---
    du -sh $WORKER_PATH/*
    worker_dir_size=$(du -sh $WORKER_PATH| awk '{print $1}')
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
