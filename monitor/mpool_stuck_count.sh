#!/bin/bash
set -x
while true
do
time=`date`
count=`lotus mpool pending --local|grep Nonce|wc -l`
msg="$time lotus mpool stuck message count: $count"
./send_msg.sh "$msg"
sleep 1800
done
