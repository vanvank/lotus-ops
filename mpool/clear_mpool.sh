#!/bin/bash
set -x
echo "1" > old_nonce.txt
wallet=f3rislef2hebz4qt6rsmcrentgtn66jelxi2r6t4i7oot4gknwsfihoasfz24kiwqd64k257xldbftgwxnlnba
t=0
trigger=50
stuck_max=$trigger
while true
do
date
#inter=`cat inter.txt`
inter=15
old_nonce=`cat old_nonce.txt`
count=`lotus mpool pending --local|grep Nonce|wc -l`
if [ $count -lt $stuck_max ] || [ -z $count ];then
        echo "没有消息卡住"
        date
        stuck_max=$trigger
        #break
        sleep 30
        continue
else
        stuck_max=1
fi

nonce=`lotus mpool pending --local|grep Nonce|head -n1|awk '{print $2}'|tr -d ,`

if [ $nonce == $old_nonce  ]
then
        sleep 5
        t=$(($t+5))
else
        premium=$(./mpool.py $wallet)
        echo $premium
        feecap=$(./calc_feecap.py)
        lotus mpool replace --gas-feecap $feecap --gas-premium $premium $wallet $nonce

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
if [ $t -ge 1200 ]
then
        echo "消息超过20分钟没上链，触发2次疏通"
        premium=$(./mpool.py $wallet)
        feecap=$(./calc_feecap.py)
        lotus mpool replace --gas-feecap $feecap --gas-premium $premium  $wallet  $nonce
        date
        t=0
        sleep $inter
fi
done
