#!/bin/bash
set -x
t=0
inter=`cat inter.txt`
while true
do
date
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
        lotus mpool replace --auto f3rislef2hebz4qt6rsmcrentgtn66jelxi2r6t4i7oot4gknwsfihoasfz24kiwqd64k257xldbftgwxnlnba $nonce
        date
        echo $nonce > old_nonce.txt
        t=0
        sleep $inter
fi
echo "t is:$t"
if [ $t -ge 120 ]
then
        lotus mpool replace --auto f3rislef2hebz4qt6rsmcrentgtn66jelxi2r6t4i7oot4gknwsfihoasfz24kiwqd64k257xldbftgwxnlnba $nonce
        date
        sleep $inter
        t=0
fi
done
