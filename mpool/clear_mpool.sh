#!/bin/bash
set -x
watllet_address="XXXXXX"
t=0

while true
do
date
inter=`cat inter.txt`
old_nonce=`cat old_nonce.txt`
count=`lotus mpool pending --local|grep Nonce|wc -l`
if [ $count -lt 1 ] || [ -z $count ];then
        echo "没有消息卡住"
        date
        sleep 30
        continue
fi
nonce=`lotus mpool pending --local|grep Nonce|head -n1|awk '{print $2}'|tr -d ,`
if [ $nonce == $old_nonce  ]
then
        sleep 15
        t=$(($t+1))
else
        lotus mpool replace --auto $wallet_address $nonce
        date
        echo $nonce > old_nonce.txt
        t=0
        sleep $inter
fi
echo "t is:$t"
if [ $t -ge 120 ]
then
        lotus mpool replace --auto $wallet_address $nonce
        date
        sleep $inter
        t=0
fi
done
