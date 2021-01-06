#!/bin/bash
set -x
wallet=f3rislef2hebz4qt6rsmcrentgtn66jelxi2r6t4i7oot4gknwsfihoasfz24kiwqd64k257xldbftgwxnlnba
count=`lotus mpool pending --local|grep Nonce|wc -l`
echo "总共卡住的消息条数为: $count"
nonces=`lotus mpool pending --local|grep Nonce|head -n $1|awk '{print $2}'|tr -d ,`
for nonce in $nonces
do
        #lotus mpool replace --auto f3rislef2hebz4qt6rsmcrentgtn66jelxi2r6t4i7oot4gknwsfihoasfz24kiwqd64k257xldbftgwxnlnba $nonce
        #echo "lotus mpool replace --gas-feecap 4500000000 --gas-premium 129280 --gas-limit 76104935 $wallet  $nonce"
        premium=$(./mpool.py $wallet)
        lotus mpool replace --gas-feecap 5000000000 --gas-premium $premium  $wallet $nonce
        #lotus mpool replace --gas-feecap 4000000000 --gas-premium 158178  --gas-limit 50352653 $wallet $nonce
        date
done
