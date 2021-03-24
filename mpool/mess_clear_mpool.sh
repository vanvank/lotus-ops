#!/bin/bash
set -x 

count=`lotus mpool pending --local|grep Nonce|wc -l`
echo "总共卡住的消息条数为: $count"
lotus mpool pending --local > pending.txt
wallet=`cat pending.txt |grep -i From|head -n1|awk '{print $2}'|tr -d '",'`
nonce=`cat pending.txt |grep Nonce|head -n 1|awk '{print $2}'|tr -d ,`
premium=$(./mpool.py $wallet $nonce)
feecap=$(./calc_feecap.py)
lotus mpool replace --gas-feecap $feecap --gas-premium $premium  $wallet $nonce
date
