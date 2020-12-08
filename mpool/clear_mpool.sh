#!/bin/bash
set -x
watllet_address="XXXXXX"
t=0
echo "1" > old_nonce.txt

while true
do
date
inter=5
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
        if [ $? == 0 ];then
            echo $nonce > old_nonce.txt
            date
            t=0
            sleep $inter
        else
                echo "请调整premium的值"
                break
        fi
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
