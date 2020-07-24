#!/bin/bash
# count num of sectors  and total size of dir:/lotus_data/.lotusworker/cache

set -x
max_job=2
while true;do
    cache_count=$(ls /lotus_data/.lotusworker/cache|wc -l)
    echo $(date)
    echo $cache_count
    worker_dir_size=$(du -sh /lotus_data/.lotusworker| awk '{print $1}')
    echo $worker_dir_size
    if [ $cache_count -gt $max_job ]
    then
        echo send message
        ./send_msg.sh "$HOSTNAME cache count: $cache_count, worker_repo size: $worker_dir_size"
        sleep 1800
    fi
echo ---
sleep 300
done
