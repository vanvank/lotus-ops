#!/bin/bash
set -x

i=0
max=120
while true
do
    echo "pledge 1 sector now"
    date
    lotus-miner sectors pledge
    i=$((i+1))
    echo $i
    sleep  480
    if [ $i -gt $max ];then
            break
    fi
done
