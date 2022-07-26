#!/bin/bash
set -x
# 自定义变量

echo "1" > old_nonce.txt
lotus mpool pending --local > pending.txt
wallet=`cat pending.txt |grep -i From|head -n1|awk '{print $2}'|tr -d '",'`
nonce=`cat pending.txt |grep Nonce|head -n 1|awk '{print $2}'|tr -d ,`
t=0
trigger=1
stuck_max=$trigger


while true
do
date
inter=15
old_nonce=`cat old_nonce.txt`
count=`lotus mpool pending --local|grep Nonce|wc -l`

if [ $count -lt $stuck_max ] || [ -z $count ];then
        echo "没有消息卡住"
        date
        stuck_max=$trigger
        sleep 30
        continue
else
        stuck_max=1
fi

lotus mpool pending --local > pending.txt
wallet=`cat pending.txt |grep -i From|head -n1|awk '{print $2}'|tr -d '",'`
nonce=`cat pending.txt |grep Nonce|head -n 1|awk '{print $2}'|tr -d ,`

if [ $nonce == $old_nonce  ]
then
        sleep 5
        t=$(($t+5))
else
        premium=$(./mpool.py $wallet $nonce)
        echo $premium
        feecap=$(./calc_feecap.py)
        if [ $feecap -lt 2500000000 ]
        then
            lotus mpool replace --auto $wallet $nonce
        else
            lotus mpool replace --gas-feecap $feecap --gas-premium $premium  $wallet  $nonce
        fi

        if [ $? == 0 ];then
            echo $nonce > old_nonce.txt
            date
            t=0
            sleep $inter
        else
                sleep 3
                continue
        fi
fi
echo "t is:$t"
if [ $t -ge 600 ]
then
        echo "消息超过10分钟没上链，触发2次疏通"
        premium=$(./mpool.py $wallet $nonce)
        feecap=$(./calc_feecap.py)
        if [ $feecap -lt 2500000000 ]
        then
            lotus mpool replace --auto $wallet $nonce
        else
            lotus mpool replace --gas-feecap $feecap --gas-premium $premium  $wallet  $nonce
        fi
        date
        t=0
        sleep $inter
fi
done
