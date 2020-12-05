#!/bin/bash
set -x
wallet=f3risXXXX
nonces=`lotus mpool pending --local|grep Nonce|head -n $1|awk '{print $2}'|tr -d ,`
for nonce in $nonces
do
        lotus mpool replace --gas-feecap 5000000000 --gas-premium 129556 --gas-limit 76104935 $wallet  $nonce
        date
done
