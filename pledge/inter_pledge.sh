#!/bin/bash
# nohup ./inter_pledge.sh >> pledge.log &
# min.txt 中放你希望多少秒pledge一个，比如300，就是300秒pledge一次
set -x

while true
do
    min=`cat min.txt`
    echo "pledge 1 sector noww"
    date
    lotus-miner sectors pledge
    sleep  $min
done
