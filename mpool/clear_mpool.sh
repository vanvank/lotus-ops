#!/bin/bash
set -x
t=0
echo "1" > old_nonce.txt
wallet=f3rislef2hebz4qt6rsmcrentgtn66jelxi2r6t4i7oot4gknwsfihoasfz24kiwqd64k257xldbftgwxnlnba
while true
do
date
#inter=`cat inter.txt`
inter=15
old_nonce=`cat old_nonce.txt`
count=`lotus mpool pending --local|grep Nonce|wc -l`
if [ $count -lt 1 ] || [ -z $count ];then
        echo "没有消息卡住"
        date
        sleep 30
        continue
fi
#if [ $count -lt 40 ];then
#       break
#fi

nonce=`lotus mpool pending --local|grep Nonce|head -n1|awk '{print $2}'|tr -d ,`
if [ $nonce == $old_nonce  ]
then
        sleep 5
else
        premium=$(./mpool.py $wallet)
        echo $premium
        #lotus mpool replace --auto $wallet $nonce
        lotus mpool replace --gas-feecap 5200000000 --gas-premium $premium --gas-limit 76104935 $wallet  $nonce
        if [ $? == 0 ];then
            echo $nonce > old_nonce.txt
            date
            sleep $inter
        else
                sleep 3
                continue
        fi
fi
done
