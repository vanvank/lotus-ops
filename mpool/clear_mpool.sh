#!/bin/bash
  2 set -x
  3 echo "1" > old_nonce.txt
  4 wallet=f3rislef2hebz4qt6rsmcrentgtn66jelxi2r6t4i7oot4gknwsfihoasfz24kiwqd64k257xldbftgwxnlnba
  5 t=0
  6 trigger=50
  7 stuck_max=$trigger
  8 while true
  9 do
 10 date
 11 #inter=`cat inter.txt`
 12 inter=15
 13 old_nonce=`cat old_nonce.txt`
 14 count=`lotus mpool pending --local|grep Nonce|wc -l`
 15 if [ $count -lt $stuck_max ] || [ -z $count ];then
 16         echo "没有消息卡住"
 17         date
 18         stuck_max=$trigger
 19         #break
 20         sleep 30
 21         continue
 22 else
 23         stuck_max=1
 24 fi
 25
 26 nonce=`lotus mpool pending --local|grep Nonce|head -n1|awk '{print $2}'|tr -d ,`
 27
 28 if [ $nonce == $old_nonce  ]
 29 then
 30         sleep 5
 31         t=$(($t+5))
 32 else
 33         premium=$(./mpool.py $wallet)
 34         echo $premium
 35         #lotus mpool replace --auto $wallet $nonce
 36         #lotus mpool replace --gas-feecap 5200000000 --gas-premium $premium --gas-limit 51104935 $wallet  $nonce
 37         lotus mpool replace --gas-feecap 5200000000 --gas-premium $premium $wallet  $nonce
            #lotus mpool replace --gas-feecap 100000000000 --gas-premium $premium $wallet  $nonce
 39         if [ $? == 0 ];then
 40             echo $nonce > old_nonce.txt
 41             date
 42             t=0
 43             sleep $inter
 44         else
 45                 sleep 3
 46                 continue
 47         fi
 48 fi
 49 echo "t is:$t"
 50 if [ $t -ge 1200 ]
 51 then
 52         echo "消息超过20分钟没上链，触发2次疏通"
 53         lotus mpool replace --gas-feecap 6200000000 --gas-premium $premium  $wallet  $nonce
 54         date
 55         t=0
 56         sleep $inter
 57 fi
 58 done
